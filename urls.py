# -*- coding: utf-8 -*-
from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from common.forms import LoginForm
from common.views import *
#from django.contrib.auth.views import login

#from django.conf.urls.defaults import *
#from django.conf.urls.static import static
#from django.conf import settings
#from common.views import *
#from common.forms import LoginForm
#from django.contrib import admin
#from django.contrib.auth.views import login

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'mil.views.home', name='home'),
    # url(r'^mil/', include('mil.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', 'common.views.persons'),
    url(r'^persons/', 'common.views.persons'),
    url(r'^person/(?P<obj>.{36})/$', person),                                      # Карточка с захоронением
    url(r'^burials/', 'common.views.burials'),
    url(r'^burial/(?P<obj>.{36})/$', burial),                                      # Карточка с захоронением
#    url(r'^accounts/login/$', login,                                           # Страница логина пользователя
#        {'template_name': 'registration/login.html', 
#         'authentication_form': LoginForm}, name='auth_login'),
#    (r'^accounts/', include('registration.urls')),                             # Регистрация
)
