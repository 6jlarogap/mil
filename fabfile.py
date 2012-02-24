from __future__ import with_statement
from fabric.api import *
from fabric.contrib.console import confirm

@hosts(['youmemory.org'])
def deploy():
    local('git push')
    with cd('/home/www-data/django/mil/'):
        run('sudo -u www-data git pull')
        run('./manage.py migrate')
        run('sudo /etc/init.d/apache2 reload')

    deploy_sev()

@hosts(['sev-test.bsuir.by'])
def deploy_sev():
    local('git push')
    with cd('/opt/mil/contrib/'):
        run('sudo sh ./update-online.sh')
