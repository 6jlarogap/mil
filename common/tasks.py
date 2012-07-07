# -*- coding: utf-8 -*-
from zipfile import ZipFile

from celery.task import task
from django.conf import settings
from django.contrib.sites.models import Site
from django.template.loader import render_to_string
import os
from common.models import Burial
from django.core.mail import EmailMessage

@task
def report_2_deferred(burial_id, email):
    b = Burial.objects.get(pk=burial_id)
    msg = render_to_string('reports/report_2.html', {'burial': b})

    html_path = os.tempnam()
    html_path = html_path.replace('/tmp/', os.path.join(settings.MEDIA_ROOT, 'reports')) + '.html'

    if not os.path.exists(os.path.dirname(html_path)):
        os.makedirs(os.path.dirname(html_path))

    f = open(html_path, 'w')
    f.write(msg.encode('utf-8'))
    f.close()

    zip_path = html_path + '.zip'
    zip = ZipFile(zip_path, 'w')
    zip.write(html_path, 'report_2.html')
    zip.close()

    zip_url = zip_path.replace(settings.MEDIA_ROOT, settings.MEDIA_URL)
    body = u'http://%s%s' % (Site.objects.get_current().domain, zip_url)
    email = EmailMessage(subject=u'Форма 2', body=body, to=[email], from_email=settings.DEFAULT_FROM_EMAIL)
    email.send()

    os.unlink(html_path)
    # os.unlink(zip_path)

    return 'ok, %s, %s' % (html_path, zip_url)