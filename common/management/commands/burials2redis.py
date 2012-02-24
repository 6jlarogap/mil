import sys, time

from optparse import make_option

from django.core.management.base import BaseCommand, CommandError
from django.conf import settings
from django.db import models
from django import db

from common.models import Person, Burial, DeathCause

import cemetery_redis

class Command(BaseCommand):
    option_list = BaseCommand.option_list + (
        make_option('-o', '--offset', action='store', dest='offset'),
    )

    def handle(self, *args, **options):
        r = cemetery_redis.Redis()

        burials = Burial.objects.all()

        lim1 = burials.count()

        if options.get('step'):
            STEP = int(options['step'])
        else:
            STEP = 100

        if options.get('offset'):
            i = int(options.get('offset'))
        else:
            i = 0

        max_burial = i
        burials = burials.select_related()

        death_causes = list(DeathCause.objects.all())

        print 'Burials: ', lim1
        while i < lim1:
            for b in burials[i:i+STEP]:
                cats = list(b.burial_categories.all())
                if cats:
                    known = sum([c.custom_known or c.known for c in cats], 0)
                    if not known:
                        known = b.person_set.count()

                    r.db.set('cemetery:burial:%s:known' % b.pk, known)

                    unknown = sum([c.unknown for c in cats], 0)
                    if unknown:
                        r.db.set('cemetery:burial:%s:unknown' % b.pk, unknown)

                    if known or unknown:
                        r.db.set('cemetery:burial:%s:all' % b.pk, known + unknown)

                    for c in cats:
                        all = c.known + c.unknown
                        old = r.db.get('cemetery:burial:%s:category:%s' % (b.pk, c.category.pk))
                        if all and not old:
                            r.db.set('cemetery:burial:%s:category:%s' % (b.pk, c.category.pk), all)

                for dc in death_causes:
                    all = Person.objects.filter(burial=b, death_cause=dc).count()
                    old = r.db.get('cemetery:burial:%s:cause:%s' % (b.pk, dc.pk))
                    if all and not old:
                        r.db.set('cemetery:burial:%s:cause:%s' % (b.pk, dc.pk), all)

                if known or unknown or all:
                    print b.pk, known, unknown, all

                max_burial += 1
            i += STEP
            db.reset_queries()

            print "Step: %s (%.2f%%)" % (i, float(i)/float(lim1)*100)

        print 'Finished'
        print 'To resume call script with --offset=%s' % max_burial