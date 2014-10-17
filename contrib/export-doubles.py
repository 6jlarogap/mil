#! /usr/bin/env python
# -*- coding: utf-8 -*-
#                                   Евгений Супрун, suprune20 at gmail com, 2013
# export-doubles.py
# -----------------
#
# ЗАДАНИЕ
# -------
#
# Экспорт "двойников", т.е. списков погибших. В каждом списке --
# погибшие, имеющие совпадающие фамилию, имя, отчество.
#
# Экспорт -- в файлы формата Microsoft Excel 2003. Таких файлов
# формируется по одному на каждую бкуву русского алфафита,
# плюс еще один, для погибших, чьи фамилии начинаются
# не с русской буквы.
#
# Если двойников с фамилией на начальную букву нет,
# то выходной файл не формируется.
#
# Каждый выходной файл (книга Excel) может состоять из одного
# или нескольких листов. Дополнительные листы формируется,
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
# Параметры:
#   - имя сайта (например, 172.16.1.3, milbel.mooo.com), которое
#     вставляется в ячейках-ссылках. Обязательный.
#   - префикс имени выходных файлов Excel. Не обязательный.
#     По умолчанию: double. Тогда выходные файлы будут именованы
#     double-А.xls ... double-Я.xls. И еще double-Z.xls, для
#     некириллических фамилий.

# this is from the beginning!
from __future__ import print_function

import sys

import psycopg2
import psycopg2.extensions
psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)
import xlwt

sys.path.append('/home/django/projects/mil')
from django.core.management import setup_environ
import settings
setup_environ(settings)

from django.core.exceptions import ObjectDoesNotExist
from common.models import Person, PersonDuty

borders_normal = xlwt.Borders()
borders_sep = xlwt.Borders()
borders_sep.bottom = xlwt.Borders.THICK
borders_sep.bottom_colour = 0x3

