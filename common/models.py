# -*- coding: utf-8 -*-
import math
import os

import datetime
from django.core.cache import cache

from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User

from smart_selects.db_fields import ChainedForeignKey
import re
import cemetery_redis
import pytils.translit

def slugify_filename(prefix):
    def _slugify(instance, filename):
        filename, ext = filename.rsplit('.', 1)
        return os.path.join(prefix, '%s.%s'  % (pytils.translit.slugify(filename), ext))
    return _slugify

class GeoCountry(models.Model):
    """
    Страна.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Название", max_length=36, db_index=True, unique=True)

    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ['name']
        verbose_name = u'страна'
        verbose_name_plural = u'страны'


class GeoRegion(models.Model):
    """
    Регион.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    country = models.ForeignKey(GeoCountry, null=True, verbose_name=u"Страна")
    name = models.CharField(u"Название", max_length=36, db_index=True)

    def __unicode__(self):
        name = geo_name(self.name)
        return name

    class Meta:
        unique_together = (("country", "name"),)
        verbose_name = u'область'
        verbose_name_plural = u'области'
        ordering = ['name']

class District(models.Model):
    """
    Район.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    region = models.ForeignKey(GeoRegion, null=True, verbose_name=u"Область")
    name = models.CharField(u"Название", max_length=36, db_index=True)

    def __unicode__(self):
        name = geo_name(self.name)
        return name

    class Meta:
        verbose_name = u'район'
        verbose_name_plural = u'районы'
        ordering = ['name']

class Municipalitet(models.Model):
    """
    Сельсовет.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    district = models.ForeignKey(District, verbose_name=u"Район")
    name = models.CharField(u"Название", max_length=36, db_index=True)

    def __unicode__(self):
        name = geo_name(self.name)
        return name

    class Meta:
        unique_together = (("district", "name"),)
        verbose_name = u'сельсовет'
        verbose_name_plural = u'сельсоветы'
        ordering = ['name']

def capitalize_name(instance, **kwargs):
    if instance.name[0] != instance.name.capitalize()[0]:
        instance.name = instance.name.capitalize()

class CityType(models.Model):
    """
    Тип нас.пунктов
    """
    name = models.CharField("Название", max_length=36, db_index=True)
    full_name = models.CharField("Полное название", max_length=255, blank=True, null=True)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = u'Тип населенных пунктов'
        verbose_name_plural = u'Типы населенных пунктов'


def geo_name(name):
    """
    clean_name = re.sub(u'\.([A-Za-zА-Яа-яёЁ])', '. \\1', name.capitalize())

    def make_first_upper(m):
        return u'%s%s' % (m.groups()[0], m.groups()[1].capitalize())

    clean_name = re.sub(u'([\s-])([A-Za-zА-Яа-яёЁ])', make_first_upper, clean_name)

    VALID_PREFIXES = [u'г', u'п', u'пос', u'ул', u'пр', u'просп', u'пер', u'пл', u'л', u'ур',  u'оз',  ]

    def make_prefix_lower(m):
        prefix = m.groups()[0]
        if prefix.lower() in VALID_PREFIXES:
            prefix = prefix.lower()

        return u'%s.' % prefix

    clean_name = re.sub(u'^([A-Za-zА-Яа-яёЁ]+)\.', make_prefix_lower, clean_name)

    clean_name = re.sub(u'(\s|^)[Аа][Оо](\s|$)', u'\\1АО\\2', clean_name)
    """
    clean_name = name
    return clean_name

