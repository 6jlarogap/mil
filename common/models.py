# -*- coding: utf-8 -*-

from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User

from smart_selects.db_fields import ChainedForeignKey

class GeoCountry(models.Model):
    """
    Страна.
    """
    obid = models.IntegerField(blank=True, null=True)
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
    obid = models.IntegerField(blank=True, null=True)
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
    obid = models.IntegerField(blank=True, null=True)
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
    obid = models.IntegerField(blank=True, null=True)
    country = models.ForeignKey(GeoCountry, verbose_name=u"Страна", blank=True, null=True)       # Страна
    region = ChainedForeignKey(GeoRegion, verbose_name=u"Регион", chained_field="country", chained_model_field="country", blank=True, null=True)
    city = ChainedForeignKey(GeoCity, verbose_name=u"Город", chained_field="region", chained_model_field="region", blank=True, null=True)
#    region = models.ForeignKey(GeoRegion, verbose_name=u"Регион", blank=True, null=True)         # Регион
#    city = models.ForeignKey(GeoCity, verbose_name=u"Город", blank=True, null=True)              # Город
    info = models.TextField(u"Уточнение адреса", blank=True, null=True)
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

class DeathCause(models.Model):
    """
    Причина гибели
    """
    obid = models.IntegerField(blank=True, null=True)
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
    obid = models.IntegerField(blank=True, null=True)
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

