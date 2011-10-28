#!/usr/bin/env python
from django.core.management import execute_manager
import imp

import os, sys

for search in ['.', '..']:
    activate_this = os.path.join(search. '.env', 'bin', 'activate_this.py')
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))
        break

try:
    imp.find_module('settings') # Assumed to be in the same directory.
except ImportError:
    import sys
    sys.stderr.write("Error: Can't find the file 'settings.py' in the directory containing %r. It appears you've customized things.\nYou'll have to run django-admin.py, passing it your settings module.\n" % __file__)
    sys.exit(1)

import settings

if __name__ == "__main__":
    execute_manager(settings)
