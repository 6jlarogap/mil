# -*- coding: utf-8 -*-

from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User

class GeoCountry(models.Model):
    """
    Страна.
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Название", max_length=36, db_index=True, unique=True)
    def __unicode__(self):
        return self.name
    class Meta:
        #managed = False
        #db_table = "common_country"
        ordering = ['name']
        verbose_name = 'страна'
        verbose_name_plural = 'страны'


class GeoRegion(models.Model):
    """
    Регион.
    """
    obid = models.IntegerField(blank=True, null=True)
    country = models.ForeignKey(GeoCountry)
    name = models.CharField("Название", max_length=36, db_index=True)
    def __unicode__(self):
        return self.name
    class Meta:
        unique_together = (("country", "name"),)
        verbose_name = 'регион'
        verbose_name_plural = 'регионы'


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
        verbose_name = 'населенный пункт'
        verbose_name_plural = 'населенные пункты'


class GeoStreet(models.Model):
    """
    Улица.
    """
    city = models.ForeignKey(GeoCity)  # Город.
    name = models.CharField(max_length=99, db_index=True)  # Название.
    class Meta:
        ordering = ['city', 'name']
        unique_together = (("city", "name"),)
        verbose_name = ('улица')
        verbose_name_plural = ('улицы')
    def __unicode__(self):
        return self.name

class Location(models.Model):
    """
    Абстрактный адрес
    """
    obid = models.IntegerField(blank=True, null=True)
    country = models.ForeignKey(GeoCountry, verbose_name="Страна", blank=True, null=True)       # Страна
    region = models.ForeignKey(GeoRegion, verbose_name="Регион", blank=True, null=True)         # Регион
    city = models.ForeignKey(GeoCity, verbose_name="Город", blank=True, null=True)              # Город
    info = models.TextField("Дополнительная информация", blank=True, null=True)
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
        verbose_name = ('Адрес')
        verbose_name_plural = ('Адреса')

class DeathCause(models.Model):
    """
    Причина гибели
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Причина гибели", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Причина гибели')
        verbose_name_plural = ('Причины гибели')

