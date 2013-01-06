#!/bin/sh

cp -R ../../mil /home/django/projects

cd /home/django/projects/mil/

python ./manage.py syncdb
python ./manage.py migrate
python ./manage.py collectstatic --noinput

# Start django daemon
/etc/init.d/django restart
supervisorctl restart all

echo "Finished"
