# -*- coding: utf-8 -*-

from settings import *

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = ()

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
#        'NAME': 'cemetery_mil',                      # Or path to database file if using sqlite3.
        'NAME': 'mil',                      # Or path to database file if using sqlite3.
        'USER': 'ilvar',                      # Not used with sqlite3.
        'PASSWORD': 'maza8947',                  # Not used with sqlite3.
        'HOST': '',                      # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
    }
}

SOUTH_TESTS_MIGRATE = False

INTERNAL_IPS = ['127.0.0.1', ]

# CACHE_BACKEND = 'dummy:///'
CACHE_BACKEND = 'locmem:///'

REDIS_DB = 8

DEBUG_TOOLBAR_CONFIG = {'INTERCEPT_REDIRECTS': False}

DEFAULT_FROM_EMAIL = 'ilvar@mail.ru'