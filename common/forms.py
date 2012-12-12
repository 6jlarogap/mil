# -*- coding: utf-8 -*-
import time
from django.core.urlresolvers import reverse
from django.forms.fields import MultiValueField
from django.forms.widgets import MultiWidget, Select
from django.utils.dates import MONTHS
from django.utils.formats import get_format
from django.utils.safestring import mark_safe

import settings
import datetime
from django import forms
from django.forms.extras.widgets import SelectDateWidget, RE_DATE, _parse_date_fmt
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from django.conf import settings

from common.models import *

from smart_selects.form_fields import ChainedModelChoiceField, ChainedSelect

PER_PAGE_CHOICES = (
    (20, u'20'),
    (50, u'50'),
    (100, u'100'),
)

class UnclearSelectDateWidget(SelectDateWidget):
    month_unclear = False
    year_unclear = False

    def render(self, name, value, attrs=None):
        try:
            year_val, month_val, day_val = value.year, value.month, value.day
        except AttributeError:
            year_val = month_val = day_val = None
            if isinstance(value, basestring):
                if settings.USE_L10N:
                    try:
                        input_format = get_format('DATE_INPUT_FORMATS')[0]
                        v = datetime.datetime(*(time.strptime(value, input_format)[0:6]))
                        year_val, month_val, day_val = v.year, v.month, v.day
                    except ValueError:
                        pass
                else:
                    match = RE_DATE.match(value)
                    if match:
                        year_val, month_val, day_val = [int(v) for v in match.groups()]
        choices = [(i, i) for i in self.years]
        year_html = self.create_select(name, self.year_field, value, year_val, choices)
        choices = zip(MONTHS.keys(), MONTHS.keys())
        month_html = self.create_select(name, self.month_field, value, month_val, choices)
        choices = [(i, i) for i in range(1, 32)]
        day_html = self.create_select(name, self.day_field, value, day_val,  choices)

        output = []
        for field in _parse_date_fmt():
            if field == 'year':
                output.append(year_html)
            elif field == 'month':
                output.append(month_html)
            elif field == 'day':
                output.append(day_html)
        return mark_safe(u'\n'.join(output))

    def value_from_datadict(self, data, files, name, return_flags=False):
        from django.forms.extras.widgets import get_format, datetime_safe

        y = data.get(self.year_field % name)
        m = data.get(self.month_field % name)
        d = data.get(self.day_field % name)
        if y == m == d == "0" or y == m == d == "":
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
                if return_flags:
                    return (date_value.strftime(input_format), ud.no_month, ud.no_day)
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
        choices = map(lambda c: len(unicode(c[1])) == 1 and ('0%s'%c[0], '0%s'%c[1]) or c, choices)
        s = Select(choices=choices)
        val = len(unicode(val)) == 1 and '0%s' % val or val
        select_html = s.render(field % name, val, local_attrs)
        return select_html

class UnclearDateField(forms.DateField):
    widget = UnclearSelectDateWidget(years=range(datetime.date.today().year, 1700, -1))
    empty_strings_allowed = True

    def __init__(self, *args, **kwargs):
        super(UnclearDateField, self).__init__(*args, **kwargs)
        self.widget.required = self.required

    def to_python(self, value):
        if not value:
            return None
        if isinstance(value, UnclearDate):
            return value
        return super(UnclearDateField, self).to_python(value)

    def prepare_value(self, value):
        if not value:
            return None
        if isinstance(value, UnclearDate):
            return value
        return value

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

    def __init__(self, attrs=None):
        attrs = attrs or {}
        attrs.update({'class': 'vDateField', 'size': '10'})
        super(CalendarWidget, self).__init__(attrs=attrs)

class LoginForm(AuthenticationForm): # Форма авторизации
    """Форма авторизации.

    Форма позволяет пользователю ввести логин и пароль.
    """
    username = forms.CharField(max_length=30, label="E-mail ")
    password = forms.CharField(max_length=18, widget=forms.PasswordInput, label="Пароль ")

