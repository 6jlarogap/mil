#!/bin/sh

git reset --hard
git pull

cd /home/django/projects/mil
git reset --hard
git pull

python ./manage.py syncdb
python ./manage.py migrate

# Start django daemon
/etc/init.d/django restart

echo "Finished"