#!/usr/bin/python
# -*- coding: utf-8 -*-

SYSPATH = "/home/robotd/src/mil"
import sys, os
sys.path.append(SYSPATH)
from django.core.management import setup_environ
import settings
setup_environ(settings)

from django.conf import settings
from django.db import transaction
from common.models import *
from django.core.exceptions import ObjectDoesNotExist
from django import db

import csv
import datetime
import re

CSV_ENCODING = 'utf8'

@transaction.commit_manually
def importSettlement():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/settlement.rural.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
#"id","text","districtid","text"
                (str_id, text, city_id, ruralname) = l
                # ID записи.
                try:
                    str_id = int(str_id)
                except:
                    str_id = None
#                print str_id 

                # Текст settlement 
                if text != "":
                    text = text.decode(CSV_ENCODING).strip().capitalize()
                else:
                    text = None

                # city ID.
                try:
                    city = GeoCity.objects.get(obid = int(city_id))
                except:
                    city = None

                    # ruralname 
                    if ruralname != "":
                        if text:
                            text = "%s, %s" % (text, ruralname.decode(CSV_ENCODING).strip().capitalize())
                        else:
                            text = ruralname.decode(CSV_ENCODING).strip().capitalize()
                    else:
                        print 'neither city nor rural', str_id

                if city or text:
                    bps = bbs = True
                    ps = Person.objects.filter(oblocationid = str_id)
                    if ps.count() > 0:
                        for p in ps:
                            lb = LocationBirth(person = p)
                            if city:
                                lb.city = city
                            if text:
                                lb.info = text
                            lb.save()
                    else:
                        bps = False

                    bs = Burial.objects.filter(oblocationid = str_id)
                    if bs.count() > 0:
                        for b in bs:
                            lb = LocationBurial(burial = b)
                            if city:
                                lb.city = city
                            if text:
                                lb.info = text
                            lb.save()
                    else:
                        bbs = False

                    if (not bps) and (not bbs):
                        print "no bps no bbs", str_id
                else:
                    print "no city no text", str_id



            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importPerson():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/persons.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (obid, ln, fn, ptrc, rankid, birthyear, 
                        timedeath, deathcauseid, burid, locationid, strmilunit, 
                        strpost, infosourceid, deadmancategoryid, strdocumentsplace, info ) = l
                str_comment = u''

                # ID записи.
                try:
                    obid = int(obid)
                except:
                    obid = None
#                print obid

                # Фамилия 
                if ln == "":
                    ln = u"неизвестно"  # Если в базе был Null
#                    print ln
                else:
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)
#                print ln

                # Имя 
                if fn == "":
                    fn = u""
#                    print fn
                else:
                    fn = fn.decode(CSV_ENCODING).strip().capitalize()
                    fn = re.sub(r'ё', r'е', fn)
                    fn = re.sub(r'Ё', r'Е', fn)
#                print ln

                # Отчество 
                if ptrc == "":
                    ptrc = u""
#                    print ptrc
                else:
                    ptrc = ptrc.decode(CSV_ENCODING).strip().capitalize()
                    ptrc = re.sub(r'ё', r'е', ptrc)
                    ptrc = re.sub(r'Ё', r'Е', ptrc)
#                print ln

                # Дата рождения
                try:
                    birthyear = datetime.datetime.strptime(birthyear[0:4], "%Y")
                except ValueError:
                    try:
                        birthyear = datetime.datetime.strptime(birthyear[0:10], "%d.%m.%Y")
                    except:
                        try:
                            birthyear = datetime.datetime.strptime(birthyear[0:7], "%m.%Y")
                        except:
                            if birthyear.decode(CSV_ENCODING).strip() != u'':
                                str_comment = "birthyear=%s, %s" % (birthyear.decode(CSV_ENCODING).strip(), str_comment)
#                                print str_comment
                            birthyear = None
