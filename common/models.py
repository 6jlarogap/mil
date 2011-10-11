# -*- coding: utf-8 -*-

import datetime

from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User

from smart_selects.db_fields import ChainedForeignKey

class GeoCountry(models.Model):
    """
    Страна.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Название", max_length=36, db_index=True, unique=True)
    def __unicode__(self):
        return self.name
    class Meta:
        #managed = False
        #db_table = "common_country"
        ordering = ['name']
        verbose_name = u'страна'
        verbose_name_plural = u'страны'


class GeoRegion(models.Model):
    """
    Регион.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    country = models.ForeignKey(GeoCountry)
    name = models.CharField(u"Название", max_length=36, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        unique_together = (("country", "name"),)
        verbose_name = u'регион'
        verbose_name_plural = u'регионы'


class GeoCity(models.Model):
    """
    Город.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    region = models.ForeignKey(GeoRegion)
    name = models.CharField("Название", max_length=36, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'населенный пункт'
        verbose_name_plural = u'населенные пункты'


class GeoStreet(models.Model):
    """
    Улица.
    """
    city = models.ForeignKey(GeoCity)  # Город.
    name = models.CharField(max_length=99, db_index=True)  # Название.
    class Meta:
        ordering = ['city', 'name']
        unique_together = (("city", "name"),)
        verbose_name = (u'улица')
        verbose_name_plural = (u'улицы')
    def __unicode__(self):
        return self.name

class Location(models.Model):
    """
    Абстрактный адрес
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    country = models.ForeignKey(GeoCountry, verbose_name=u"Страна", blank=True, null=True)       # Страна
    region = ChainedForeignKey(GeoRegion, verbose_name=u"Регион", chained_field="country", chained_model_field="country", blank=True, null=True)
    city = ChainedForeignKey(GeoCity, verbose_name=u"Город", chained_field="region", chained_model_field="region", blank=True, null=True)
    info = models.TextField(u"Дополнительная информация", blank=True, null=True)
    gps_x = models.FloatField(u"Координата X", blank=True, null=True)                            # GPS X-ось.
    gps_y = models.FloatField(u"Координата Y", blank=True, null=True)                            # GPS Y-ось.
    gps_z = models.FloatField(u"Координата Z", blank=True, null=True)                            # GPS Z-ось.

    def __unicode__(self):
        ret = u"незаполненный адрес"
        if self.city:
            ret = self.city
            if self.city.region:
                ret = u'%s %s' % (self.city.region, ret)
                if self.city.region.country:
                    ret = u'%s %s' % (self.city.region.country, ret)
        if self.info:
            ret = u'%s %s' % (ret, self.info)
        return ret
    class Meta:
        abstract = True

class BurialType(models.Model):
    """
    Тип воинского захоронения
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Название типа захоронения", max_length=100)
    brief = models.CharField(u"Краткое название типа воинского захоронения", max_length=100, blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Тип воинского захоронения')
        verbose_name_plural = ('Типы воинских захоронений')

class MilitaryConflictType(models.Model):
    """
    Тип военного конфликта
    """
    full = models.CharField(u"Полное название типа военного конфликта", max_length=100)
    brief = models.CharField(u"Краткое название типа военного конфликта", max_length=100)
    def __unicode__(self):
        return self.full
    class Meta:
        verbose_name = (u'Тип военного конфликта')
        verbose_name_plural = (u'Типы военных конфликтов')

class MilitaryConflict(models.Model):
    """
    Военный конфликт
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Название военного конфликта", max_length=100)
    brief = models.CharField(u"Краткое название военного конфликта", max_length=100, blank=True, null=True)
    type = models.ForeignKey(MilitaryConflictType, blank=True, null=True)          # Тип военного конфликта
    comment = models.TextField(u"Комментарий", blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Военный конфликт')
        verbose_name_plural = (u'Военные конфликты')

class MemorialState(models.Model):
    """
    Состояние памятника
    """
    name = models.CharField(u"Состояние памятника", max_length=100)
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
    passportid = models.CharField(u"Номер паспорта захоронения",  blank=True, null=True, max_length=128)
    date_passport = models.DateField(u"Дата создания паспорта", blank=True, null=True)
    date_burried = models.DateField(u"Дата создания захоронения", blank=True, null=True)
    date_discovered = models.DateField(u"Дата обнаружения", blank=True, null=True)
    burial_type = models.ForeignKey(BurialType, verbose_name=u"Тип воинского захоронения", blank=True, null=True)
    military_conflict = models.ForeignKey(MilitaryConflict, verbose_name=u"Военный конфликт", blank=True, null=True)
    date_memorial = models.DateField(u"Дата установки памятника", blank=True, null=True)
    state = models.ForeignKey(MemorialState, verbose_name=u"Состояние памятника", blank=True, null=True)
    date_gosznak = models.DateField(u"Дата установки госзнака", blank=True, null=True)
    qunknown = models.IntegerField(u"Количество неизвестных захороненных", blank=True, null=True)
    photo = models.ImageField(u"Фото", upload_to="bpics", blank=True, null=True)
    scheme = models.ImageField(u"Схема", upload_to="bpics", blank=True, null=True)
    creator = models.ForeignKey(User, blank=True, null=True)                                # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                              # Дата создания записи
    info = models.TextField(verbose_name=u"Дополнительная информация о захоронении", blank=True, null=True)
    is_trash = models.BooleanField(default=False)                                           # В корзине

    def __unicode__(self):
        if self.passportid:
            return self.passportid
        else:
            return u'без паспорта'
    class Meta:
        verbose_name = (u'Захоронение')
        verbose_name_plural = (u'Захоронения')
        ordering = ['passportid']

    # get persons count from all previous burials
    def get_count(self):
        count = self.person_set.count()
        if self.burial_to:
            for cb in self.burial_to.all():
                count += cb.burial_from.get_count()
        return count

    def get_qunknown(self):
        count = self.qunknown
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
    date = models.DateField("Дата закрытия")
    cause = models.ForeignKey(ClosureCause)                                                 # Причина перезахоронения
    class Meta:
        verbose_name = (u'Перенос захоронения')
        verbose_name_plural = (u'Перенос захоронения')

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
    burial = models.ForeignKey(u'Burial')
    photo = models.ImageField(u"Фото", upload_to="bpics", null=True)
    comment = models.TextField(blank=True, null=True)                               # Дополнительная информация

    def __unicode__(self):
        return self.photo and os.path.basename(self.photo.path) or u'empty pic'
    class Meta:
        verbose_name = (u'Фотография захоронения')
        verbose_name_plural = (u'Фотографии захоронения')

class BurialInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    burial = models.ForeignKey(Burial)                                          # Связь с Захоронением
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Ссылка на информационные источники')
        verbose_name_plural = (u'Ссылки на информационные источники')

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

class LocationBurial(Location):
    """
    Адрес захоронения
    """
    burial = models.OneToOneField(Burial, primary_key=True)
    class Meta:
        verbose_name = (u'Адрес захоронения')
        verbose_name_plural = (u'Адрес захоронения')

class DeathCause(models.Model):
    """
    Причина гибели
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Причина гибели", max_length=100)
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
    name = models.CharField(u"Категория захороненного", max_length=100)
    brief = models.CharField(u"Краткое название категории захороненных", max_length=100, blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Категория погибшего')
        verbose_name_plural = (u'Категории погибших')

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
    name = models.CharField(u"Название", max_length=100)
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
            format = format.replace('%d', '-')
        if self.no_month:
            format = format.replace('%m', '-')
        return self.d.strftime(format)

    def __repr__(self):
        return u'<UnclearDate: %s>' % self.strftime('%d.%m.%Y')

    @property
    def year(self):
        return self.d.year

    @property
    def month(self):
        return not self.no_month and self.d.month or None

    @property
    def day(self):
        return not self.no_month and self.d.day or None

class Person(models.Model):
    """
    Человек.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    oblocationid = models.IntegerField(blank=True, null=True, editable=False)
    uuid = UUIDField(primary_key=True)
    burial = models.ForeignKey(Burial, verbose_name=u"Номер захоронения", blank=True, null=True)
    last_name = models.CharField(u"Фамилия", max_length=128)
    first_name = models.CharField(u"Имя", max_length=30, blank=True)
    patronymic = models.CharField(u"Отчество", max_length=30, blank=True)

    birth_date = models.DateField(u"Дата рождения", blank=True, null=True)
    birth_date_no_month = models.BooleanField(default=False, editable=False)
    birth_date_no_day = models.BooleanField(default=False, editable=False)
    death_date = models.DateField(u"Дата гибели", blank=True, null=True)
    death_date_no_month = models.BooleanField(default=False, editable=False)
    death_date_no_day = models.BooleanField(default=False, editable=False)

    death_cause = models.ForeignKey(DeathCause, verbose_name=u"Причина гибели", blank=True, null=True)
    nationality = models.ForeignKey(Nationality, verbose_name=u"Национальность", blank=True, null=True)
    deadman_category = models.ForeignKey(DeadmanCategory, verbose_name=u"Категория погибшего", blank=True, null=True)
    documents_place = models.ForeignKey(DocumentsPlace, verbose_name=u"Место нахождения документов", blank=True, null=True)
    information_source = models.ForeignKey(InformationSource, verbose_name=u"Источник информации", blank=True, null=True)
    info = models.TextField(u"Дополнительная информация", blank=True, null=True)
    creator = models.ForeignKey(User, verbose_name=u"Создатель записи", blank=True, null=True)
    date_of_creation = models.DateTimeField(auto_now_add=True)                      # Дата создания записи
    is_trash = models.BooleanField(default=False)                                   # В корзине

    class Meta:
        ordering = ['last_name'] # Сортировка по фамилии
        verbose_name = (u'Погибший')
        verbose_name_plural = (u'Погибшие')

    def __unicode__(self):
        return u'%s' % self.last_name

    def get_unclear_date(self, field_name):
        if not getattr(self, field_name, None):
            return None
        cur_date = getattr(self, field_name)
        tmp_date = UnclearDate(cur_date.year, cur_date.month, cur_date.day)
        if getattr(self, field_name+'_no_day'):
            tmp_date.day = None
        if getattr(self, field_name+'_no_month'):
            tmp_date.month = None
        return tmp_date

    def set_unclear_date(self, field_name, ud):
        setattr(self, field_name, ud)
        if ud:
            setattr(self, field_name+'_no_day', ud.no_day)
            setattr(self, field_name+'_no_month', ud.no_month)

class MilitaryUnit(Location):
    """
    Воинское подразделение
    """
    name = models.CharField(u"Воинское подразделение", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Воинское подразделение')
        verbose_name_plural = (u'Воинские подразделения')

class PersonCall(models.Model):
    """
    Место призыва
    """
    person = models.OneToOneField(Person, primary_key=True)  
    unit = models.ForeignKey(MilitaryUnit, verbose_name=u"Воинское подразделение", blank=True, null=True)
    date = models.DateField(u"Дата призыва", blank=True, null=True)

    def __unicode__(self):
        return u'%s' % (self.duty.name)
    class Meta:
        verbose_name = (u'Место призыва')
        verbose_name_plural = (u'Место призыва')

class Post(models.Model):
    """
    Должность
    """
    name = models.CharField(u"Должность", max_length=100)
    
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Должность')
        verbose_name_plural = (u'Должности')

class Rank(models.Model):
    """
    Воинское звание.
    """
    obid = models.IntegerField(blank=True, null=True, editable=False)
    name = models.CharField(u"Звание", max_length=100)

    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'воинское звание')
        verbose_name_plural = (u'воинские звания')

class PersonDuty(models.Model):
    """
    Место службы
    """
    person = models.OneToOneField(Person, primary_key=True) 
    unit = models.ForeignKey(MilitaryUnit, verbose_name=u"Воинское подразделение", blank=True, null=True)
    rank = models.ForeignKey(Rank, verbose_name=u"Звание", blank=True, null=True)
    post = models.ForeignKey(Post, verbose_name=u"Должность", blank=True, null=True)

    def __unicode__(self):
        return u'%s %s %s' % (self.rank, self.post, self.unit)
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

class LocationBirth(Location):
    """
    Место рождения
    """
    person = models.OneToOneField(Person, primary_key=True)
    class Meta:
        verbose_name = (u'Место рождения')
        verbose_name_plural = (u'Место рождения')