def main():
    print("\n" + \
          sys.argv[0] + "\n" + \
          "-" * len(sys.argv[0]) + "\n" + \
          u"Экспорт записей о воинах, чьи ФИО совпадают, в файлы Microsoft Excel\n",
          file=sys.stderr
         )
    if len(sys.argv) < 2:
        print(u"Параметры:\n" + \
              u" - имя сайта, например 172.16.1.3, http://milbel.mooo.com (обязательно!)\n" + \
              u" - начальные буквы имен выходных файлов Excel (по умолчанию double)\n",
              file=sys.stderr
             )
        sys.exit(1)

    site = sys.argv[1].lower()
    if not site.startswith("http://") and not site.startswith("https://"):
        site = "http://" + site
    if not site.endswith("/"):
        site += "/"

    xls = sys.argv[2] if len(sys.argv) > 2 else "double"
    xls += "-"

    print(u"- сайт : " + site + "\n" + \
          u"- пишем в файлы : " + xls + u"А.xls ... " + xls + u"Я.xls\n",
          file=sys.stderr
          )
    letters=['Z']
    # буква Z означает всех, у кого фамилии не с русской буквы алфавита
    letter=u'А'
    while letter <= u'Я':
        letters += letter
        letter = unichr(ord(letter)+1)

    conn = psycopg2.connect("dbname=mil user=postgres")
    cursor_ = conn.cursor()

    # Поля из SELECT:
    (LAST_NAME, FIRST_NAME, PATRONYMIC) = (0, 1, 2,)
    count_lists_all = 0
    count_doubles_all = 0
    # letters = [ u'Я', ] # u'Ь', u'Ъ', u'Я' : DEBUG
    
    alignment_wrap = xlwt.Alignment()
    alignment_wrap.wrap = xlwt.Alignment.WRAP_AT_RIGHT
    alignment_wrap.vert = xlwt.Alignment.VERT_CENTER
    
    alignment_default = xlwt.Alignment()
    alignment_default.vert = xlwt.Alignment.VERT_CENTER
    
    alignment_right = xlwt.Alignment()
    alignment_right.horz = xlwt.Alignment.HORZ_RIGHT
    alignment_right.vert = xlwt.Alignment.VERT_CENTER
    
    alignment_center = xlwt.Alignment()
    alignment_center.horz = xlwt.Alignment.HORZ_CENTER
    alignment_center.vert = xlwt.Alignment.VERT_CENTER
    
    protect_no = xlwt.Protection()
    protect_no.cell_locked = False
    
    protect_full = xlwt.Protection()
    protect_full.cell_locked = True
    protect_full.formula_hidden = True
    
    font_1st = xlwt.Font()
    font_1st.bold = True
    font_1st.colour_index = 0x2                         # red, первая колонка
    style_1st = xlwt.XFStyle()
    style_1st.font = font_1st
    style_1st.alignment = alignment_default
    style_1st.protection = protect_no

    font_fio = xlwt.Font()
    font_fio.underline = xlwt.Font.UNDERLINE_SINGLE
    font_fio.colour_index = 0x4                         # blue, a link
    style_fio = xlwt.XFStyle()
    style_fio.font = font_fio
    style_fio.alignment = alignment_wrap
    style_fio.protection = protect_full
    
    style_rank = xlwt.XFStyle()
    style_rank.alignment = alignment_wrap
    
    style_date = xlwt.XFStyle()
    style_date.alignment = alignment_right
    
    style_burial = xlwt.XFStyle()
    style_burial.font = font_fio
    style_burial.alignment = alignment_right
    style_burial.protection = protect_full
    
    style_info = xlwt.XFStyle()
    style_info.alignment = alignment_wrap
    style_info.protection = protect_no
    
    style_delete = xlwt.XFStyle()
    style_delete.font = font_fio
    style_delete.alignment = alignment_center

    font_hidden = xlwt.Font()
    font_hidden.colour_index = 0x09		# White
    style_hidden = xlwt.XFStyle()
    style_hidden.font = font_hidden

    for letter in letters:
        like_expression = u"ILIKE '" + letter + "%' "
        if letter == 'Z':
            like_expression = u"~* '^[^А-Я]' "
        cursor_.execute(u"""SELECT last_name, first_name, patronymic
                            FROM common_person
                            WHERE last_name %s
                            GROUP BY last_name, first_name, patronymic
                            HAVING COUNT(*) > 1
                            ORDER BY last_name, first_name, patronymic;
                         """ % like_expression)
        if letter == 'Z':
            print(u"Нерусские фамилии:", file=sys.stderr)
        else:
            print(u"С буквы " + letter + ":", file=sys.stderr)
        count_lists = 0
        count_doubles = 0
        book = None
        xls_row = 0
        sheet_number = 0
        for person in cursor_:
            if not book:
                book = xlwt.Workbook(encoding='utf-8')
            # Ограничение Excel, не больше 65535 записей на листе.
            # Надеюсь, больше 5535 двойников одной фамилии не будет :)
            if book and (xls_row == 0 or xls_row > 60000):
                xls_row = 0
                sheet_number += 1
                # DO NOT SPECIFY encoding here! or else no good with
                # xlwt.Formula( ... non-asci chars ...)
                sheet = book.add_sheet("%s-%02d" % (letter, sheet_number,))
                sheet.protect = True
                #sheet.password = 'soul'
                #  3333 = 1 inch
                sheet.col(0).width =   800               # Метка для удаления.
                sheet.col(1).width =  9000               # ФИО
                sheet.col(2).width =  3800               # звание
                sheet.col(3).width =  2700               # даты рождения и смерти
                sheet.col(4).width =  sheet.col(3).width # дата смерти
                sheet.col(5).width =  3100               # Захоронение
                sheet.col(6).width = 10000               # Инфо
                #                                        # Удалить
                #                                        # uuid, скрытая
                
                font_head = xlwt.Font()
                font_head.bold = True
                style_head = xlwt.XFStyle()
                style_head.font = font_head
                style_head.alignment = alignment_default
                sheet.write(xls_row, 0, '', style_head)
                sheet.write(xls_row, 1, 'Ф И О', style_head)
                sheet.write(xls_row, 2, 'Звание', style_head)
                style_head.alignment = alignment_right
                sheet.write(xls_row, 3, 'Родился', style_head)
                sheet.write(xls_row, 4, 'Умер', style_head)
                sheet.write(xls_row, 5, 'Захоронен', style_head)
                style_head.alignment = alignment_default
                sheet.write(xls_row, 6, 'Информация о погибшем', style_head)
        
                sheet.set_panes_frozen(True)
                sheet.set_horz_split_pos(xls_row + 1)     # in general, freeze after last heading row
                sheet.set_remove_splits(True)             # if user does unfreeze, don't leave a split there
                xls_row += 1

            doubles = Person.objects.filter(last_name=person[LAST_NAME],
                                            first_name=person[FIRST_NAME],
                                            patronymic=person[PATRONYMIC]
                                            )
            count_lists += 1
            count_lists_all += 1
            not_last = len(doubles)
            for d in doubles:
                not_last -= 1
                fio = person[LAST_NAME]
                if person[FIRST_NAME]:
                    fio += ' ' + person[FIRST_NAME]
                    if person[PATRONYMIC]:
                        fio += ' ' + person[PATRONYMIC]
                birth_date = date_our(d.birth_date, d.birth_date_no_month, d.birth_date_no_day)
                death_date = date_our(d.death_date, d.death_date_no_month, d.death_date_no_day)
                try:
                    rank = PersonDuty.objects.get(person=d).rank.name
                # AttributeError: 'NoneType' object has no attribute 'name'
                # если rank is None
                except (ObjectDoesNotExist, AttributeError):
                    rank = ''
                if rank == u'Звание неизвестно':
                    rank = ''
                burial = ''
                b = d.burial
                if b:
                    burial = unicode(b.passportid) if b.passportid else ''
                burial_uuid = ''
                if burial:
                    burial_uuid = b.uuid
                #print("*" + "/".join((fio,
                                    #birth_date, death_date,
                                    #rank,
                                    #burial, burial_uuid,
                                    #d.info, d.uuid)).encode('utf-8')
                     #)
                sheet.write(xls_row, 0, '', bordered(style_1st, not_last))
                sheet.write(xls_row, 1,
                            xlwt.Formula(u'HYPERLINK("%s%s%s"; "%s")' % \
                            (site, 'admin/common/person/', d.pk, fio,)),
                            bordered(style_fio, not_last))
                sheet.write(xls_row, 2, rank, bordered(style_rank, not_last))
                sheet.write(xls_row, 3, birth_date, bordered(style_date, not_last))
                sheet.write(xls_row, 4, death_date, bordered(style_date, not_last))
                burial_xls = ''
                if burial:
                    burial_xls = xlwt.Formula(u'HYPERLINK("%s%s%s"; "%s")' % \
                                              (site, 'admin/common/burial/', burial_uuid, burial,)
                                             )
                sheet.write(xls_row, 5, burial_xls, bordered(style_burial, not_last))
                sheet.write(xls_row, 6, d.info, bordered(style_info, not_last))
                sheet.write(xls_row, 7,
                            xlwt.Formula(u'HYPERLINK("%s%s%s%s"; "%s")' % \
                            (site, 'admin/common/person/', d.pk, "/delete", u"Удалить",)),
                            bordered(style_delete, not_last))
                # служебные колонки:
                sheet.write(xls_row, 8, d.pk, style_hidden)
                sheet.write(xls_row, 9, stuff_space(person[LAST_NAME]), style_hidden)
                sheet.write(xls_row,10, stuff_space(person[FIRST_NAME]), style_hidden)
                sheet.write(xls_row,11, stuff_space(person[PATRONYMIC]), style_hidden)
                sheet.write(xls_row,12, stuff_space(burial), style_hidden)
                sheet.write(xls_row,13, ' ', style_hidden)
                
                xls_row += 1
                count_doubles += 1
                count_doubles_all += 1
        if book:
            try:
                book.save(xls + letter + '.xls')
            except IOError as (errno, strerror):
                print(u"  !!! Ошибка %d записи в Excel- файл %s\n      %s" % \
                      (errno, xls + letter + '.xls', strerror,),
                      file=sys.stderr)
            print (u"    готов файл: %s" % xls + letter + '.xls', file=sys.stderr)
        print(u"    списков совпадающих ФИО:", "%10d" % count_lists, file=sys.stderr)
        print(u"    всего в этих списках:   ", "%10d" % count_doubles, file=sys.stderr)

    cursor_.close()
    conn.close()

    print(u"\nВСЕГО списков совпадающих ФИО:", "%8d" % count_lists_all, file=sys.stderr)
    print(  u"      в этих списках:         ", "%8d" % count_doubles_all, file=sys.stderr)

def bordered(style, not_last):
    """ Нижняя грань памки ячейки
    
    У последнего погибшего в списке двойников нижняя грань
    рамки ячеек, показываемых пользователю, жирнаяя
    """
    borders = borders_normal if not_last else borders_sep
    style.borders = borders
    return style

def stuff_space(s):
    """ Замена пустоты пробелом
    
    В последние, служебные, колонки Excel вставляем пробел,
    если туда заносится пустая строка, чтобы эти колонки
    не расползались.
    """
    result = s if s else ' '
    return result

def date_our(date, no_mon, no_day):
    """
    int(ГГГГ) или строка ММ.ГГГГ или строка ДД.ММ.ГГГГ
    
    1943 (число!) или 01.1943 или 01.01.1943 (строки)
    в зависимости от признаков
    no_month (не задан месяц), no_day (не задан день)
    """
    result = ''
    if date:
        day = '' if no_day else "%02d" % date.day
        mon = '' if no_mon else "%02d" % date.month
        result = str(date.year)
        if mon:
            result = mon + "." + result
        if day:
            result = day + "." + result
        if no_day and no_mon:
            result = date.year
            
    return result

main()