#                print birthyear

                # Дата смерти
                # full date
                try:
                    timedeath = datetime.datetime.strptime(timedeath[0:10], "%m.%d.%Y")
                except ValueError:
                    try:
                        timedeath = datetime.datetime.strptime(timedeath[0:10], "%d.%m.%Y")
                    except ValueError:
                        try:
                            timedeath = datetime.datetime.strptime(timedeath[0:8], "%d.%m.%y")
                        except ValueError:
                            try:
                                timedeath = datetime.datetime.strptime(timedeath[0:8], "%m/%d/%y")
                            except ValueError:
                                try:
                                    timedeath = datetime.datetime.strptime(timedeath[0:10], "%m/%d/%Y")
                                except ValueError:
                # month and year
                                    try:
                                        timedeath = datetime.datetime.strptime(timedeath[3:10], "%m.%Y")
                                    except:
                                        try:
                                            timedeath = datetime.datetime.strptime(timedeath[1:8], "%m.%Y")
                                        except:
                                            try:
                                                timedeath = datetime.datetime.strptime(timedeath[3:8], "%m.%y")
                                            except:
                                                try:
                                                    timedeath = datetime.datetime.strptime(timedeath[0:5], "%m.%y")
                                                except:
                # year only
                                                    try:
                                                        timedeath = datetime.datetime.strptime(timedeath[0:4], "%Y")
                                                    except:
                                                        try:
                                                            timedeath = datetime.datetime.strptime(timedeath[6:10], "%Y")
                                                        except:
                                                            try:
                                                                timedeath = datetime.datetime.strptime(timedeath[4:8], "%Y")
                                                            except:
                                                                try:
                                                                    timedeath = datetime.datetime.strptime(timedeath[3:7], "%Y")
                                                                except:
                                                                    try:
                                                                        timedeath = datetime.datetime.strptime(timedeath[2:6], "%Y")
                                                                    except:
                                                                        if timedeath.decode(CSV_ENCODING).strip() != u'':
                                                                            str_comment = "timedeath=%s, %s" % (timedeath.decode(CSV_ENCODING).strip(), str_comment)
#                                                                            print str_comment
                                                                        timedeath = None
#                print timedeath

                # deathcause ID.
                try:
                    dc = DeathCause.objects.get(obid = int(deathcauseid))
                except:
                    dc = None

                # burial ID.
                try:
                    burial = Burial.objects.get(obid = int(burid))
                except:
                    burial = None

                # Место службы 
                if strmilunit != "":
                    strmilunit = strmilunit.decode(CSV_ENCODING).strip().capitalize()
                    try:
                        mu = MilitaryUnit.objects.get(name = strmilunit)
                    except ObjectDoesNotExist:
                        mu = MilitaryUnit(name = strmilunit)
                        mu.save()
                else:
                    mu = None

                # rank ID.
                try:
                    rank = Rank.objects.get(obid = int(rankid))
                except:
                    rank = None


                # Должность 
                if strpost != "":
                    strpost = strpost.decode(CSV_ENCODING).strip().capitalize()
                    try:
                        post = Post.objects.get(name = strpost)
                    except ObjectDoesNotExist:
                        post = Post(name = strpost)
                        post.save()
                else:
                    post = None

                # Источник информации 
                try:
                    infosource = InformationSource.objects.get(obid = int(infosourceid))
                except:
                    infosource = None

                # Категория погибшего
                try:
                    deadmancategory = DeadmanCategory.objects.get(obid = int(deadmancategoryid))
                except:
                    deadmancategory = None

                # Место нахождения документов 
                if strdocumentsplace != "":
                    strdocumentsplace = strdocumentsplace.decode(CSV_ENCODING).strip().capitalize()
                    try:
                        docplace = DocumentsPlace.objects.get(name=strdocumentsplace)
                    except ObjectDoesNotExist:
                        docplace = DocumentsPlace(name=strdocumentsplace)
                        docplace.save()
                else:
                    docplace = None

                # доп инфо 
                if info != "":
                    info = info.decode(CSV_ENCODING).strip()
#                    print info
                else:
                    info = u""

