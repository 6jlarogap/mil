from __future__ import with_statement
from fabric.api import *
from fabric.contrib.console import confirm

@hosts(['youmemory.org'])
def deploy():
    local('git push')
    with cd('/home/www-data/django/mil/'):
        sudo('sudo -u www-data git pull')
        run('./manage.py migrate')
        sudo('/etc/init.d/apache2 reload')

@hosts(['soul@172.16.0.16'])
def deploy_sev():
    local('git push')
    with cd('/opt/mil/contrib/'):
        sudo('sh ./update-online.sh')