class LocationWidget(MultiWidget):
    def __init__(self, partial=False, *args, **kwargs):
        countries = GeoCountry.objects.all()
        widgets = (
            forms.Select(choices=[('', u'Страна')] + [(c.pk, c) for c in countries]),
            ChainedSelect('common', 'GeoRegion', ", [id$=location_0]", "country", False, False),
            ChainedSelect('common', 'District', ", [id$=location_1]", "region", False, False),
            ChainedSelect('common', 'Municipalitet', ", [id$=location_2]", "district", False, False),
            ChainedSelect('common', 'GeoCity', ", [id$=location_2]", "district", False, False),
            forms.TextInput(),
        )
        for w,l in zip(widgets, [u'Страна', u'Область', u'Район', u'Сельсовет', u'Нас. пункт', ]):
            w.choices = getattr(w, 'choices', [('', l), ])
        widgets[0].queryset = GeoCountry.objects.all()
        widgets[1].queryset = GeoRegion.objects.all()
        widgets[2].queryset = District.objects.all()
        widgets[3].queryset = Municipalitet.objects.all()
        widgets[4].queryset = GeoCity.objects.all()
        super(LocationWidget, self).__init__(widgets, *args, **kwargs)
        self.choices = []
        self.partial = partial

    def decompress(self, value):
        if value:
            model_klass = self.partial and SimpleLocation or StrictLocation
            value = model_klass.objects.get(pk=value)
            return [
                value.country and value.country.pk,
                value.region and value.region.pk,
                value.district and value.district.pk,
                value.municipalitet and value.municipalitet.pk,
                value.city and value.city.pk,
                value.city and value.city.name,
            ]
        return [None, None, None, None, None]

class AdminLocationWidget(LocationWidget):
    def format_output(self, rendered_widgets):
        output = []
        i = 0
        for w, k in zip(rendered_widgets, ['geocountry', 'georegion', 'district', 'municipalitet', ]):
            related_url = reverse('admin:%s_%s_add' % ('common', k))
            output.append(w)
            output.append(u'<a href="%s" class="add-another" id="add_id_%s" onclick="return showAddAnotherPopup(this);"> ' % (related_url, 'location_%s' % i))
            output.append(u'<img src="%simg/admin/icon_addlink.gif" width="10" height="10" alt="%s"/></a>&nbsp;' % (settings.ADMIN_MEDIA_PREFIX, u"новый"))
            i += 1
        for w in rendered_widgets[4:]:
            output.append(w)
        return u''.join(output)


class MockLocation(object):
    def __init__(self, *args, **kwargs):
        for k,v in kwargs.items():
            setattr(self, k, v)

class LocationField(MultiValueField):
    widget = LocationWidget
    required = False

    def __init__(self, partial=False, *args, **kwargs):
        self.partial = partial

        fields = (
            # country, region, district, municipalitet, city
            forms.ModelChoiceField(GeoCountry, empty_label=u"Страна", required=False, ),
            ChainedModelChoiceField('common', 'GeoRegion', "country", "country", False, True, empty_label=u"Область"),
            ChainedModelChoiceField('common', 'District', "region", "region", False, True, empty_label=u"Район"),
            ChainedModelChoiceField('common', 'Municipalitet', "district", "district", False, True, empty_label=u"Сельсовет"),
            ChainedModelChoiceField('common', 'GeoCity', "district", "district", False, True, empty_label=u"Нас. пункт"),
            forms.CharField(required=False)
        )
        fields[0].queryset = GeoCountry.objects.all()
        fields[1].queryset = GeoRegion.objects.all()
        fields[2].queryset = District.objects.all()
        fields[3].queryset = Municipalitet.objects.all()
        fields[4].queryset = GeoCity.objects.all()
        for f in fields:
            f.required = False
        super(LocationField, self).__init__(fields, *args, **kwargs)
        self.widget.partial = self.partial

    def compress(self, data_list):
        if not data_list:
            return None
        if not any(data_list):
            return None
        if not data_list[0] and not self.partial:
            raise forms.ValidationError(u'Введите страну')
        if not data_list[1] and not self.partial:
            raise forms.ValidationError(u'Введите область')
        if not data_list[2] and not self.partial:
            raise forms.ValidationError(u'Введите район')
        if not data_list[4] and not data_list[5] and not self.partial:
            raise forms.ValidationError(u'Введите или выберите НП')
        city = None
        if len(data_list) > 4:
            city = data_list[4] or (data_list[5] and GeoCity.objects.get_or_create(
                name=data_list[5],
                country=data_list[0],
                region=data_list[1],
                district=data_list[2],
                municipalitet=data_list[3],
            )[0]) or None
        if self.partial:
            loc = SimpleLocation.objects.create(
                country=data_list[0],
                region=data_list[1],
                district=data_list[2],
                municipalitet=data_list[3],
                city=city,
            )
        else:
            loc = StrictLocation.objects.create(
                country=data_list[0],
                region=data_list[1],
                district=data_list[2],
                municipalitet=data_list[3],
                city=city,
            )
        return loc.pk

