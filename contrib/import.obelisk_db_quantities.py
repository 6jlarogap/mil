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
        r.db.set('cemetery:burial:%s:all' % b.pk, d[1])
        r.db.set('cemetery:burial:%s:known' % b.pk, d[2])
        r.db.set('cemetery:burial:%s:unknown' % b.pk, d[3])

        for j,c in enumerate(cats):
            try:
                BurialCategory.objects.get(burial=b, category=c)
            except BurialCategory.DoesNotExist:
                BurialCategory.objects.create(burial=b, category=c, custom_known=d[4 + j] or 0)

        if i % 500 == 0:
            print 'Processsed', i, 'of', cnt