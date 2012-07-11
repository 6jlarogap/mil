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
from cemetery_redis import Redis

try:
    connection = psycopg2.connect(database=sys.argv[1], user=sys.argv[2], password=sys.argv[3])
except IndexError:
    print 'Arguments are: dbname username password'
else:
    cursor = connection.cursor()
    sql = 'SELECT id, quantitybury, quantityknown, quantityunknown, quantitysoldier, quantityinsurrectionist, quantityvictim, quantityother FROM grave;'
    r = Redis()
    cnt = Burial.objects.all().count()

    cats = [
        DeadmanCategory.objects.get(name=u'Военнослужащий'),
        DeadmanCategory.objects.get(name=u'Участник сопротивления'),
        DeadmanCategory.objects.get(name=u'Жертва войны'),
        DeadmanCategory.objects.get(name=u'Другие'),
    ]

    cursor.execute(sql)
    for i,d in enumerate(cursor.fetchall()):
        b = Burial.objects.get(obid=d[0])

        # Надо пройтись по существующим данным и внести "порядок"
        # с неизвестными
        z = int(d[3])

        if z:
            all = map(int, d[4:])

            unk = [0,0,0,0]
            sum = 0
            for i, a in enumerate(all):
                unk[i] = 0
                sum += all[i]

            # fool-proof
            if sum < z: z = sum

            for i,a in enumerate(all):
                if not all[i]:
                    unk[i] = 0
                elif z > all[i]:
                    unk[i] = all[i]
                    all[i] = 0
                else:
                    unk[i] = z
                    all[i] -= z
                z -= unk[i]
                if z <= 0: break
            d = d[:4] + tuple(all) + tuple(unk)
        else:
            d += (0, 0, 0, 0)


        for j,c in enumerate(cats):
            try:
                bc = BurialCategory.objects.get(burial=b, category=c)
            except BurialCategory.DoesNotExist:
                BurialCategory.objects.create(burial=b, category=c, custom_known=(d[4 + j] or 0) - (d[8 + j] or 0), unknown=d[8 + j] or 0)
            else:
                bc.custom_known = (d[4 + j] or 0) - (d[8 + j] or 0)
                bc.unknown = (d[8 + j] or 0)
                bc.save()

            r.db.set('cemetery:burial:%s:category:%s' % (b.pk, c.pk), (d[4 + j] or 0))
            r.db.set('cemetery:burial:%s:category:%s:unknown' % (b.pk, c.pk), d[8 + j] or 0)

        r.db.set('cemetery:burial:%s:all' % b.pk, d[1])
        r.db.set('cemetery:burial:%s:known' % b.pk, d[2])
        r.db.set('cemetery:burial:%s:unknown' % b.pk, d[3])

        if i % 500 == 0:
            print 'Processsed', i, 'of', cnt