#                (obid, ln, fn, ptrc, rankid, birthyear, 
#                        timedeath, deathcauseid, burid, locationid, strmilunit, 
#                        strpost, infosourceid, deadmancategoryid, strdocumentsplace, info ) = l


                p = Person()
                if obid:
                    p.obid = obid
#                print obid, p.obid

                if ln:
                    p.last_name = ln
#                print ln, p.last_name

                if fn:
                    p.first_name = fn
#                print fn, p.first_name

                if ptrc:
                    p.patronymic = ptrc
#                print ptrc, p.patronymic

                p.birth_date = birthyear
#                print birthyear, p.birth_date

                p.death_date = timedeath
#                print timedeath, p.death_date

                if dc:
                    p.death_cause = dc
#                    print "deathcause", deathcauseid, p.death_cause.name

                try:
                    p.oblocationid = int(locationid)
#                    print "location", locationid, p.oblocationid
                except:
                    pass

                if infosource:
                    p.information_source = infosource
#                    print "infosource", infosourceid, p.information_source.name

                if deadmancategory:
                    p.deadman_category = deadmancategory
#                    print "deadcetegory", deadmancategoryid, p.deadman_category.name

                if docplace:
                    p.documents_place = docplace
#                    print "docplace", strdocumentsplace, p.documents_place.name

                if str_comment != u'':
                    info = "%s; %s" % (str_comment, info)
#                    print "strcomment", str_comment

                if info != u'':
                    p.info = info
#                    print "info", info, p.info

                p.save()
#                print p.uuid

                if burial:
                    pb = PersonBurial.objects.create(person=p, burial=burial)

                if mu or rank or post:
                    pd = PersonDuty(person=p)
                    if mu:
                        pd.unit = mu
                    if rank:
                        pd.rank = rank
                    if post:
                        pd.post = post
                    pd.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importBurial():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/burials.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (obid, passportid, btypeid, burdate, locationid, cityvarname, milconfid, qunknown, datememorial, info, dategosznak, isacc) = l
                str_comment = u''
                # ID записи.
                obid = int(obid)
#                print obid
                # passport ID.
                passportid = int(passportid)
#                print passportid
                # btype ID.
                btypeid = int(btypeid)
#                print btypeid

                
                # Дата захоронения
                bburdate = True
                try:
                    burdate = datetime.datetime.strptime(burdate[0:4], "%Y")
                except ValueError:
                    try:
                        burdate = datetime.datetime.strptime(burdate[0:10], "%d.%m.%Y")
                    except:
                        try:
                            burdate = datetime.datetime.strptime(burdate[0:7], "%m.%Y")
                        except:
                            bburdate = False
                            if burdate.decode(CSV_ENCODING).strip() != u'':
                                str_comment = "burdate=%s, %s" % (burdate.decode(CSV_ENCODING).strip(), str_comment)
#                                print str_comment
#                print burdate

                # cityvarname
                if cityvarname != "N":
                    cityvarname = cityvarname.decode(CSV_ENCODING).strip().capitalize()
                else:
                    cityvarname = u''
#                print cityvarname

                # milconf
                milconfid = int(milconfid)
#                print milconfid

                # qunknown
                qunknown = int(qunknown)
#                print qunknown

                # memorial date
                bdatememorial = True
                try:
                    datememorial = datetime.datetime.strptime(datememorial[0:4], "%Y")
                except ValueError:
                    try:
                        datememorial = datetime.datetime.strptime(datememorial[0:10], "%d.%m.%Y")
                    except:
                        try:
                            datememorial = datetime.datetime.strptime(datememorial[0:7], "%m.%Y")
                        except:
                            bdatememorial = False
#                    except:
#                        str_comment = "datememorial=%s, %s" % (datememorial.decode(CSV_ENCODING).strip(), lstr_comment)
#                        print str_comment
#                print datememorial

                # info
                if info != "N":
                    info = info.decode(CSV_ENCODING).strip()
                else:
                    info = u''
