# -*- coding: utf-8 -*-

import settings
import datetime
from django import forms
from django.forms.extras.widgets import SelectDateWidget
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from django.conf import settings

from common.models import *

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
    info = forms.CharField(required=False, max_length=30, label="Доролнительная информация о воине")
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
    info = forms.CharField(required=False, max_length=30, label="Доролнительная информация о захоронении")
    state = forms.ModelChoiceField(queryset=MemorialState.objects.all(), required=False, label="Состояние памятника")
    in_trash = forms.BooleanField(required=False, label="В корзине")

    def __init__(self, *args, **kwargs):
        super(BurialsForm, self).__init__(*args, **kwargs)
        for k in self.fields:
            if isinstance(self.fields[k], forms.DateField):
                self.fields[k].widget.attrs = {'class': 'DateField form-field'}
    class Meta:
        model = LocationBurial
        fields = ['country', 'region', 'city']

class UnclearSelectDateWidget(SelectDateWidget):
    month_unclear = False
    year_unclear = False

    def value_from_datadict(self, data, files, name):
        from django.forms.extras.widgets import get_format, datetime_safe

        y = data.get(self.year_field % name)
        m = data.get(self.month_field % name)
        d = data.get(self.day_field % name)
        if y == m == d == "0":
            return None

        self.no_day = self.no_month = False

        if y:
            if settings.USE_L10N:
                input_format = get_format('DATE_INPUT_FORMATS')[0]
                try:
                    ud = UnclearDate(int(y), int(m), int(d))
                except ValueError, e:
                    return '%s-%s-%s' % (y, m, d)
                else:
                    self.no_month = ud.no_month
                    self.no_day = ud.no_day
                    date_value = datetime_safe.new_date(ud.d)
                return date_value.strftime(input_format)
            else:
                return '%s-%s-%s' % (y, m, d)
        return data.get(name, None)

    def create_select(self, name, field, value, val, choices):
        from django.forms.extras.widgets import Select
        if 'id' in self.attrs:
            id_ = self.attrs['id']
        else:
            id_ = 'id_%s' % name
        choices.insert(0, self.none_value)
        local_attrs = self.build_attrs(id=field % id_)
        s = Select(choices=choices)
        select_html = s.render(field % name, val, local_attrs)
        return select_html

class UnclearDateField(forms.DateField):
    widget = UnclearSelectDateWidget(years=range(datetime.date.today().year, 1850, -1))

    def to_python(self, value):
        if isinstance(value, UnclearDate):
            return value
        return super(UnclearDateField, self).to_python(value)

    def prepare_value(self, value):
        if isinstance(value, UnclearDate):
            return value
        return value

class PersonAdminForm(forms.ModelForm):
    birth_date = UnclearDateField(label=u"Дата рождения", required=False)
    death_date = UnclearDateField(label=u"Дата гибели", required=False)

    class Meta:
        model = Person

    def __init__(self, *args, **kwargs):
        kwargs.setdefault('initial', {}).update({
            'birth_date': kwargs.get('instance', Person()).get_unclear_date('birth_date'),
            'death_date': kwargs.get('instance', Person()).get_unclear_date('death_date'),
        })
        super(PersonAdminForm, self).__init__(*args, **kwargs)

    def save(self, *args, **kwargs):
        kwargs['commit'] = False
        obj = super(PersonAdminForm, self).save(*args, **kwargs)
        for f in self.fields:
            if isinstance(self.fields[f], UnclearDateField):
                setattr(obj, f, self.cleaned_data[f])
                self.fields[f].widget.value_from_datadict(data=self.data, files=None, name=f)
                setattr(obj, f+'_no_month', getattr(obj, f) and self.fields[f].widget.no_month or False)
                setattr(obj, f+'_no_day', getattr(obj, f) and self.fields[f].widget.no_day or False)
        obj.save()
        return obj