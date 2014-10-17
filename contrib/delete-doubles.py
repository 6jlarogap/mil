#! /usr/bin/env python
# -*- coding: utf-8 -*-
#                                   Евгений Супрун, suprune20 at gmail.com, 2013
# delete-doubles.py
# -----------------
#
# Удаление т.н. "двойников" согласно соодержимому файлов
# формата Microsoft Excel 2003. Имена файлов
# передаются в качестве параметров.
#
# Каждый исходный файл (книга Excel) может состоять из одного
# или нескольких листов. Дополнительные листы сформированы,
# если число строк в первом листе (предыдущем листе)
# превысит максимум для формата Excel 2003: 65535
#
# Поля в листе (листах):
#   0.  Пустое, для правке пользователем. Если заказчик
#       поставит там знак, то соответсвующий погибший 
#       подлежит удалению из базы данных при дальнейшей
#       обработке выходного файла Excel.
#   1.  Ф И О. Оно же ссылка на правку данных о погибшем
#   2.  Звание
#   3.  Дата рождения: ДД.ММ.ГГГГ или ММ.ГГГГ или ГГГГ
#   4.  Дата смерти: ДД.ММ.ГГГГ или ММ.ГГГГ или ГГГГ
#   5.  Номер захоронения. Он же ссылка на правку захоронения
#   6.  Информация о захороненном
#
# Остальные колонки -- не для пользователя, а служебные
#   7.  uuid погибшего
#   8.  Фамилия
#   9.  Имя
#  10.  Отчество
#  11.  Номер захоронения
#

# this is from the beginning!
from __future__ import print_function

import sys

import xlrd

sys.path.append('/home/django/projects/mil')
from django.core.management import setup_environ
import settings
setup_environ(settings)

from django.core.exceptions import ObjectDoesNotExist
from common.models import Person

# Номера соотв. колонок
(UUID_COL, LAST_NAME_COL, FIRST_NAME_COL, PATRONYMIC_COL, BURIAL_COL,) = \
    (8, 9, 10, 11, 12,)

def main():
    print("\n" + \
          sys.argv[0] + "\n" + \
          "-" * len(sys.argv[0]) + "\n" + \
          u"Удаление записей о воинах, отмеченных в файле Microsoft Excel\n",
          file=sys.stderr
         )
    if len(sys.argv) < 2:
        print(u"Параметр(ы):\n" + \
              u" - файл(ы) Excel с записями, отмеченными на удаление\n" + \
              u'Отчет:\n' + \
              u'  - стандартный вывод\n',
              file=sys.stderr
             )
        sys.exit(1)
    
    persons = Person.objects.all()
    
    count_deleted_all = 0
    count_errors = 0
    for xls in sys.argv[1:]:
        count_deleted_book = 0
        print (u"ФАЙЛ:".encode('utf-8'), end=' ')
        print (xls)
        try:
            book = xlrd.open_workbook(xls)
        except IOError:
            print (u" ОШИБКА: Excel-файл не найден или ошибка чтения")
            continue
        except:
            print (u" ОШИБКА: неверный формат Excel-файла")
            continue
            
        for sheet_name in sorted(list(book.sheet_names())):
            print (u" лист:".encode('utf-8'), end=' ')
            print (sheet_name)
            sheet = book.sheet_by_name(sheet_name)
            row = 0
            count_deleted_sheet = 0
            while row < sheet.nrows:
                cell0 = sheet.cell(row,0)
                if cell0.ctype == xlrd.XL_CELL_TEXT and cell0.value.strip():
                    cell = sheet.cell(row,UUID_COL)
                    if cell.ctype == xlrd.XL_CELL_TEXT and cell.value:
                        try:
                            p = persons.get(uuid=cell.value)
                            try:
                                fio = p.last_name
                                if p.first_name:
                                    fio += ' ' + p.first_name
                                    if p.patronymic:
                                        fio += ' ' + p.patronymic
                                p.delete()
                                print(u"  Удален: (стр. %s) %s" % (unicode(row+1), fio,))
                                count_deleted_sheet += 1
                                count_deleted_book += 1
                                count_deleted_all += 1
                            except:
                                count_errors += 1
                                print(u"  ОШИБКА удаления: строка %s" % unicode(row+1))
                        except ObjectDoesNotExist:
                            count_errors += 1
                            print(u"  ОШИБКА: строка %s, не найден погибший" % unicode(row+1))
                row += 1
            print(u" Удалено на листе: %d" % count_deleted_sheet)
        print(u"ИТОГО Удалено в файле: %d" % count_deleted_book)
    print(u"\nВСЕГО удалено: %d" % count_deleted_all)
    print(u"ОШИБОК: %d" % count_errors)

main()
