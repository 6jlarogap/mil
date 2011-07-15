# -*- coding: utf-8 -*-

import settings
import datetime
from django import forms
from common.models import *
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from django.conf import settings

from smart_selects.form_fields import ChainedModelChoiceField
#from registration.models import RegistrationProfile

#from contact_form.forms import ContactForm

class CalendarWidget(forms.TextInput):
    class Media:
        js = ('/admin/jsi18n/',
            settings.ADMIN_MEDIA_PREFIX + 'js/core.js',
            settings.ADMIN_MEDIA_PREFIX + 'js/calendar.js',
            settings.ADMIN_MEDIA_PREFIX + 'js/admin/DateTimeShortcuts.js'
        )
        css = {
            'all': (
                settings.ADMIN_MEDIA_PREFIX + 'css/forms.css',
                settings.ADMIN_MEDIA_PREFIX + 'css/base.css',
                settings.ADMIN_MEDIA_PREFIX + 'css/widgets.css',)
        }

    def __init__(self, attrs={}):
        attrs.update({'class': 'vDateField', 'size': '10'})
        super(CalendarWidget, self).__init__(attrs=attrs)

class LoginForm(AuthenticationForm): # Форма авторизации
    """Форма авторизации.

    Форма позволяет пользователю ввести логин и пароль.
    """
    username = forms.CharField(max_length=30, label="E-mail ")
    password = forms.CharField(max_length=18, widget=forms.PasswordInput, label="Пароль ")

class PersonsForm(forms.Form):
    """Форма поиска воинов.
    """
    rank = forms.ModelChoiceField(queryset=Rank.objects.all(), required=False, label="Воинское звание")
    last_name = forms.CharField(required=False, max_length=128, label="Фамилия ")
    first_name = forms.CharField(required=False, max_length=30, label="Имя ")
    patronymic = forms.CharField(required=False, max_length=30, label="Отчество ")
    birth_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата рождения c')
    birth_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата рождения по')
#    city_birth = forms.CharField(required=False, max_length=36, label="Нас. пункт рождения",
#                           widget=forms.TextInput(attrs={"tabindex": "15"}))
#    region_birth = forms.CharField(required=False, max_length=36, label="Регион",
#                             widget=forms.TextInput(attrs={"tabindex": "16"}))
#    country_birth = forms.CharField(required=False, max_length=24, label="Страна",
#                              widget=forms.TextInput(attrs={"tabindex": "17"}))
#    mu = forms.ModelChoiceField(queryset=MilitaryUnit.objects.all(), required=False, label="Место службы")
    death_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата смерти с')
    death_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата смерти по')
#    death_cause = forms.ModelChoiceField(queryset=DeathCause.objects.all(), required=False, label="Причина гибели")
    burial_passportid = forms.CharField(required=False, max_length=30, label="Номер паспорта захоронения")
#    burial_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения с')
#    burial_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения по')
#    city_burial = forms.CharField(required=False, max_length=36, label="Нас. пункт захоронения",
#                           widget=forms.TextInput(attrs={"tabindex": "15"}))
#    region_burial = forms.CharField(required=False, max_length=36, label="Регион",
#                             widget=forms.TextInput(attrs={"tabindex": "16"}))
#    country_burial = forms.CharField(required=False, max_length=24, label="Страна",
#                              widget=forms.TextInput(attrs={"tabindex": "17"}))
    additional_info = forms.CharField(required=False, max_length=30, label="Доролнительная информация о месте рождения и родственниках")
#    documents_place = forms.ModelChoiceField(queryset=DocumentsPlace.objects.all(), required=False, label="Место нахождения документов")
#    information_source = forms.ModelChoiceField(queryset=InformationSource.objects.all(), required=False, label="Источник информации")
#    deadman_category = forms.ModelChoiceField(queryset=DeadmanCategory.objects.all(), required=False, label="Категория погибшего")
    in_trash = forms.BooleanField(required=False, label="В корзине")

    def __init__(self, *args, **kwargs):
        super(PersonsForm, self).__init__(*args, **kwargs)
        for k in self.fields:
            if isinstance(self.fields[k], forms.DateField):
                self.fields[k].widget.attrs = {'class': 'DateField form-field'}

class BurialsForm(forms.ModelForm):
    """Форма поиска захоронений.
    """
    
    burial_passportid = forms.CharField(required=False, max_length=30, label="Номер паспорта захоронения")
    bemptypassport = forms.BooleanField(required=False, label="Показать без паспорта")
#    passport_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата паспортизации c')
#    passport_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата паспортизации по')
    burried_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения c')
    burried_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения по')
#    discovered_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата обнаружения c')
#    discovered_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата обнаружения по')
#    closure_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата закрытия c')
#    closure_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата закрытия по')
#    closure_cause = forms.ModelChoiceField(queryset=ClosureCause.objects.all(), required=False, label="Причина перезахоронения")
    
    burial_type = forms.ModelChoiceField(queryset=BurialType.objects.all(), required=False, label="Тип захоронения")
    military_conflict = forms.ModelChoiceField(queryset=MilitaryConflict.objects.all(), required=False, label="Военный конфликт")
#    memorial_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата установки памятника c')
#    memorial_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата установки памятника по')
#    gosznak_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата установки госзнака c')
#    gosznak_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата установки госзнака по')
#    creator = forms.CharField(required=False, max_length=128, label="Создатель записи ")
#    creation_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата создания записи c')
#    creation_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата создания записи по')
#    last_edit_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата редактирования записи c')
#    last_edit_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата редактирования записи по')
    additional_info = forms.CharField(required=False, max_length=30, label="Доролнительная информация о месте захоронения")
    in_trash = forms.BooleanField(required=False, label="В корзине")

    def __init__(self, *args, **kwargs):
        super(BurialsForm, self).__init__(*args, **kwargs)
        for k in self.fields:
            if isinstance(self.fields[k], forms.DateField):
                self.fields[k].widget.attrs = {'class': 'DateField form-field'}
    class Meta:
        model = LocationBurial
        fields = ['country', 'region', 'city']

