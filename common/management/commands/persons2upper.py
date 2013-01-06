import sys, time

from optparse import make_option

from django.core.management.base import BaseCommand, CommandError
from django.conf import settings
from django.db import models
from django import db

from common.models import Person

import cemetery_redis

class Command(BaseCommand):
    def handle(self, *args, **options):
        persons = Person.objects.all().only('first_name', 'last_name', 'patronymic')

        cnt = persons.count()
        i = 0

        for p in persons:
            if p.last_name != p.last_name.upper() or p.first_name != p.first_name.upper() or p.patronymic != p.patronymic.upper():
                p.last_name = p.last_name.upper()
                p.first_name = p.first_name.upper()
                p.patronymic = p.patronymic.upper()
                p.save()

            i += 1

            if i % 1000 == 0:
                db.reset_queries()

                print "Step: %s (%.2f%%)" % (i, float(i)/float(cnt)*100)

        print 'Finished'