class PersonsForm(forms.Form):
    """Форма поиска воинов.
    """
    burial_location = LocationField(label=u"Место захоронения", required=False, partial=True)
    country_exclude = forms.BooleanField(required=False, initial=False, label="Все страны, кроме выбранной")
    rank = forms.ModelChoiceField(queryset=Rank.objects.all(), required=False, label="Воинское звание")
    last_name = forms.CharField(required=False, max_length=128, label="Фамилия ")
    first_name = forms.CharField(required=False, max_length=30, label="Имя ")
    patronymic = forms.CharField(required=False, max_length=30, label="Отчество ")

    birth_location = LocationField(label=u"Место рождения", required=False, partial=True)
    birth_date_from = UnclearDateField(required=False, label='Дата рождения c')
    birth_date_to = UnclearDateField(required=False, label='Дата рождения по')
    death_date_from = UnclearDateField(required=False, label='Дата смерти с')
    death_date_to = UnclearDateField(required=False, label='Дата смерти по')

    category = forms.ModelChoiceField(queryset=DeadmanCategory.objects.all(), required=False, label=u"Категория")
    death_cause = forms.ModelChoiceField(queryset=DeathCause.objects.all(), required=False, label=u"Причина смерти")

    record_date_from = UnclearDateField(required=False, label='Дата добавления с')
    record_date_to = UnclearDateField(required=False, label='Дата добавления по')

    burial_passportid = forms.CharField(required=False, max_length=30, label="Номер паспорта захоронения")
    info = forms.CharField(required=False, max_length=30, label="Дополнительная информация о воине")
    in_trash = forms.BooleanField(required=False, label="В корзине")

    per_page = forms.ChoiceField(label=u"Записей на страницу", choices=PER_PAGE_CHOICES)

    def __init__(self, *args, **kwargs):
        super(PersonsForm, self).__init__(*args, **kwargs)
        for k in self.fields:
            if isinstance(self.fields[k], forms.DateField):
                self.fields[k].widget.attrs = {'class': 'DateField form-field'}

        for i,w in enumerate(self.fields['burial_location'].widget.widgets):
            if i > 0 and i < 3:
                w.chain_field = 'burial_location_%s' % (i-1)
            if i >= 3:
                w.chain_field = 'burial_location_%s' % (2)

        for i,w in enumerate(self.fields['birth_location'].widget.widgets):
            if i > 0 and i < 3:
                w.chain_field = 'birth_location_%s' % (i-1)
            if i >= 3:
                w.chain_field = 'birth_location_%s' % (2)

class BurialsForm(forms.ModelForm):
    """Форма поиска захоронений.
    """

    city_name = forms.CharField(required=False, label=u"")

    burial_passportid = forms.CharField(required=False, max_length=30, label="Номер паспорта захоронения")
    bemptypassport = forms.BooleanField(required=False, label="Только неучтенные")

    burried_date_from = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения c')
    burried_date_to = forms.DateField(required=False, widget=CalendarWidget, label='Дата захоронения по')
    burial_type = forms.ModelChoiceField(queryset=BurialType.objects.all(), required=False, label="Тип захоронения")
    military_conflict = forms.ModelChoiceField(queryset=MilitaryConflict.objects.all(), required=False, label="Военный конфликт")
    info = forms.CharField(required=False, max_length=30, label="Дополнительная информация о захоронении")
    state = forms.ModelChoiceField(queryset=MemorialState.objects.all(), required=False, label="Состояние памятника")
    in_trash = forms.BooleanField(required=False, label="В корзине")
    only_closed = forms.BooleanField(required=False, label=u"Только среди закрытых и в корзине")
    other_countries = forms.BooleanField(required=False, label=u"Все страны, кроме выбранной")

    per_page = forms.ChoiceField(label=u"Записей на страницу", choices=PER_PAGE_CHOICES)

    def __init__(self, *args, **kwargs):
        super(BurialsForm, self).__init__(*args, **kwargs)
        for k in self.fields:
            self.fields[k].required = False
            if isinstance(self.fields[k], forms.DateField):
                self.fields[k].widget.attrs = {'class': 'DateField form-field'}

    class Meta:
        model = SimpleLocation
        fields = ['country', 'region', 'district', 'municipalitet', 'city']