class GeoCity(models.Model):
    """
    Город.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    country = models.ForeignKey(GeoCountry, verbose_name=u'Страна', null=True)
    region = models.ForeignKey(GeoRegion, verbose_name=u'Область', null=True)
    district = models.ForeignKey(District, verbose_name=u'Район', null=True)
    municipalitet = models.ForeignKey(Municipalitet, verbose_name=u'Сельсовет', blank=True, null=True)
    type = models.ForeignKey(CityType, null=True, blank=True, verbose_name=u'Тип')
    name = models.CharField("Название", max_length=36, db_index=True)

    def __unicode__(self):
        name = geo_name(self.name)
        if self.type:
            return u'%s, %s' % (name, self.type)
        return name

    class Meta:
        verbose_name = u'населенный пункт'
        verbose_name_plural = u'населенные пункты'

"""
models.signals.pre_save.connect(capitalize_name, sender=GeoCountry)
models.signals.pre_save.connect(capitalize_name, sender=GeoRegion)
models.signals.pre_save.connect(capitalize_name, sender=District)
models.signals.pre_save.connect(capitalize_name, sender=Municipalitet)
models.signals.pre_save.connect(capitalize_name, sender=GeoCity)
"""

class Location(models.Model):
    """
    Абстрактный адрес
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    info = models.TextField(u"Дополнительная информация", blank=True, null=True)
    gps_x = models.FloatField(u"Координата X", blank=True, null=True)                            # GPS X-ось.
    gps_y = models.FloatField(u"Координата Y", blank=True, null=True)                            # GPS Y-ось.
    gps_z = models.FloatField(u"Координата Z", blank=True, null=True)                            # GPS Z-ось.

    def __unicode__(self, full=True, na=True):
        ret = na and u"незаполненный адрес" or u""
        if self.city:
            ret = u'НП: %s' % self.city
        if self.municipalitet:
            ret = u'Сельсовет: %s, %s' % (self.municipalitet, ret)
        if self.district:
            ret = u'Район: %s, %s' % (self.district, ret)
        if self.region:
            ret = u'Область: %s, %s' % (self.region, ret)
        if self.country:
            ret = u'Страна: %s, %s' % (self.country, ret)
        if self.info and full:
            ret = u'%s, %s' % (ret, self.info)
        return ret.strip(' ,')

    def short_title_na(self):
        return self.__unicode__(full=True, na=False)

    def short_title(self):
        return self.__unicode__(full=True)

    class Meta:
        abstract = True

class SimpleLocation(Location):
    """
    С точностью до страны
    """
    country = models.ForeignKey(GeoCountry, verbose_name=u"Страна", blank=True, null=True)       # Страна
    region = ChainedForeignKey(GeoRegion, verbose_name=u"Область", chained_field="country", chained_model_field="country", blank=True, null=True)
    district = ChainedForeignKey(District, verbose_name=u"Район", chained_field="region", chained_model_field="region", blank=True, null=True)
    municipalitet = ChainedForeignKey(Municipalitet, verbose_name=u"Сельсовет", chained_field="district", chained_model_field="district", blank=True, null=True)
    city = ChainedForeignKey(GeoCity, verbose_name=u"Нас. пункт", chained_field="district", chained_model_field="district", blank=True, null=True)

class StrictLocation(Location):
    """
    С точностью до района
    """
    country = models.ForeignKey(GeoCountry, verbose_name=u"Страна", null=True)       # Страна
    region = ChainedForeignKey(GeoRegion, verbose_name=u"Область", chained_field="country", chained_model_field="country")
    district = ChainedForeignKey(District, verbose_name=u"Район", chained_field="region", chained_model_field="region")
    municipalitet = ChainedForeignKey(Municipalitet, verbose_name=u"Сельсовет", chained_field="district", chained_model_field="district", blank=True, null=True)
    city = ChainedForeignKey(GeoCity, verbose_name=u"Нас. пункт", chained_field="district", chained_model_field="district")

class BurialPrintingGroup(models.Model):
    """
    Типы воинских захоронений при расчетах
    """
    name = models.CharField(u"Тип воинского захоронения при расчетах", max_length=100, db_index=True)
    description = models.CharField(u"Описание типа воинского захоронения при расчетах", max_length=100)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = (u'Тип воинского захоронения при расчетах')
        verbose_name_plural = (u'Типы воинских захоронений при расчетах')

