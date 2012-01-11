import datetime
import redis

from django.conf import settings

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

    def clear_all(self):
        self.db.flushdb()
