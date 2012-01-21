#!/bin/sh

sh ./netinstall.sh

# User for django
adduser --disabled-password --gecos "" django
usermod -p $1$KQwQ4Rq7$CtkUF2cjpb9raBQZPjy4J0 django

# Copy project files
mkdir /home/django/projects
# cp -R ../../mil /home/django/projects
git clone --no-hardlinks ../../mil /home/django/projects/mil
mkdir -p /home/django/projects/mil/media/ofiles
chown -R www-data:www-data /home/django/projects

# Postgres
cp configs/postgres/pg_hba.conf /etc/postgresql/8.4/main/
chown postgres:postgres /etc/postgresql/8.4/main/pg_hba.conf
chmod 640 /etc/postgresql/8.4/main/pg_hba.conf
/etc/init.d/postgresql-8.4 restart

# Nginx
cp -R configs/nginx/fastcgi_params /etc/nginx/
chown root:root /etc/nginx/fastcgi_params
chmod 644 /etc/nginx/fastcgi_params
cp configs/nginx/mil /etc/nginx/sites-available/
chown root:root /etc/nginx/sites-available/mil
chmod 644 /etc/nginx/sites-available/mil
ln -s /etc/nginx/sites-available/mil /etc/nginx/sites-enabled/

# User for admin
adduser --disabled-password --gecos "" soul
usermod -G admin soul
usermod -p $1$KQwQ4Rq7$CtkUF2cjpb9raBQZPjy4J0 soul
mkdir /home/soul/.ssh
chown soul:soul /home/soul/.ssh
chmod 700 /home/soul/.ssh
cat configs/soul.pub >> /home/soul/.ssh/authorized_keys
chown soul:soul /home/soul/.ssh/authorized_keys
chmod 600 /home/soul/.ssh/authorized_keys

# Django init script
cp configs/django /etc/init.d/
chown root:root /etc/init.d/django
chmod 751 /etc/init.d/django
update-rc.d django defaults

# Restore postgres dump
createdb -U postgres mil
cat basic.sql | psql -U postgres mil
#Test strings
#echo "*/1 * * * *    www-data   python /home/django/projects/mil/contrib/dumpdb.py 2>>/tmp/cronerror.txt" >> /etc/crontab

# Database dump cron script
echo "PYTHONPATH=/home/django/projects/mil:\$PYTHONPATH" >> /etc/crontab
echo "DJANGO_SETTINGS_MODULE=settings" >> /etc/crontab
echo "5 16 * * *    www-data   python /home/django/projects/mil/contrib/dumpdb.py" >> /etc/crontab

# Outbox
mkdir -p /var/mil/outbox
mkdir -p /var/mil/inbox
mkdir -p /var/mil/dumps
#mkdir -p /var/mil/media/ofiles
chown -R www-data:www-data /var/mil

# --configs
# cp configs/ubuntu/etc/network/interfaces /etc/network/interfaces
# chown root:root /etc/network/interfaces
# chmod 644 /etc/network/interfaces
# /etc/init.d/networking restart

cp configs/ubuntu/etc/samba/smb.conf /etc/samba/smb.conf
chown root:root /etc/samba/smb.conf
chmod 644 /etc/samba/smb.conf
/etc/init.d/smbd restart

pip install -r ../pip_requirements.txt

# install latest redis
wget http://redis.googlecode.com/files/redis-2.4.6.tar.gz
tar xzf redis-2.4.6.tar.gz
cd redis-2.4.6
make
make install
/etc/init.d/redis-server restart

rm ./redis*

# Start django daemon
/etc/init.d/django restart
/etc/init.d/nginx restart

echo "Populating Redis DB..."

cd /home/django/projects/mil/
chmod +x ./manage.py
./manage.py persons2redis

echo "Finished"
