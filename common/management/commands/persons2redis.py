import sys, time

from optparse import make_option

from django.core.management.base import BaseCommand, CommandError
from django.conf import settings
from django.db import models
from django import db

from common.models import Person

import cemetery_redis

class Command(BaseCommand):
    option_list = BaseCommand.option_list + (
        make_option('-s', '--step', action='store', dest='step'),
        make_option('-o', '--offset', action='store', dest='offset'),
        )

    def handle(self, *args, **options):
        r = cemetery_redis.Redis()

        persons = Person.objects.all()

        lim1 = persons.count()

        if options.get('step'):
            STEP = int(options['step'])
        else:
            STEP = 1000

        if options.get('offset'):
            i = int(options.get('offset'))
        else:
            i = 0

            r.clear_all()

        max_person = i
        persons = persons.select_related()
        print 'Persons: ', lim1
        while i < lim1:
            for p in persons[i:i+STEP]:
                r.put_person(p)
                max_person += 1
            i += STEP
            db.reset_queries()

            print "Step: %s (%.2f%%)" % (i, float(i)/float(lim1)*100)

        print 'Finished'
        print 'To resume call script with --offset=%s' % max_person