class BurialType(models.Model):
    """
    Тип воинского захоронения
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Тип воинского захоронения", max_length=100, db_index=True)
    brief = models.CharField(u"Сокращенное наименование", max_length=100, blank=True, null=True)
    type = models.ForeignKey('BurialPrintingGroup', verbose_name=u"Признак группировки при печати", blank=True, null=True)       # Признак группировки при печати

    def __unicode__(self):
        return self.name

    def short_name(self):
        return self.type or self.brief or self.name

    class Meta:
        verbose_name = ('Тип воинского захоронения')
        verbose_name_plural = ('Типы воинских захоронений')

class ConflictPrintingGroup(models.Model):
    """
    Типы военных конфликтов при расчетах
    """
    name = models.CharField(u"Тип военного конфликта при расчетах", max_length=100, db_index=True)
    description = models.CharField(u"Описание типа военного конфликта при расчетах", max_length=100)

    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Тип военного конфликта при расчетах')
        verbose_name_plural = (u'Типы военных конфликтов при расчетах')

class MilitaryConflict(models.Model):
    """
    Военный конфликт
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Название военного конфликта", max_length=100, db_index=True)
    brief = models.CharField(u"Сокращенное наименование", max_length=100, blank=True, null=True)
    type = models.ForeignKey('ConflictPrintingGroup', verbose_name=u"Признак группировки при печати", blank=True, null=True)       # Признак группировки при печати

    def __unicode__(self):
        return self.name

    def short_name(self):
        return self.type or self.brief or self.name

    class Meta:
        verbose_name = (u'Военный конфликт')
        verbose_name_plural = (u'Военные конфликты')