class BurialAdminForm(forms.ModelForm):
    date_gosznak = UnclearDateField(label=u"Дата установки государственного знака", required=False)
    date_burried = UnclearDateField(label=u"Дата создания захоронения", required=False)
    date_discovered = UnclearDateField(label=u"Дата обнаружения захоронения", required=False)
    date_memorial = UnclearDateField(label=u"Дата установки памятника", required=False)
    location = LocationField(label=u"Место захоронения", required=False, partial=True, widget=AdminLocationWidget)

    count_known = forms.IntegerField(label=u"Известных")
    count_unknown = forms.IntegerField(label=u"Неизвестных")

    class Meta:
        model = Burial

    def __init__(self, *args, **kwargs):
        r = cemetery_redis.Redis()
        b = kwargs.get('instance', Burial())
        kwargs.setdefault('initial', {}).update({
            'date_gosznak': b.get_unclear_date('date_gosznak'),
            'date_burried': b.get_unclear_date('date_burried'),
            'date_discovered': b.get_unclear_date('date_discovered'),
            'date_memorial': b.get_unclear_date('date_memorial'),
            'count_known': r.known_for_burial(b) or 0,
            'count_unknown': r.unknown_for_burial(b) or 0,
        })
        super(BurialAdminForm, self).__init__(*args, **kwargs)

    def clean_passportid(self):
        try:
            Burial.objects.exclude(pk=self.instance and self.instance.pk or -1).get(passportid=self.cleaned_data['passportid'])
        except Burial.DoesNotExist:
            return self.cleaned_data['passportid']
        except Burial.MultipleObjectsReturned:
            pass
        raise forms.ValidationError(u"Захоронение с этим номером уже существует")

    def clean(self):
        if not 'location' in self.cleaned_data:
            raise forms.ValidationError(u"Нужно указать расположение")
        if not isinstance(self.cleaned_data['location'], SimpleLocation):
            self.cleaned_data['location'] = SimpleLocation.objects.get(pk=self.cleaned_data['location'])
        return self.cleaned_data

    def save(self, *args, **kwargs):
        kwargs['commit'] = False
        obj = super(BurialAdminForm, self).save(*args, **kwargs)
        for f in self.fields:
            if isinstance(self.fields[f], UnclearDateField):
                setattr(obj, f, self.cleaned_data[f])
                self.fields[f].widget.value_from_datadict(data=self.data, files=None, name=f)
                setattr(obj, f+'_no_month', getattr(obj, f) and self.fields[f].widget.no_month or False)
                setattr(obj, f+'_no_day', getattr(obj, f) and self.fields[f].widget.no_day or False)
        obj.save()

        r = cemetery_redis.Redis()
        r.db.set('cemetery:burial:%s:known' % obj.pk, self.cleaned_data['count_known'])
        r.db.set('cemetery:burial:%s:unknown' % obj.pk, self.cleaned_data['count_unknown'])
        r.db.set('cemetery:burial:%s:all' % obj.pk, self.cleaned_data['count_known'] + self.cleaned_data['count_unknown'])

        return obj