class DeadmanCategory(models.Model):
    """
    Категория захороненного
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Категория захороненного", max_length=100)
    brief = models.CharField("Краткое название категории захороненных", max_length=100, blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Категория погибшего')
        verbose_name_plural = ('Категории погибших')

class DocumentsPlace(models.Model):
    """
    Место нахождения документов
    """
    name = models.CharField("Место нахождения документов", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Место нахождения документов')
        verbose_name_plural = ('Места нахождения документов')

class BurialType(models.Model):
    """
    Тип воинского захоронения
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Название типа захоронения", max_length=100)
    brief = models.CharField("Краткое название типа воинского захоронения", max_length=100, blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Тип воинского захоронения')
        verbose_name_plural = ('Типы воинских захоронений')

class MilitaryConflictType(models.Model):
    """
    Тип военного конфликта
    """
    full = models.CharField("Полное название типа военного конфликта", max_length=100)
    brief = models.CharField("Краткое название типа военного конфликта", max_length=100)
    def __unicode__(self):
        return self.full
    class Meta:
        verbose_name = ('Тип военного конфликта')
        verbose_name_plural = ('Типы военных конфликтов')

class MilitaryConflict(models.Model):
    """
    Военный конфликт
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Название военного конфликта", max_length=100)
    brief = models.CharField("Краткое название военного конфликта", max_length=100, blank=True, null=True)
    type = models.ForeignKey(MilitaryConflictType, blank=True, null=True)          # Тип военного конфликта
    comment = models.TextField("Комментарий", blank=True, null=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Военный конфликт')
        verbose_name_plural = ('Военные конфликты')

class InformationSource(models.Model):
    """
    Источники информации
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Источник информации", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Источник информации')
        verbose_name_plural = ('Источники информации')

class ClosureCause(models.Model):
    """
    Причина закрытия захоронения
    """
    name = models.CharField("Причина закрытия захоронения", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Причина закрытия захоронения')
        verbose_name_plural = ('Причины закрытия захоронения')

class Nationality(models.Model):
    """
    Национальность
    """
    name = models.CharField("Название", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Национальность')
        verbose_name_plural = ('Национальности')

class Person(models.Model):
    """
    Человек.
    """
    obid = models.IntegerField(blank=True, null=True)
    oblocationid = models.IntegerField(blank=True, null=True)
    uuid = UUIDField(primary_key=True)
    last_name = models.CharField("Фамилия", max_length=128)                     # Фамилия
    first_name = models.CharField("Имя", max_length=30, blank=True)             # Имя
    patronymic = models.CharField("Отчество", max_length=30, blank=True)        # Отчество
    birth_date = models.DateField("Дата рождения", blank=True, null=True)       # Дата рождения
    death_date = models.DateField("Дата смерти", blank=True, null=True)         # Дата гибели
    death_cause = models.ForeignKey(DeathCause, blank=True, null=True)          # Причина гибели
    nationality = models.ForeignKey(Nationality, blank=True, null=True)         # Национальность
    deadman_category = models.ForeignKey(DeadmanCategory, blank=True, null=True)    # Категория погибшего
    documents_place = models.ForeignKey(DocumentsPlace, blank=True, null=True)   # Место нахождения документов
    information_source = models.ForeignKey(InformationSource, blank=True, null=True)   # Источник информации
    info = models.TextField("Информация о месте жительства и родственниках", blank=True, null=True)
    creator = models.ForeignKey(User, blank=True, null=True)                    # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                  # Дата создания записи
    date_last_edit = models.DateTimeField(auto_now=True)                        # Дата последнего редактирования записи
    is_trash = models.BooleanField(default=False)                               # В корзине
    class Meta:
        ordering = ['last_name'] # Сортировка по фамилии
        verbose_name = ('Погибший')
        verbose_name_plural = ('Погибшие')

    def __unicode__(self):
        return u'%s' % self.last_name

class MilitaryUnit(Location):
    """
    Воинское подразделение
    """
    name = models.CharField("Воинское подразделение", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Воинское подразделение')
        verbose_name_plural = ('Воинские подразделения')

class PersonCall(models.Model):
    """
    Место призыва
    """
    person = models.OneToOneField(Person, primary_key=True)                      # Связь с воином
    unit = models.ForeignKey(MilitaryUnit, blank=True, null=True)                  # Воинское подразделение
    date = models.DateField("Дата призыва", blank=True, null=True)

    def __unicode__(self):
        return u'%s' % (self.duty.name)
    class Meta:
        verbose_name = ('Место призыва')

class Post(models.Model):
    """
    Должность
    """
    name = models.CharField("Должность", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Должность')
        verbose_name_plural = ('Должности')

class Rank(models.Model):
    """
    Воинское звание.
    """
    obid = models.IntegerField(blank=True, null=True)
    name = models.CharField("Звание", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('воинское звание')
        verbose_name_plural = ('воинские звания')

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
        verbose_name = ('История службы')

class PersonEditCause(models.Model):
    """
    Основание для редактирования Воина
    """
    person = models.ForeignKey(Person)                                          # Связь с Воином
    name = models.CharField("Название документа", max_length=100)
    number = models.CharField("Номер документа", max_length=100)
    date = models.DateField("Дата документа") 
    date_edit = models.DateTimeField(auto_now=True)                             # Дата последнего редактирования записи
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Основание для редакирования Воина')
        verbose_name_plural = ('Основания для редактирования Воина')

class PersonInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    person = models.ForeignKey(Person)                                          # Связь с Воином
    link = models.URLField("Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Ссылка на информационные источники')
        verbose_name_plural = ('Ссылки на информационные источники')

class LocationBirth(Location):
    """
    Адрес рождения.
    """
    person = models.OneToOneField(Person, primary_key=True)
    class Meta:
        verbose_name = ('Адрес рождения')
        verbose_name_plural = ('Адрес рождения')

class Burial(models.Model):
    """
    Захоронение
    """
    obid = models.IntegerField(blank=True, null=True)
    oblocationid = models.IntegerField(blank=True, null=True)
    uuid = UUIDField(primary_key=True)
    persons = models.ManyToManyField(Person, through='PersonBurial')
    passportid = models.CharField("Номер паспорта захоронения",  blank=True, null=True, max_length=128)
    date_passport = models.DateField("Дата создания паспорта", blank=True, null=True)
    date_burried = models.DateField("Дата создания захоронения", blank=True, null=True)
    date_discovered = models.DateField("Дата обнаружения", blank=True, null=True)
    burial_type = models.ForeignKey(BurialType, blank=True, null=True)                      # Тип воинского захоронения
    military_conflict = models.ForeignKey(MilitaryConflict, blank=True, null=True)          # Военный конфликт
    date_memorial = models.DateField("Дата установки памятника", blank=True, null=True)
    date_gosznak = models.DateField("Дата установки госзнака", blank=True, null=True)
    qunknown = models.IntegerField("Количество неизвестных захороненных", blank=True, null=True)
    photo = models.ImageField("Фото", upload_to="bpics", null=True)
    scheme = models.ImageField("Схема", upload_to="bpics", null=True)
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
        verbose_name = ('Захоронение')
        verbose_name_plural = ('Захоронения')

class PersonBurial(models.Model):
    """
    Захоронение военнослужащего
    """
    person = models.ForeignKey(Person)                                          # Персона.
    burial = models.ForeignKey(Burial)                                          # Захоронение.
    date_burried = models.DateField("Дата захоронения", blank=True, null=True)
#    date_exhumated = models.DateField("Дата эксгумации", blank=True, null=True)
    bnamed = models.BooleanField("Признак нанесения имени на надмогильное сооружение")

    def __unicode__(self):
        if self.burial.passportid:
            return u'%s - %s' % (self.person.last_name, self.burial.passportid)
        else:
            return u'%s захоронение без паспорта' % self.person.last_name

    class Meta:
        verbose_name = ('Захоронения военнослужащего')
        verbose_name_plural = ('Захоронения военнослужащих')
        unique_together = (("person", "burial"),)

class BurialEditCause(models.Model):
    """
    Основание для внесения изменения
    """
    burial = models.ForeignKey(Burial)                                          # Связь с Воином
    name = models.CharField("Название документа", max_length=100)
    number = models.CharField("Номер документа", max_length=100)
    date = models.DateField("Дата документа")
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Основание для внесения изменения')
        verbose_name_plural = ('Основания для внесения изменения')

class BurialPictures(models.Model):
    """Фотография захоронения
    """
    burial = models.ForeignKey('Burial')
    photo = models.ImageField("Фото", upload_to="bpics", null=True)
    comment = models.TextField(blank=True, null=True)                               # Дополнительная информация

    def __unicode__(self):
        return self.photo and os.path.basename(self.photo.path) or 'empty pic'
    class Meta:
        verbose_name = ('Фотография захоронения')
        verbose_name_plural = ('Фотографии захоронения')

class BurialInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    burial = models.ForeignKey(Burial)                                          # Связь с Захоронением
    link = models.URLField("Ссылка", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Ссылка на информационные источники')
        verbose_name_plural = ('Ссылки на информационные источники')

class SearchObject(models.Model):
    """
    Поисковый объект
    """
    number = models.CharField("Номер поискового объекта", max_length=100)               # Номер поискового объекта
    date = models.DateField("Дата отработки", blank=True, null=True)                    # Дата отработки
    inv_number = models.CharField("Номер поискового дела", max_length=100)              # Номер поискового объекта
    burial = models.OneToOneField(Burial)                                               # Связь с Захоронением
    link = models.URLField("Ссылка", max_length=100)
    def __unicode__(self):
        return self.number
    class Meta:
        verbose_name = ('Поисковый объект')
        verbose_name_plural = ('Поисковые объекты')

class ClosedBurial(models.Model):
    """
    Входящие захоронения.
    """
    burial = models.OneToOneField(Burial, primary_key=True)                                 # Куда осуществлен перенос
    burial_from = models.ForeignKey(Burial, related_name="burial_from")                     # откуда
    date = models.DateField("Дата закрытия")
    cause = models.ForeignKey(ClosureCause)                                                 # Причина перезахоронения
    class Meta:
        verbose_name = ('Входящие захоронения')
        verbose_name_plural = ('Входящие захоронения')

class LocationBurial(Location):
    """
    Адрес захоронения
    """
    burial = models.OneToOneField(Burial, primary_key=True)
    post_index = models.CharField("Почтовый индекс", max_length=16, blank=True)                 # Индекс.
    street = models.ForeignKey(GeoStreet, verbose_name="Улица", blank=True, null=True)          # Улица.
    house = models.CharField("Дом", max_length=16, blank=True)                                  # Дом.
    gps_x = models.FloatField("Координата X", blank=True, null=True)                            # GPS X-ось.
    gps_y = models.FloatField("Координата Y", blank=True, null=True)                            # GPS Y-ось.
    gps_z = models.FloatField("Координата Z", blank=True, null=True)                            # GPS Z-ось.
    class Meta:
        verbose_name = ('Адрес захоронения')
        verbose_name_plural = ('Адрес захоронения')

    def __unicode__(self):
        ret = super(LocationBurial, self).__unicode__()
        if self.street:
            ret = u'%s, %s' % (ret, self.street)
            if self.house:
                ret = u'%s, %s' % (ret, self.house)
        if self.post_index:
            ret = u'%s, %s' % (self.post_index, ret)
        return ret