class MemorialState(models.Model):
    """
    Состояние памятника
    """
    name = models.CharField(u"Состояние памятника", max_length=100, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Состояние памятника')
        verbose_name_plural = (u'Состояние памятника')

class Burial(models.Model):
    """
    Захоронение
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    oblocationid = models.IntegerField(blank=True, null=True, editable=False)
    uuid = UUIDField(primary_key=True)
    passportid = models.PositiveIntegerField(u"Номер паспорта воинского захоронения",  blank=True, null=True, db_index=True, unique=True)
    date_closed = models.DateField(u"Дата закрытия", blank=True, null=True, editable=False, db_index=True)
    burial_type = models.ForeignKey(BurialType, verbose_name=u"Тип воинского захоронения", blank=True, null=True)
    military_conflict = models.ForeignKey(MilitaryConflict, verbose_name=u"Военный конфликт", blank=True, null=True)
    state = models.ForeignKey(MemorialState, verbose_name=u"Состояние памятника", blank=True, null=True)
    names_count = models.PositiveSmallIntegerField(u"Кол-во имен на могильной плите", default=0)

    location = models.ForeignKey(SimpleLocation, null=True, blank=True)

    date_passport = models.DateField(u"Дата создания паспорта", blank=True, null=True, db_index=True)
    date_passport_no_month = models.BooleanField(default=False, editable=False)
    date_passport_no_day = models.BooleanField(default=False, editable=False)

    date_gosznak = models.DateField(u"Дата установки государственного знака", blank=True, null=True, db_index=True)
    date_gosznak_no_month = models.BooleanField(default=False, editable=False)
    date_gosznak_no_day = models.BooleanField(default=False, editable=False)

    date_burried = models.DateField(u"Дата создания захоронения", blank=True, null=True, db_index=True)
    date_burried_no_month = models.BooleanField(default=False, editable=False)
    date_burried_no_day = models.BooleanField(default=False, editable=False)

    date_discovered = models.DateField(u"Дата обнаружения", blank=True, null=True, db_index=True)
    date_discovered_no_month = models.BooleanField(default=False, editable=False)
    date_discovered_no_day = models.BooleanField(default=False, editable=False)

    date_memorial = models.DateField(u"Дата установки памятника", blank=True, null=True, db_index=True)
    date_memorial_no_month = models.BooleanField(default=False, editable=False)
    date_memorial_no_day = models.BooleanField(default=False, editable=False)

    photo = models.ImageField(u"Фото", upload_to=slugify_filename(prefix="bpics"), blank=True, null=True)
    scheme = models.ImageField(u"Схема", upload_to=slugify_filename(prefix="bpics"), blank=True, null=True)
    creator = models.ForeignKey(User, blank=True, null=True, editable=False, verbose_name=u"Создатель записи")
    date_of_creation = models.DateTimeField(u"Дата создания записи", auto_now_add=True, db_index=True)
    date_of_update = models.DateTimeField(u"Дата обновления записи", auto_now=True, db_index=True)
    info = models.TextField(verbose_name=u"Дополнительная информация о захоронении", blank=True, null=True)
    is_registered = models.BooleanField(u"Учтенное", default=True, db_index=True, editable=False)
    is_trash = models.BooleanField(u"В корзине", default=False, db_index=True, editable=False)

    def __unicode__(self):
        return u'%s, %s' % (self.passportid or u'без паспорта', self.location)

    def get_full_persons(self):
        return self.person_set.all().select_related()

    @property
    def passport_id_int(self):
        try:
            return int(self.passportid)
        except ValueError:
            return self.passportid

    class Meta:
        verbose_name = (u'Захоронение')
        verbose_name_plural = (u'Захоронения')
        ordering = ['passportid']

    def get_info(self):
        return self.info.replace('.', '. ')

    def stats(self, dead_cats=None):
        stats = cache.get('stats_burial_%s' % self.pk)
        if not stats or False:
            r = cemetery_redis.Redis()

            if not dead_cats:
                dead_cats = [
                    DeadmanCategory.objects.get(name=u"Военнослужащий"),
                    DeadmanCategory.objects.get(name=u"Участник сопротивления"),
                    DeadmanCategory.objects.get(name=u"Жертва войны"),
                    DeadmanCategory.objects.get(name=u"Военнопленный"),
                    DeadmanCategory.objects.get(name=u"Другие"),
                ]

            stats = {
                'all': r.all_for_burial(self),
                'known': r.known_for_burial(self),
                'unknown': r.unknown_for_burial(self),
                'soldiers': r.known_for_burial_list_and_cat([self], dead_cats[0]),
                'resistance': r.known_for_burial_list_and_cat([self], dead_cats[1]),
                'prey': r.known_for_burial_list_and_cat([self], dead_cats[2]),
                'prisoners': r.known_for_burial_list_and_cat([self], dead_cats[3]),
                'other': r.known_for_burial_list_and_cat([self], dead_cats[4]),
            }

            cache.set('stats_burial_%s' % self.pk, stats, 10)
        return stats

    # get persons count from all previous burials
    def get_count(self):
        count = sum([bc.custom_known for bc in self.burial_categories.all()] + [0])
        if not count:
            count = self.person_set.count()

        if self.burial_to:
            for cb in self.burial_to.all():
                count += cb.burial_from.get_count()
        return count

    def get_qunknown(self):
        count = sum([bc.unknown for bc in self.burial_categories.all()] + [0])
        if self.burial_to:
            for cb in self.burial_to.all():
                count += cb.burial_from.get_qunknown()
        return count

    def get_last(self):
        last = self
        try:
            last = self.burial_from.burial_to.get_last()
        except:
            pass
        return last

    def get_unclear_date(self, field_name):
        if not getattr(self, field_name, None):
            return None
        cur_date = getattr(self, field_name)
        tmp_date = UnclearDate(cur_date.year, cur_date.month, cur_date.day)
        if getattr(self, field_name+'_no_day'):
            tmp_date.day = None
            tmp_date.no_day = True
        if getattr(self, field_name+'_no_month'):
            tmp_date.month = None
            tmp_date.no_month = True
        return tmp_date

    def set_unclear_date(self, field_name, ud):
        setattr(self, field_name, ud)
        if ud:
            setattr(self, field_name+'_no_day', ud.no_day)
            setattr(self, field_name+'_no_month', ud.no_month)

    @property
    def get_unclear_date_gosznak(self):
        return self.get_unclear_date('date_gosznak')

    @property
    def get_unclear_date_burried(self):
        return self.get_unclear_date('date_burried')

    @property
    def get_unclear_date_discovered(self):
        return self.get_unclear_date('date_discovered')

    @property
    def get_unclear_date_memorial(self):
        return self.get_unclear_date('date_memorial')

    @property
    def get_unclear_date_passport(self):
        return self.get_unclear_date('date_passport')

    def mem_photos_pairs(self):
        mem_photos = list(self.mem_photos.all())
        for i in range(0, int(math.ceil(float(len(mem_photos)) / 2))):
            try:
                yield (mem_photos[i*2], mem_photos[i*2+1])
            except IndexError:
                yield (mem_photos[i*2], None)

class ClosureCause(models.Model):
    """
    Причина закрытия захоронения
    """
    name = models.CharField(u"Причина закрытия захоронения", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Причина закрытия захоронения')
        verbose_name_plural = (u'Причины закрытия захоронения')

class ClosedBurial(models.Model):
    """
    Входящие захоронения.
    """
    burial_from = models.OneToOneField(Burial, related_name="burial_from", verbose_name = u'Откуда выполнен перенос', primary_key=True) 
    burial_to = models.ForeignKey(Burial, related_name="burial_to", verbose_name = u'Куда выполнен перенос')  
    date = models.DateField(u"Дата закрытия")
    cause = models.ForeignKey(ClosureCause, verbose_name=u"Причина перезахоронения")
    document = models.FileField(u"Документ", upload_to=slugify_filename(prefix='documents/'), blank=True, null=True)
    def __unicode__(self):
        return u"Закрыто: %s" % self.cause
    class Meta:
        verbose_name = (u'Перенос захоронения')
        verbose_name_plural = (u'Перенос захоронения')

def close_burial(instance, **kwargs):
    instance.burial_from.date_closed = datetime.datetime.now()
    instance.burial_from.save()

    persons = Person.objects.filter(burial=instance.burial_from)
    instance.burial_from.closed_persons.add(*list(persons))
    persons.update(burial=instance.burial_to)

models.signals.post_save.connect(close_burial, ClosedBurial)

class BurialEditCause(models.Model):
    """
    Основание для внесения изменения
    """
    burial = models.ForeignKey(Burial)                                          
    name = models.CharField(u"Название документа", max_length=100)
    number = models.CharField(u"Номер документа", max_length=100)
    date = models.DateField(u"Дата документа")
    date_edit = models.DateTimeField(auto_now_add=True)                     # Дата редактирования
    user = models.ForeignKey(User)                                          # Редактор

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = (u'Основание для внесения изменения')
        verbose_name_plural = (u'Основания для внесения изменения')

class BurialPictures(models.Model):
    """Фотография захоронения
    """
    burial = models.ForeignKey(u'Burial', related_name='mem_photos')
    photo = models.ImageField(u"Фото", upload_to=slugify_filename(prefix="bpics"), null=True)
    comment = models.TextField(blank=True, null=True)                               # Дополнительная информация

    def __unicode__(self):
        return self.photo and os.path.basename(self.photo.path) or u'empty pic'

    class Meta:
        verbose_name = (u'Фотография мемориальной плиты')
        verbose_name_plural = (u'Фотографии мемориальной плиты')

class BurialAttachment(models.Model):
    """Приложение захоронения
    """
    burial = models.ForeignKey(u'Burial')
    file = models.FileField(u"Приложение", upload_to=slugify_filename(prefix="bfiles"), null=True)

    def __unicode__(self):
        return self.file and os.path.basename(self.file.path) or u'empty pic'

    class Meta:
        verbose_name = (u'Приложение')
        verbose_name_plural = (u'Приложения')

class PersonAttachment(models.Model):
    """Приложение воина
    """
    burial = models.ForeignKey(u'Person')
    file = models.FileField(u"Приложение", upload_to=slugify_filename(prefix="bfiles"), null=True)

    def __unicode__(self):
        return self.file and os.path.basename(self.file.path) or u'empty pic'

    class Meta:
        verbose_name = (u'Приложение')
        verbose_name_plural = (u'Приложения')

class BurialInformationLinks(models.Model):
    """
    Ссылка на доп. информацию о месте захоронения
    """
    burial = models.ForeignKey(Burial)                                          # Связь с Захоронением
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Ссылка на доп. информацию о месте захоронения')
        verbose_name_plural = (u'Ссылки на доп. информацию о месте захоронения')

class SearchObject(models.Model):
    """
    Поисковый объект
    """
    burial = models.OneToOneField(Burial)                                               # Связь с Захоронением
    number = models.CharField(u"Номер поискового объекта", max_length=100)               # Номер поискового объекта
    date = models.DateField(u"Дата отработки", blank=True, null=True)                    # Дата отработки
    inv_number = models.CharField(u"Номер поискового дела", max_length=100)              # Номер поискового объекта
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.number
    class Meta:
        verbose_name = (u'Поисковый объект')
        verbose_name_plural = (u'Поисковые объекты')

class DeathCause(models.Model):
    """
    Причина гибели
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Причина гибели", max_length=100, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Причина гибели')
        verbose_name_plural = (u'Причины гибели')

class DeadmanCategory(models.Model):
    """
    Категория захороненного
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Категория захороненного", max_length=100, db_index=True)
    brief = models.CharField(u"Краткое название категории захороненных", max_length=100, blank=True, null=True)
    ordering = models.PositiveSmallIntegerField(u"сортировка", default=1)

    def __unicode__(self):
        return self.name

    def short_name(self):
        return self.type or self.brief or self.name

    class Meta:
        ordering = ['ordering', ]
        verbose_name = (u'Категория погибшего')
        verbose_name_plural = (u'Категории погибших')

class BurialCategory(models.Model):
    """
    Связь категории с захоронением
    """
    category = models.ForeignKey(DeadmanCategory, related_name='burial_categories', verbose_name=u"Категория")
    burial = models.ForeignKey(Burial, related_name='burial_categories')
    custom_known = models.PositiveIntegerField(default=0, verbose_name=u"Известных")
    known = models.PositiveIntegerField(default=0, verbose_name=u"Введено фамилий")
    unknown = models.PositiveIntegerField(default=0, verbose_name=u"Неизвестных")
    updated = models.DateTimeField(auto_now=True)

    def __unicode__(self):
        return u'%s - %s' % (self.burial, self.category)

    class Meta:
        verbose_name = (u'Количество захороненных')
        verbose_name_plural = (u'Количество захороненных')

    def save(self, *args, **kwargs):
        r = cemetery_redis.Redis()
        pipe = r.db.pipeline()
        burial_id = self.burial.pk

        if self.custom_known is not None:
            k = self.custom_known
        else:
            k = self.known

        pipe.set('cemetery:burial:%s:category:%s' % (burial_id, self.category.pk), k)
        pipe.set('cemetery:burial:%s:category:%s:unknown' % (burial_id, self.category.pk), self.unknown)
        pipe.execute()
        super(BurialCategory, self).save(*args, **kwargs)

    def update(self):
        self.known = self.burial.person_set.filter(deadman_category=self.category).count()
        if self.category.name == u'Другие':
            self.known += self.burial.person_set.filter(deadman_category__isnull=True).count()
        self.updated = datetime.datetime.now()
        self.save()

class DocumentsPlace(models.Model):
    """
    Место нахождения документов
    """
    name = models.CharField(u"Место нахождения документов", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Место нахождения документов')
        verbose_name_plural = (u'Места нахождения документов')

class InformationSource(models.Model):
    """
    Источники информации
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Источник информации", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Источник информации')
        verbose_name_plural = (u'Источники информации')

class Nationality(models.Model):
    """
    Национальность
    """
    name = models.CharField(u"Название", max_length=100, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Национальность')
        verbose_name_plural = (u'Национальности')

class UnclearDate:
    def __init__(self, year, month=None, day=None):
        self.d = datetime.date(year, month or 1, day or 1)
        self.no_day = not day
        self.no_month = not month

    def strftime(self, format):
        if self.no_day:
            format = format.replace('%d.', '')
        if self.no_month:
            format = format.replace('%m.', '')

        if self.d.year < 1900:
            d1 = datetime.date(1900 + self.d.year % 100, self.d.month, self.d.day)
            return d1.strftime(format).replace(str(d1.year), str(self.d.year))
        return self.d.strftime(format)

    def __repr__(self):
        return u'<UnclearDate: %s>' % self.strftime('%d.%m.%Y')

    def __unicode__(self):
        return self.strftime('%d.%m.%Y')

    @property
    def year(self):
        return self.d.year

    @property
    def month(self):
        return not self.no_month and self.d.month or None

    @property
    def day(self):
        return not self.no_day and self.d.day or None



class Person(models.Model):
    """
    Человек.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    oblocationid = models.IntegerField(blank=True, null=True, editable=False)
    uuid = UUIDField(primary_key=True)
    burial = models.ForeignKey(Burial, verbose_name=u"Номер захоронения", blank=True, null=True)
    closed_burials = models.ManyToManyField(Burial,
        related_name='closed_persons', verbose_name=u"Перенесен из", help_text=u"", editable=False)
    mia = models.BooleanField(u"Пропал без вести", blank=True, default=False, db_index=True)
    outside_rb = models.BooleanField(u"За пределами РБ", blank=True, default=False, db_index=True)
    last_name = models.CharField(u"Фамилия", max_length=128, db_index=True)
    first_name = models.CharField(u"Имя", max_length=30, blank=True, db_index=True)
    patronymic = models.CharField(u"Отчество", max_length=30, blank=True, db_index=True)

    birth_location = models.ForeignKey(SimpleLocation, null=True, blank=True)

    birth_date = models.DateField(u"Дата рождения", blank=True, null=True, db_index=True)
    birth_date_no_month = models.BooleanField(default=False, editable=False)
    birth_date_no_day = models.BooleanField(default=False, editable=False)
    death_date = models.DateField(u"Дата гибели", blank=True, null=True, db_index=True)
    death_date_no_month = models.BooleanField(default=False, editable=False)
    death_date_no_day = models.BooleanField(default=False, editable=False)

    death_cause = models.ForeignKey(DeathCause, verbose_name=u"Причина гибели", blank=True, null=True)
    nationality = models.ForeignKey(Nationality, verbose_name=u"Национальность", blank=True, null=True)
    deadman_category = models.ForeignKey(DeadmanCategory, verbose_name=u"Категория погибшего", blank=True, null=True)
    documents_place = models.ForeignKey(DocumentsPlace, verbose_name=u"Место нахождения документов", blank=True, null=True)
    information_source = models.ForeignKey(InformationSource, verbose_name=u"Источник информации", blank=True, null=True)
    info = models.TextField(u"Доп. информация о месте захоронения", blank=True, null=True)
    creator = models.ForeignKey(User, verbose_name=u"Создатель записи", blank=True, null=True, editable=False)
    date_of_creation = models.DateTimeField(u"Дата создания записи", auto_now_add=True, editable=False)
    is_trash = models.BooleanField(u"Удалена", default=False, db_index=True, editable=False)

    edit_causes = property(lambda self: self.personeditcause_set.all().order_by('-date_edit'))
    last_edit_obj = property(lambda self: self.edit_causes and self.edit_causes[0] or None)
    last_edit = property(lambda self: (self.edit_causes and self.edit_causes[0].date_edit or self.date_of_creation).strftime(u'%d.%m.%Y %H:%M'))

    birth_location_info = models.TextField(verbose_name=u"Доп. информация о месте рождения", blank=True, null=True)

    class Meta:
        ordering = ['last_name'] # Сортировка по фамилии
        verbose_name = (u'Погибший')
        verbose_name_plural = (u'Погибшие')

    def __unicode__(self):
        return u'%s' % self.last_name

    def save(self, *args, **kwargs):
        self.first_name = self.first_name.upper()
        self.last_name = self.last_name.upper()
        self.patronymic = self.patronymic.upper()
        super(Person, self).save(*args, **kwargs)

    def get_info(self):
        return self.info.replace('.', '. ')

    def get_unclear_date(self, field_name):
        if not getattr(self, field_name, None):
            return None
        cur_date = getattr(self, field_name)
        tmp_date = UnclearDate(cur_date.year, cur_date.month, cur_date.day)
        if getattr(self, field_name+'_no_day'):
            tmp_date.no_day = True
        if getattr(self, field_name+'_no_month'):
            tmp_date.no_month = True
        return tmp_date

    def set_unclear_date(self, field_name, ud):
        setattr(self, field_name, ud)
        if ud:
            setattr(self, field_name+'_no_day', ud.no_day)
            setattr(self, field_name+'_no_month', ud.no_month)

    @property
    def get_unclear_birth_date(self):
        return self.get_unclear_date('birth_date')

    @property
    def get_unclear_death_date(self):
        return self.get_unclear_date('death_date')

class MilitaryUnit(models.Model):
    """
    Воинское подразделение
    """
    name = models.CharField(u"Воинское подразделение", max_length=100, db_index=True)
    location = models.OneToOneField(SimpleLocation, null=True, blank=True, editable=False)

    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ['name']
        verbose_name = (u'Воинское подразделение')
        verbose_name_plural = (u'Воинские подразделения')

class Comissariat(models.Model):
    """
    Военкомат
    """
    name = models.CharField(u"Название военкомата", max_length=100, blank=True, null=True)
    location = models.OneToOneField(SimpleLocation, null=True, blank=True, verbose_name=u'Местоположение')

    def __unicode__(self):
        name = self.name or (self.location and self.location.district) or u'Неизвестный'
        return u'%s' % name

    class Meta:
        ordering = ['name']
        verbose_name = (u'Военкомат')
        verbose_name_plural = (u'Военкоматы')

class PersonCall(models.Model):
    """
    Место призыва
    """
    person = models.OneToOneField(Person, primary_key=True)  
    unit = models.ForeignKey(Comissariat, verbose_name=u"Военкомат", blank=True, null=True)
    date = models.DateField(u"Дата призыва", blank=True, null=True)
    date_no_month = models.BooleanField(default=False, editable=False)
    date_no_day = models.BooleanField(default=False, editable=False)

    def __unicode__(self):
        if self.unit:
            return u'%s' % self.unit.name
        else:
            return u'Не указано'

    class Meta:
        verbose_name = (u'Место призыва')
        verbose_name_plural = (u'Место призыва')

    def get_unclear_date(self, field_name=None):
        if not field_name:
            field_name = 'date'
        if not getattr(self, field_name, None):
            return None
        cur_date = getattr(self, field_name)
        tmp_date = UnclearDate(cur_date.year, cur_date.month, cur_date.day)
        if getattr(self, field_name+'_no_day'):
            tmp_date.day = None
            tmp_date.no_day = True
        if getattr(self, field_name+'_no_month'):
            tmp_date.month = None
            tmp_date.no_month = True
        return tmp_date

    def set_unclear_date(self, field_name, ud):
        setattr(self, field_name, ud)
        if ud:
            setattr(self, field_name+'_no_day', ud.no_day)
            setattr(self, field_name+'_no_month', ud.no_month)

class Post(models.Model):
    """
    Должность
    """
    name = models.CharField(u"Должность", max_length=100, db_index=True)
    
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Должность')
        verbose_name_plural = (u'Должности')
        ordering = ['name', ]

class Rank(models.Model):
    """
    Воинское звание.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Звание", max_length=100, db_index=True)

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = (u'воинское звание')
        verbose_name_plural = (u'воинские звания')
        ordering = ['name', ]

class PersonDuty(models.Model):
    """
    Место службы
    """
    person = models.OneToOneField(Person, primary_key=True) 
    unit = models.ForeignKey(MilitaryUnit, verbose_name=u"Воинское подразделение", editable=False, null=True)
    unit_name = models.CharField(u"Воинское подразделение", max_length=255, db_index=True, blank=True, null=True)
    rank = models.ForeignKey(Rank, verbose_name=u"Звание", blank=True, null=True)
    post = models.ForeignKey(Post, verbose_name=u"Должность", blank=True, null=True)

    def __unicode__(self):
        s = u'%s %s %s' % (self.rank or u'', self.post or u'', self.unit_name or u'')
        return s.strip()

    class Meta:
        verbose_name = (u'Место службы')
        verbose_name_plural = (u'Место службы')

class PersonEditCause(models.Model):
    """
    Основание для редактирования Воина
    """
    person = models.ForeignKey(Person)
    name = models.CharField(u"Название документа", max_length=100)
    number = models.CharField(u"Номер документа", max_length=100)
    date = models.DateField(u"Дата документа")
    file = models.FileField(u"Скан документа", null=True, upload_to=slugify_filename(prefix='cause_docs'), blank=True)
    date_edit = models.DateTimeField(auto_now=True)                             # Дата последнего редактирования записи

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = (u'Основание для редакирования Воина')
        verbose_name_plural = (u'Основания для редактирования Воина')

class PersonInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    person = models.ForeignKey(Person) 
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Ссылка на информационные источники')
        verbose_name_plural = (u'Ссылки на информационные источники')

