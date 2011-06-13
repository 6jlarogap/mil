# -*- coding: utf-8 -*-

from django.db import models
from django_extensions.db.fields import UUIDField
from django.contrib.auth.models import User

class GeoCountry(models.Model):
    """
    Страна.
    """
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Название", max_length=24, db_index=True, unique=True)
    def __unicode__(self):
        return self.name[:16]
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
    uuid = UUIDField(primary_key=True)
    country = models.ForeignKey(GeoCountry)
    name = models.CharField("Название", max_length=36, db_index=True)
    def __unicode__(self):
        return self.name[:24]
    class Meta:
        unique_together = (("country", "name"),)
        verbose_name = 'регион'
        verbose_name_plural = 'регионы'


class GeoCity(models.Model):
    """
    Город.
    """
    uuid = UUIDField(primary_key=True)
    region = models.ForeignKey(GeoRegion)
    name = models.CharField("Название", max_length=36, db_index=True)
    def __unicode__(self):
        return self.name[:24]
    class Meta:
        unique_together = (("region", "name"),)
        verbose_name = 'населенный пункт'
        verbose_name_plural = 'населенные пункты'


class GeoStreet(models.Model):
    """
    Улица.
    """
    uuid = UUIDField(primary_key=True)
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
    country = models.ForeignKey(GeoCountry, verbose_name="Страна", blank=True, null=True)       # Страна
    region = models.ForeignKey(GeoRegion, verbose_name="Регион", blank=True, null=True)         # Регион
    city = models.ForeignKey(GeoCity, verbose_name="Город", blank=True, null=True)              # Город
    def __unicode__(self):
        ret = u"незаполненный адрес"
        if self.country:
            ret = self.country
            if self.region:
                ret = u'%s %s' % (ret, self.region)
                if self.city:
                    ret = u'%s %s' % (ret, self.city)
        return ret
    class Meta:
        abstract = True
        verbose_name = ('Адрес')
        verbose_name_plural = ('Адреса')

class Rank(models.Model):
    """
    Воинское звание.
    """
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Звание", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('воинское звание')
        verbose_name_plural = ('воинские звания')

