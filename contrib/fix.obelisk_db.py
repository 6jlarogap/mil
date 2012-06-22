#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os

PATH = os.path.dirname(os.path.dirname(__file__))
sys.path.append(PATH)

from django.core.management import setup_environ

import settings
setup_environ(settings)

import re
import psycopg2
import gc

from django.db import transaction
from django.core.exceptions import ObjectDoesNotExist
from django.core.files.base import ContentFile
from django import db
from django.shortcuts import _get_queryset

from common.models import *

def get_object_or_none(klass, *args, **kwargs):
    queryset = _get_queryset(klass)
    try:
        return queryset.get(*args, **kwargs)
    except queryset.model.DoesNotExist:
        return None

@transaction.commit_manually
def importUniversal(cursor, sql, creator, sql_params=None, offset=0):
    params = sql_params or []
    cursor.execute(sql, params)
    i = offset
    try:
        for l in cursor.fetchall()[offset:]:
            creator(l)
            i += 1
            if i % 5000 == 0:
                print 'Commit %s' % i
                transaction.commit()
                gc.collect()
                db.reset_queries()

    except Exception, err_descr:
        transaction.rollback()
        raise
    else:
        transaction.commit()

    db.reset_queries()

def setUnclearDate(params, name, value, str_comments):
    date = value
    date_no_month = False
    date_no_day = False

    if not date or not date.strip():
        return

    try:
        date = datetime.datetime.strptime(date[0:10], "%m.%d.%Y")
    except ValueError:
        try:
            date = datetime.datetime.strptime(date[0:10], "%d.%m.%Y")
        except ValueError:
            try:
                date = datetime.datetime.strptime(date[0:8], "%d.%m.%y")
            except ValueError:
                try:
                    date = datetime.datetime.strptime(date[0:8], "%m/%d/%y")
                except ValueError:
                    try:
                        date = datetime.datetime.strptime(date[0:10], "%m/%d/%Y")
                    except ValueError:
                        # month and year
                        date_no_day = True
                        try:
                            date = datetime.datetime.strptime(date[3:10], "%m.%Y")
                        except ValueError:
                            try:
                                date = datetime.datetime.strptime(date[1:8], "%m.%Y")
                            except ValueError:
                                try:
                                    date = datetime.datetime.strptime(date[3:8], "%m.%y")
                                except ValueError:
                                    try:
                                        date = datetime.datetime.strptime(date[0:5], "%m.%y")
                                    except ValueError:
                                        # year only
                                        date_no_month = True
                                        try:
                                            date = datetime.datetime.strptime(date[0:4], "%Y")
                                        except ValueError:
                                            try:
                                                date = datetime.datetime.strptime(date[6:10], "%Y")
                                            except ValueError:
                                                try:
                                                    date = datetime.datetime.strptime(date[4:8], "%Y")
                                                except ValueError:
                                                    try:
                                                        date = datetime.datetime.strptime(date[3:7], "%Y")
                                                    except ValueError:
                                                        try:
                                                            date = datetime.datetime.strptime(date[2:6], "%Y")
                                                        except ValueError:
                                                            if date.strip() != u'':
                                                                str_comments.append("date=%s" % date.strip())
                                                                return

    if date > datetime.datetime.now():
        date = datetime.datetime(*[t - 100 if i == 0 else t for i,t in enumerate(date.timetuple())][:6])

    params[name] = date
    params[name+'_no_month'] = date_no_month
    params[name+'_no_day'] = date_no_day

def importLocations(cursor, grave_pk):
    for city in GeoCity.objects.all().select_related():
        params = dict(
            city = city,
            municipalitet = city.municipalitet,
            district = city.district,
            region = city.region,
            country = city.country,
        )

        if not '--skip_person_locations' in sys.argv:
            ps = Person.objects.filter(oblocationid = city.obid, burial__obid = grave_pk)
            for p in ps:
                p.birth_location = SimpleLocation.objects.create(**params)
                p.save()

        if not '--skip_burial_locations' in sys.argv:
            if city.region and city.country:
                bs = Burial.objects.filter(oblocationid = city.obid, obid = grave_pk)
                for b in bs:
                    b.location = StrictLocation.objects.create(**params)
                    b.save()

