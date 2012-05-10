import sys, time

from optparse import make_option

from django.core.management.base import BaseCommand, CommandError
from django.conf import settings
from django.db import models
from django import db
from django.db.models.expressions import F

from common.models import Person, Burial, DeathCause, BurialCategory

import cemetery_redis

class Command(BaseCommand):
    def handle(self, *args, **options):
        r = cemetery_redis.Redis()
        for bc in BurialCategory.objects.exclude(custom_known=F('known')).exclude(custom_known__isnull=True):
            r.db.set('cemetery:burial:%s:category:%s' % (bc.burial_id, bc.category_id), bc.custom_known)

        print 'Finished'
