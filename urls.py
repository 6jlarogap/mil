# -*- coding: utf-8 -*-
from django.conf.urls.defaults import patterns, include, url
from django.contrib import admin
from django.conf import settings

from common.views import *

admin.autodiscover()

urlpatterns = patterns('common.views',
    url(r'^$', 'persons'),
    url(r'^persons/', 'persons'),
    url(r'^person/(?P<obj>.{36})/$', 'person', name='person'),                                   # Карточка воина
    url(r'^burials/', 'burials'),
    url(r'^burial/(?P<obj>.{36})/$', 'burial', name='burial'),                    # Карточка захоронение
)

urlpatterns += patterns('',
    url(r'^admin/sentry/', include('sentry.web.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^chaining/', include('smart_selects.urls')),
)