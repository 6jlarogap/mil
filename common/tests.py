# coding: utf-8

from django.test import TestCase

from common.models import geo_name

class GeoTest(TestCase):
    def test_geo_name(self):
        self.assertEqual(geo_name(u'большие бугры'), u'Большие Бугры')
        self.assertEqual(geo_name(u'г.Москва'), u'г. Москва')
        self.assertEqual(geo_name(u'ул.Ленина'), u'ул. Ленина')
        self.assertEqual(geo_name(u'пр. обуховской обороны'), u'пр. Обуховской Обороны')

