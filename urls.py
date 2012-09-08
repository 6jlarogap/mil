# -*- coding: utf-8 -*-
from django.conf.urls.defaults import patterns, include, url
from django.contrib import admin
from django.conf import settings

from common.views import *

admin.autodiscover()

urlpatterns = patterns('common.views',
    url(r'^$', 'persons'),
    url(r'^persons/$', 'persons'),
    url(r'^persons/autocomplete/$', 'persons_autocomplete', name='persons_autocomplete'),
    url(r'^person/(?P<obj>.{36})/$', 'person', name='person'),                                   # Карточка воина
    url(r'^burials/$', 'burials'),
    url(r'^import/$', 'import_xls', name='import'),
    url(r'^import2/$', 'import_xls_2', name='import2'),
    url(r'^burial/(?P<obj>.{36})/$', 'burial', name='burial'),                    # Карточка захоронение
)

urlpatterns += patterns('',
    url(r'^login/', 'django.contrib.auth.views.login', name='login'),
    url(r'^admin/sentry/', include('sentry.web.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^chaining/', include('smart_selects.urls')),
    url(r'^media/(?P<path>.*)', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),
)

if 'sentry' in settings.INSTALLED_APPS:
    urlpatterns += patterns('',
        url(r'^admin/sentry/', include('sentry.web.urls')),
    )
