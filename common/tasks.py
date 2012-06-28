# -*- coding: utf-8 -*-
from zipfile import ZipFile

from celery.task import task
from django.conf import settings
from django.template.loader import render_to_string
import os
from common.models import Burial
from django.core.mail import EmailMessage

@task
def report_2_deferred(burial_id, email):
    b = Burial.objects.get(pk=burial_id)
    msg = render_to_string('reports/report_2.html', {'burial': b})

    html_path = os.tempnam()
    f = open(html_path, 'w')
    f.write(msg.encode('utf-8'))
    f.close()

    zip_path = os.tempnam()
    with ZipFile(zip_path, 'w') as myzip:
        myzip.write(html_path, 'report_2.html')

    print 'settings.DEFAULT_FROM_EMAIL', settings.DEFAULT_FROM_EMAIL

    email = EmailMessage(subject=u'Форма 2', body=u'См. прикрепленный файл', to=[email], from_email=settings.DEFAULT_FROM_EMAIL)
    email.attach_file(zip_path)
    email.send()

    os.unlink(html_path)
    os.unlink(zip_path)

    return 'ok'