import datetime
from django.db.models.base import Model
import redis

from django.conf import settings
from django.db import models

pool = redis.ConnectionPool(host='localhost', port=6379, db=settings.REDIS_DB)

class Redis():
    def __init__(self):
        self.db = redis.Redis(connection_pool=pool)

    def date_key(self, date):
        return date.strftime('%d-%m-%Y')

    def put_person(self, person):
        pipe = self.db.pipeline()

        burial_id = person.burial_id

        pipe.incr('cemetery:burial:%s:known' % burial_id)
        pipe.incr('cemetery:burial:%s:all' % burial_id)
        pipe.incr('cemetery:burial:%s:category:%s' % (burial_id, person.deadman_category_id))
        pipe.incr('cemetery:burial:%s:cause:%s' % (burial_id, person.death_cause_id))

        pipe.execute()

    def known_for_burial(self, burial):
        if isinstance(burial, models.Model):
            pk = burial.pk
        else:
            pk = burial
        return int(self.db.get('cemetery:burial:%s:known' % pk) or 0)

    def all_for_burial(self, burial):
        if isinstance(burial, models.Model):
            pk = burial.pk
        else:
            pk = burial
        return int(self.db.get('cemetery:burial:%s:all' % pk) or 0)

    def unknown_for_burial(self, burial):
        if isinstance(burial, models.Model):
            pk = burial.pk
        else:
            pk = burial
        return int(self.db.get('cemetery:burial:%s:unknown' % pk) or 0)

    def known_for_burial_list(self, burials):
        burial_pks = not isinstance(burials, list) and burials.order_by().values_list('pk', flat=True) or burials
        return sum([self.known_for_burial(b) for b in burial_pks], 0)

    def unknown_for_burial_list(self, burials):
        burial_pks = not isinstance(burials, list) and burials.order_by().values_list('pk', flat=True) or burials
        return sum([self.unknown_for_burial(b) for b in burial_pks], 0)

    def known_for_burial_list_and_cat(self, burials, cat):
        burial_pks = not isinstance(burials, list) and burials.order_by().values_list('pk', flat=True) or burials
        known = sum([int(self.db.get('cemetery:burial:%s:category:%s' % (b, cat.pk)) or 0) for b in burial_pks], 0)
        unknown = sum([int(self.db.get('cemetery:burial:%s:category:%s:unknown' % (b, cat.pk)) or 0) for b in burial_pks], 0)
        return known + unknown

    def known_for_burial_list_and_cause(self, burials, cause):
        burial_pks = isinstance(burials, list) and isinstance(burials[0], Model) and [b.pk for b in burials] or burials
        return sum([int(self.db.get('cemetery:burial:%s:cause:%s' % (b, cause.pk)) or 0) for b in burial_pks], 0)

    def clear_all(self):
        self.db.flushdb()