#                print info

                # gosznak date
                bdategosznak = True
                try:
                    dategosznak = datetime.datetime.strptime(dategosznak [0:4], "%Y")
                except ValueError:
                    try:
                        dategosznak = datetime.datetime.strptime(dategosznak [0:10], "%d.%m.%Y")
                    except:
                        try:
                            dategosznak = datetime.datetime.strptime(dategosznak [0:7], "%m.%Y")
                        except:
                            bdategosznak = False
                            if dategosznak.decode(CSV_ENCODING).strip() != u'':
                                str_comment = "dategosznak=%s, %s" % (dategosznak.decode(CSV_ENCODING).strip(), str_comment)
#                                print str_comment

#                # isaccount
#                isacc = bool(isacc)
#                print isacc

                b = Burial()
                b.obid = obid
                b.passportid = passportid
                if bburdate:
                    b.date_burried = burdate
                b.qunknown = qunknown
                if bdatememorial:
                    b.date_memorial = datememorial
                if str_comment != u'':
                    b.info = "%s, %s" % (str_comment, info)
                else:
                    b.info = info
                if bdategosznak:
                    b.date_gosznak = dategosznak

                try:
                    btype = BurialType.objects.get(obid = btypeid)
                    b.burial_type = btype
                except ObjectDoesNotExist:
                    pass
#                    btype = None

                try:
                    b.oblocationid = int(locationid)
                except:
                    pass
                
                """
                try:
                    location = LocationBurial.objects.get(obid = locationid)
                    if cityvarname != u'':
                        location.info = cityvarname
                        location.save()
                    b.locationburial_set = location
                except ObjectDoesNotExist:
                    pass
#                    location = None
                """
                try:
                    milconf = MilitaryConflict.objects.get(obid = milconfid)
                    b.military_conflict = milconf
                except ObjectDoesNotExist:
                    pass
#                    milconf = None

                b.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importCity():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/city.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln, region_id) = l
                # ID записи.
                str_id = int(str_id)
                # country ID.
                region_id = int(region_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    region = GeoRegion.objects.get(obid = region_id)
                    # City
                    dk = GeoCity(region = region)
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importRegion():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/region.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln, country_id) = l
                # ID записи.
                str_id = int(str_id)
                # country ID.
                country_id = int(country_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    country = GeoCountry.objects.get(obid = country_id)
                    # Rank.
                    dk = GeoRegion(country = country)
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importCountry():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/country.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = GeoCountry()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importMilConflict():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/milconflict.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = MilitaryConflict()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importInfoSource():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/infosource.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = InformationSource()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importDeadmanCategory():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/deadmancategory.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = DeadmanCategory()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importBurialType():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/burialtype.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = BurialType()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importDeathCauses():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/deathcause.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    dk = DeathCause()
                    dk.obid = str_id
                    dk.name = ln
                    dk.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

@transaction.commit_manually
def importRanks():
    csv.register_dialect("4mysql", escapechar="\\", quoting=csv.QUOTE_ALL, doublequote=True)
    r = csv.reader(open('/home/robotd/projects/mil/data/postgres/ranks.csv', 'rb'), "4mysql")

    for l in r:
        db.reset_queries()
        if l:
            try:
                (str_id, ln) = l
                # ID записи.
                str_id = int(str_id)
                # Название.
                if ln != "N":
                    ln = ln.decode(CSV_ENCODING).strip().capitalize()
                    ln = re.sub(r'ё', r'е', ln)
                    ln = re.sub(r'Ё', r'Е', ln)

                    # Rank.
                    rank = Rank()
                    rank.obid = str_id
                    rank.name = ln
                    rank.save()

            except Exception, err_descr:
                # Откатываем транзакцию.
                transaction.rollback()
                print err_descr
            else:
                # Коммитим все.
                transaction.commit()

#importRanks()
#importDeathCauses() 
#importBurialType()
#importInfoSource()
#importDeadmanCategory()
#importMilConflict()
#importCountry()
#importRegion()
#importCity()
#importBurial()
#importPerson()
importSettlement()