class PersonAdminForm(forms.ModelForm):
    birth_date = UnclearDateField(label=u"Дата рождения", required=False)
    death_date = UnclearDateField(label=u"Дата гибели", required=False)
    duplicate_ok = forms.BooleanField(label=u"Да, создайте дублирующую запись", required=False, widget=forms.HiddenInput)
    birth_location = LocationField(label=u"Место рождения", required=False, partial=True, widget=AdminLocationWidget)
    birth_location_info = forms.CharField(label=u"Доп.информация о месте рождения", required=False, widget=forms.Textarea)

    class Meta:
        model = Person

    def __init__(self, *args, **kwargs):
        kwargs.setdefault('initial', {}).update({
            'birth_date': kwargs.get('instance', Person()).get_unclear_date('birth_date'),
            'death_date': kwargs.get('instance', Person()).get_unclear_date('death_date'),
        })
        super(PersonAdminForm, self).__init__(*args, **kwargs)

    def clean(self):
        persons = Person.objects.all()
        if self.instance:
            persons = persons.exclude(pk=self.instance.pk)
        try:
            filters = {}
            for f in ['last_name', 'first_name', 'patronymic']:
                if self.cleaned_data.get(f):
                    filters[f+'__iexact'] = self.cleaned_data.get(f)
            for f in ['burial', 'death_date']:
                if self.cleaned_data.get(f):
                    filters[f] = self.cleaned_data.get(f)

            person = persons.filter(**filters)[0]
        except IndexError:
            pass
        else:
            if not self.cleaned_data['duplicate_ok']:
                self.fields['duplicate_ok'].widget = forms.CheckboxInput()
                raise forms.ValidationError(u"Обнаружена дублирующая запись: %s %s %s (%s - %s). Необходимо подтвердить дублирование." % (
                    person.last_name, person.first_name, person.patronymic,
                    person.birth_date or u'неизвестно', person.death_date or u'неизвестно'
                ))
        return self.cleaned_data

    def save(self, *args, **kwargs):
        kwargs['commit'] = False
        obj = super(PersonAdminForm, self).save(*args, **kwargs)
        for f in self.fields:
            if isinstance(self.fields[f], UnclearDateField):
                try:
                    v, nm, nd = self.fields[f].widget.value_from_datadict(self.data, None, f, return_flags=True)
                except (TypeError, ValueError):
                    v, nm, nd = None, False, False

                print f,v,nm,nd

                setattr(obj, f, self.cleaned_data[f])
                self.fields[f].widget.value_from_datadict(data=self.data, files=None, name=f)
                setattr(obj, f+'_no_month', getattr(obj, f) and nm or False)
                setattr(obj, f+'_no_day', getattr(obj, f) and nd or False)
        obj.save()

        if self.cleaned_data.get('birth_location_info'):
            if not obj.birth_location:
                obj.birth_location = SimpleLocation()
            obj.birth_location.info = self.cleaned_data['birth_location_info']
            obj.birth_location.save()
            obj.save()
        elif obj.birth_location and obj.birth_location.info:
            obj.birth_location.info = ''
            obj.birth_location.save()

        return obj

class PersonCallForm(forms.ModelForm):
    date = UnclearDateField(label=u"Дата призыва", required=False)

    class Meta:
        model = PersonCall

    def __init__(self, *args, **kwargs):
        kwargs.setdefault('initial', {}).update({
            'date': kwargs.get('instance', Person()).get_unclear_date('date'),
        })
        super(PersonCallForm, self).__init__(*args, **kwargs)

    def save(self, commit=True, *args, **kwargs):
        kwargs['commit'] = False
        obj = super(PersonCallForm, self).save(*args, **kwargs)
        for f in self.fields:
            if isinstance(self.fields[f], UnclearDateField):
                try:
                    v, nm, nd = self.fields[f].widget.value_from_datadict(self.data, None, 'personcall-0-date', return_flags=True)
                except (TypeError, ValueError):
                    v, nm, nd = None, False, False

                setattr(obj, f, self.cleaned_data[f])
                self.fields[f].widget.value_from_datadict(data=self.data, files=None, name=f)
                setattr(obj, f+'_no_month', getattr(obj, f) and nm or False)
                setattr(obj, f+'_no_day', getattr(obj, f) and nd or False)

        if commit:
            obj.save()
        return obj

class XLSImportForm(forms.Form):
    xls = forms.FileField(label=u'Файл XLS')
    burial = forms.IntegerField(label=u"Номер захоронения")

    def clean_burial(self):
        try:
            return Burial.objects.get(passportid=self.cleaned_data['burial'])
        except Exception:
            raise forms.ValidationError(u"Неверный номер")