class BurialType(models.Model):
    """
    Тип воинского захоронения
    """
    obid = models.IntegerField(blank=True, null=True)
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
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField(u"Название военного конфликта", max_length=100)
    brief = models.CharField(u"Краткое название военного конфликта", max_length=100, blank=True, null=True)
    type = models.ForeignKey(MilitaryConflictType, blank=True, null=True)          # Тип военного конфликта
    comment = models.TextField(u"Комментарий", blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Военный конфликт')
        verbose_name_plural = (u'Военные конфликты')

class InformationSource(models.Model):
    """
    Источники информации
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField(u"Источник информации", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Источник информации')
        verbose_name_plural = (u'Источники информации')

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

class Person(models.Model):
    """
    Человек.
    """
    obid = models.IntegerField(blank=True, null=True)
    oblocationid = models.IntegerField(blank=True, null=True)
    uuid = UUIDField(primary_key=True)
    last_name = models.CharField(u"Фамилия", max_length=128)                     # Фамилия
    first_name = models.CharField(u"Имя", max_length=30, blank=True)             # Имя
    patronymic = models.CharField(u"Отчество", max_length=30, blank=True)        # Отчество
    birth_date = models.DateField(u"Дата рождения", blank=True, null=True)       # Дата рождения
    death_date = models.DateField(u"Дата смерти", blank=True, null=True)         # Дата гибели
    death_cause = models.ForeignKey(DeathCause, blank=True, null=True)          # Причина гибели
    nationality = models.ForeignKey(Nationality, blank=True, null=True)         # Национальность
    deadman_category = models.ForeignKey(DeadmanCategory, blank=True, null=True)    # Категория погибшего
    documents_place = models.ForeignKey(DocumentsPlace, blank=True, null=True)   # Место нахождения документов
    information_source = models.ForeignKey(InformationSource, blank=True, null=True)   # Источник информации
    info = models.TextField(u"Информация о месте жительства и родственниках", blank=True, null=True)
    creator = models.ForeignKey(User, blank=True, null=True)                    # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                  # Дата создания записи
    date_last_edit = models.DateTimeField(auto_now=True)                        # Дата последнего редактирования записи
    is_trash = models.BooleanField(default=False)                               # В корзине
    class Meta:
        ordering = ['last_name'] # Сортировка по фамилии
        verbose_name = (u'Погибший')
        verbose_name_plural = (u'Погибшие')

    def __unicode__(self):
        return u'%s' % self.last_name

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
    person = models.OneToOneField(Person, primary_key=True)                      # Связь с воином
    unit = models.ForeignKey(MilitaryUnit, blank=True, null=True)                  # Воинское подразделение
    date = models.DateField(u"Дата призыва", blank=True, null=True)

    def __unicode__(self):
        return u'%s' % (self.duty.name)
    class Meta:
        verbose_name = (u'Место призыва')

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
    obid = models.IntegerField(blank=True, null=True)
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
    person = models.OneToOneField(Person, primary_key=True)                      # Связь с воином
    unit = models.ForeignKey(MilitaryUnit, blank=True, null=True)                  # Воинское подразделение
    rank = models.ForeignKey(Rank, blank=True, null=True)                       # Звание
    post = models.ForeignKey(Post, blank=True, null=True)                       # Должность
#    date_from = models.DateField("Дата начала службы", blank=True, null=True)
#    date_to = models.DateField("Дата окончания службы", blank=True, null=True)

    def __unicode__(self):
        return u'%s %s %s' % (self.rank, self.post, self.unit)
    class Meta:
        verbose_name = (u'История службы')

class PersonEditCause(models.Model):
    """
    Основание для редактирования Воина
    """
    person = models.ForeignKey(Person)                                          # Связь с Воином
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
    person = models.ForeignKey(Person)                                          # Связь с Воином
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = (u'Ссылка на информационные источники')
        verbose_name_plural = (u'Ссылки на информационные источники')

class LocationBirth(Location):
    """
    Адрес рождения.
    """
    person = models.OneToOneField(Person, primary_key=True)
    class Meta:
        verbose_name = (u'Адрес рождения')
        verbose_name_plural = (u'Адрес рождения')

class Burial(models.Model):
    """
    Захоронение
    """
    obid = models.IntegerField(blank=True, null=True)
    oblocationid = models.IntegerField(blank=True, null=True)
    uuid = UUIDField(primary_key=True)
    persons = models.ManyToManyField(Person, through='PersonBurial')
    passportid = models.CharField(u"Номер паспорта захоронения",  blank=True, null=True, max_length=128)
    date_passport = models.DateField(u"Дата создания паспорта", blank=True, null=True)
    date_burried = models.DateField(u"Дата создания захоронения", blank=True, null=True)
    date_discovered = models.DateField(u"Дата обнаружения", blank=True, null=True)
    burial_type = models.ForeignKey(BurialType, blank=True, null=True)                      # Тип воинского захоронения
    military_conflict = models.ForeignKey(MilitaryConflict, blank=True, null=True)          # Военный конфликт
    date_memorial = models.DateField(u"Дата установки памятника", blank=True, null=True)
    date_gosznak = models.DateField(u"Дата установки госзнака", blank=True, null=True)
    qunknown = models.IntegerField(u"Количество неизвестных захороненных", blank=True, null=True)
    photo = models.ImageField(u"Фото", upload_to="bpics", blank=True, null=True)
    scheme = models.ImageField(u"Схема", upload_to="bpics", blank=True, null=True)
    creator = models.ForeignKey(User, blank=True, null=True)                                # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                              # Дата создания записи
    date_last_edit = models.DateTimeField(auto_now=True)                                    # Дата последнего изменения
    info = models.TextField(blank=True, null=True)                               # Дополнительная информация о захоронении.
    is_trash = models.BooleanField(default=False)                                           # В корзине

    def __unicode__(self):
        if self.passportid:
            return self.passportid
        else:
            return u'без паспорта'
    class Meta:
        verbose_name = (u'Захоронение')
        verbose_name_plural = (u'Захоронения')

class PersonBurial(models.Model):
    """
    Захоронение военнослужащего
    """
    person = models.ForeignKey(Person)                                          # Персона.
    burial = models.ForeignKey(Burial)                                          # Захоронение.
    date_burried = models.DateField(u"Дата захоронения", blank=True, null=True)
#    date_exhumated = models.DateField(u"Дата эксгумации", blank=True, null=True)
    bnamed = models.BooleanField(u"Признак нанесения имени на надмогильное сооружение")

    def __unicode__(self):
        if self.burial.passportid:
            return u'%s - %s' % (self.person.last_name, self.burial.passportid)
        else:
            return u'%s захоронение без паспорта' % self.person.last_name

    class Meta:
        verbose_name = (u'Захоронения военнослужащего')
        verbose_name_plural = (u'Захоронения военнослужащих')
        unique_together = (("person", "burial"),)

class BurialEditCause(models.Model):
    """
    Основание для внесения изменения
    """
    burial = models.ForeignKey(Burial)                                          # Связь с Воином
    name = models.CharField(u"Название документа", max_length=100)
    number = models.CharField(u"Номер документа", max_length=100)
    date = models.DateField(u"Дата документа")
    date_of_creation = models.DateTimeField(auto_now_add=True)                              # Дата создания записи
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
    number = models.CharField(u"Номер поискового объекта", max_length=100)               # Номер поискового объекта
    date = models.DateField(u"Дата отработки", blank=True, null=True)                    # Дата отработки
    inv_number = models.CharField(u"Номер поискового дела", max_length=100)              # Номер поискового объекта
    burial = models.OneToOneField(Burial)                                               # Связь с Захоронением
    link = models.URLField(u"Ссылка", max_length=100)
    def __unicode__(self):
        return self.number
    class Meta:
        verbose_name = (u'Поисковый объект')
        verbose_name_plural = (u'Поисковые объекты')

class ClosedBurial(models.Model):
    """
    Входящие захоронения.
    """
    burial_from = models.OneToOneField(Burial, primary_key=True) 
    burial_to = models.ForeignKey(Burial, related_name="burial_to", verbose_name = u'Куда выполнен перенос')  
    date = models.DateField("Дата закрытия")
    cause = models.ForeignKey(ClosureCause)                                                 # Причина перезахоронения
    class Meta:
        verbose_name = (u'Перенос захоронения')
        verbose_name_plural = (u'Перенос захоронений')

class LocationBurial(Location):
    """
    Адрес захоронения
    """
    burial = models.OneToOneField(Burial, primary_key=True)
    class Meta:
        verbose_name = (u'Адрес захоронения')
        verbose_name_plural = (u'Адрес захоронения')


