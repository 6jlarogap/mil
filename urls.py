# -*- coding: utf-8 -*-
from django.conf.urls.defaults import patterns, include, url
from django.contrib import admin
from django.conf import settings

from common.views import *

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', 'common.views.persons'),
    url(r'^persons/', 'common.views.persons'),
    url(r'^person/(?P<obj>.{36})/$', person, name='person'),                                   # Карточка воина
    url(r'^burials/', 'common.views.burials'),
    url(r'^burial/(?P<obj>.{36})/$', burial, name='burial'),                    # Карточка захоронение
    url(r'^chaining/', include('smart_selects.urls')),
)