def importPerson(cursor, grave_pk):
    def createPerson(l):
        str_comments = []
        try:
            p = Person.objects.get(obid=l[0])
        except Person.DoesNotExist:
            oblocationid = l[10]
            if not oblocationid or not oblocationid.isdigit():
                oblocationid = None
            params = {
                'obid': l[0],
                'oblocationid': oblocationid,
                'burial': l[8] and Burial.objects.get(obid=l[8]) or None,
                'last_name': l[1],
                'first_name': l[2],
                'patronymic': l[3],
                'deadman_category': l[13] and DeadmanCategory.objects.get(obid=l[13]) or None,
                'documents_place': l[14] and DocumentsPlace.objects.get_or_create(name=l[14])[0] or None,
                'information_source': l[12] and InformationSource.objects.get(obid=l[12]) or None,
            }
            try:
                params['death_cause'] = l[7] and DeathCause.objects.get(obid=l[7]) or None
            except DeathCause.DoesNotExist:
                pass
            setUnclearDate(params, 'birth_date', l[5], str_comments)
            setUnclearDate(params, 'death_date', l[6], str_comments)
            if l[15]:
                str_comments.append(l[15])
            params['info'] = ', '.join(str_comments)

            p = Person.objects.create(**params)

            if l[10] or l[4] or l[11]:
                pd = PersonDuty.objects.get_or_create(person=p)[0]
                if l[10] and l[10].isdigit():
                    try:
                        pd.unit = MilitaryUnit.objects.get(location__obid=l[10])
                    except MilitaryUnit.DoesNotExist:
                        pass
                if l[4] and unicode(l[4]).isdigit():
                    pd.rank = Rank.objects.get(obid=l[4])
                if l[11]:
                    pd.post = Post.objects.get_or_create(name=l[11])[0]
                pd.save()

        p.burial = Burial.objects.get(obid=grave_pk)
        p.save()

    cursor.execute('SELECT count(id) FROM bury;')
    if cursor.fetchone()[0] <= Person.objects.all().count():
        print 'Skipping Persons, there are no new items'
        transaction.commit()
        return

    importUniversal(
        cursor,
        '''SELECT
            id, surname, name, patronymic, rank, yearofbirth, timedeath, causedeath, grave, settlement,
            placeofmilitaryservice, post, sourceinfo, categorybury, locationdocuments, optionalinfo
        FROM bury WHERE grave=%s;''' % grave_pk,
        createPerson,
        offset = len(sys.argv) > 5 and int(sys.argv[5]) or 0
    )

def cleanup_db(text):
    text = text.strip().capitalize()
    text = re.sub(r'ё', r'е', text)
    text = re.sub(r'Ё', r'Е', text)
    return text

try:
    connection = psycopg2.connect(database=sys.argv[1], user=sys.argv[2], password=sys.argv[3])
except IndexError:
    print 'Arguments are: dbname username password'
else:
    cursor = connection.cursor()
    cnt = 0

    for b in Burial.objects.all():
        our_count = Person.objects.filter(burial=b).count()
        sql = 'SELECT COUNT(id) FROM bury WHERE grave=%s;' % b.obid
        cursor.execute(sql)
        obelisk_count = cursor.fetchone()[0]

        if obelisk_count > our_count:
            print 'Processing burial %s: %s > %s' % (b.obid, obelisk_count, our_count)

            importPerson(cursor, b.obid)
            print 'Persons imported'

            if not '--skip_all_locations' in sys.argv:
                importLocations(cursor, b.obid)
                print 'Location data imported'

            cnt += 1

    print 'Finished %s items' % cnt