class DeathCause(models.Model):
    """
    Причина гибели
    """
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Категория захороненного", max_length=100)
    brief = models.CharField("Краткое название категории захороненных", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Категория погибшего')
        verbose_name_plural = ('Категории погибших')

class DocumentsPlace(models.Model):
    """
    Место нахождения документов
    """
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Название типа захоронения", max_length=100)
    brief = models.CharField("Краткое название типа воинского захоронения", max_length=100)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Тип воинского захоронения')
        verbose_name_plural = ('Типы воинских захоронений')

class MilitaryConflictType(models.Model):
    """
    Тип военного конфликта
    """
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Название военного конфликта", max_length=100)
    brief = models.CharField("Краткое название военного конфликта", max_length=100)
    military_conflict_type = models.ForeignKey(MilitaryConflictType, blank=True, null=True)          # Тип военного конфликта
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
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
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
    creator = models.ForeignKey(User, blank=True, null=True)                    # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                  # Дата создания записи
    date_last_edit = models.DateTimeField(auto_now=True)                        # Дата последнего редактирования записи
    additional_info = models.TextField("Информация о месте жительства и родственниках", blank=True, null=True)
    is_trash = models.BooleanField(default=False)                               # В корзине
    class Meta:
        ordering = ['last_name'] # Сортировка по фамилии
        verbose_name = ('Погибший')
        verbose_name_plural = ('Погибшие')

    def __unicode__(self):
        return u'%s' % self.last_name

class PersonEditCause(models.Model):
    """
    Основание для редактирования Воина
    """
    uuid = UUIDField(primary_key=True)
    person = models.ForeignKey(Person)                                          # Связь с Воином
    name = models.CharField("Название документа", max_length=100)
    number = models.CharField("Номер документа", max_length=100)
    date = models.DateField("Дата документа") 
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Основание для редакирования Воина')
        verbose_name_plural = ('Основания для редактирования Воина')

class PersonInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
    persons = models.ManyToManyField(Person, through='PersonBurial')
    passportid = models.CharField("Номер паспорта захоронения",  blank=True, null=True, max_length=128)
    date_passport = models.DateField("Дата создания паспорта", blank=True, null=True)
    date_burried = models.DateField("Дата захоронения", blank=True, null=True)
    date_discovered = models.DateField("Дата обнаружения", blank=True, null=True)
    burial_type = models.ForeignKey(BurialType, blank=True, null=True)                      # Тип воинского захоронения
    military_conflict = models.ForeignKey(MilitaryConflict, blank=True, null=True)          # Военный конфликт
    date_memorial = models.DateField("Дата установки памятника", blank=True, null=True)
    date_gosznak = models.DateField("Дата установки госзнака", blank=True, null=True)
    unknown_count = models.FloatField("Количество неизвестных захороненных", blank=True, null=True)
    foto = models.FileField(upload_to="bfiles", blank=True, null=True)                      # Ссылка на фотографию
    creator = models.ForeignKey(User, blank=True, null=True)                                # Создатель записи
    date_of_creation = models.DateTimeField(auto_now_add=True)                              # Дата создания записи
    date_last_edit = models.DateTimeField(auto_now=True)                                    # Дата последнего изменения
    additional_info = models.TextField(blank=True, null=True)                               # Дополнительная информация о захоронении.
    is_trash = models.BooleanField(default=False)                                           # В корзине

    def __unicode__(self):
        if self.passportid:
            return self.passportid
        else:
            return u'без паспорта'
    class Meta:
        verbose_name = ('Захоронение')
        verbose_name_plural = ('Захоронения')

class BurialEditCause(models.Model):
    """
    Основание для внесения изменения
    """
    uuid = UUIDField(primary_key=True)
    burial = models.ForeignKey(Burial)                                          # Связь с Воином
    name = models.CharField("Название документа", max_length=100)
    number = models.CharField("Номер документа", max_length=100)
    date = models.DateField("Дата документа") 
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('Основание для внесения изменения в захоронение')
        verbose_name_plural = ('Основания для внесения изменения в захоронение')

class BurialPictures(Location):
    """Фотография захоронения
    """
    uuid = UUIDField(primary_key=True)
    burial = models.ForeignKey('Burial')
    photo = models.ImageField("Фото", upload_to="bpics", null=True)

    def __unicode__(self):
        return self.photo and os.path.basename(self.photo.path) or 'empty pic'
    class Meta:
        verbose_name = ('Фотография захоронения')
        verbose_name_plural = ('Фотографии захоронения')

class BurialInformationLinks(models.Model):
    """
    Ссылка на другие информационные источники
    """
    uuid = UUIDField(primary_key=True)
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
    uuid = UUIDField(primary_key=True)
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

class ClosedBurial(Location):
    """
    Входящие захоронения.
    """
    burial = models.OneToOneField(Burial, primary_key=True)                                 # Куда осуществлен перенос
    burial_from = models.ForeignKey(Burial, related_name="burial_from")                                                 # откуда
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

class Duty(models.Model):
    """
    Место службы
    """
    uuid = UUIDField(primary_key=True)
    name = models.CharField("Место службы", max_length=100)
    persons = models.ManyToManyField(Person, through='PersonDuty')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = ('место службы')
        verbose_name_plural = ('места службы')

class PersonBurial(models.Model):
    """
    Захоронение военнослужащего
    """
    uuid = UUIDField(primary_key=True)
    person = models.ForeignKey(Person)                                          # Персона.
    burial = models.ForeignKey(Burial)                                          # Захоронение.
    date_burried = models.DateField("Дата захоронения", blank=True, null=True)
    date_exhumated = models.DateField("Дата эксгумации", blank=True, null=True)
    bnameonmemorial = models.BooleanField("Признак нанесения имени на надмогильное сооружение")

    def __unicode__(self):
        if self.burial.passportid:
            return u'%s - %s' % (self.person.last_name, self.burial.passportid)
        else:
            return u'%s захоронение без паспорта' % self.person.last_name

    class Meta:
        verbose_name = ('Захоронения военнослужащего')
        verbose_name_plural = ('Захоронения военнослужащих')
        unique_together = (("person", "burial"),)

class PersonDuty(models.Model):
    """
    История службы
    """
    uuid = UUIDField(primary_key=True)
    person = models.ForeignKey(Person)                                          # Персона.
    rank = models.ForeignKey(Rank)                                              # Звание.
    duty = models.ForeignKey(Duty)                                              # Место службы.
    date_from = models.DateField("Дата начала службы", blank=True, null=True)
    date_to = models.DateField("Дата окончания службы", blank=True, null=True)

    def __unicode__(self):
        return u'%s %s %s' % (self.rank.name, self.person.last_name, self.duty.name)
    class Meta:
        verbose_name = ('История службы')
        verbose_name_plural = ('Истории службы')

class LocationDuty(Location):
    """
    Адрес места службы
    """
    duty = models.OneToOneField(PersonDuty, primary_key=True)

    post_index = models.CharField("Почтовый индекс", max_length=16, blank=True)                 # Индекс.
    street = models.ForeignKey(GeoStreet, verbose_name="Улица", blank=True, null=True)          # Улица.
    house = models.CharField("Дом", max_length=16, blank=True)                                  # Дом.
    block = models.CharField("Корпус", max_length=16, blank=True)                               # Корпус.
    building = models.CharField("Строение", max_length=16, blank=True)                          # Строение.
    class Meta:
        verbose_name = ('Адрес места службы')
        verbose_name_plural = ('Адрес места службы')

