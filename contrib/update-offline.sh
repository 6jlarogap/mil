#!/bin/sh

cp -R ../../mil /home/django/projects

cd /home/django/projects/mil/

python ./manage.py syncdb
python ./manage.py migrate

# Start django daemon
/etc/init.d/django restart

echo "Finished"
