#!/usr/bin/env bash
source constants
pg_dump -U postgres mil | gzip > /var/cemetery/dumps/"`eval date +%Y%m%d%H%M`".gz
#pg_dump -U postgres cemetery | gzip > $db_dumps_dir/"`eval date +%Y%m%d%H%M`".gz
#rsync -av --delete /var/cemetery/media/ofiles /var/cemetery/dumps/
rsync -av --delete /home/django/projects/mil/media/ofiles /var/mil/dumps/
