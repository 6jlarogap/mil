# -*- coding: utf-8 -*-
from StringIO import StringIO

import urllib
from django.contrib import messages
from django.core.urlresolvers import reverse
from django.views.generic.list_detail import object_list
from django.views.generic.simple import direct_to_template
import simplejson

from django.shortcuts import render_to_response, redirect
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.db.models import *
from django.core.paginator import Paginator, EmptyPage
from django.core.cache import cache
from django.db.backends.postgresql_psycopg2.base import DatabaseOperations, DatabaseWrapper

from common.models import *
from common.forms import *
from common.tasks import report_2_deferred
import cemetery_redis
import xlrd
import xlwt

def lookup_cast(self, lookup_type):
    if lookup_type == 'iregex':
        return "UPPER(%s::text)"
    else:
        return super(DatabaseOperations, self).lookup_cast(lookup_type)

def patch_iregex():
    DatabaseOperations.lookup_cast = lookup_cast
    DatabaseWrapper.operators['iregex'] = '~ UPPER(%s)'

patch_iregex()

def persons_autocomplete(request):
    persons = Person.objects.filter(last_name__istartswith=request.GET.get('term')).values_list('last_name', flat=True)
    names = list(set(list(persons.order_by('last_name')[:100])))
    names.sort()
    return HttpResponse(simplejson.dumps(names[:10]))

def persons(request):
    """
    Поиск воинов.
    Результат возвращается в виде таблицы. Для запроса используется метод GET.
    """
    if 'search' in request.GET and request.GET['search']:
        form = PersonsForm(request.GET)
        # Если пользователь нажал кнопку 'Поиск'
        if request.GET['search'] == u'Поиск':
            if form.is_valid():
                cd = form.cleaned_data
                persons = Person.objects.all().select_related().order_by('last_name', 'first_name', 'patronymic', 'death_date')
                if cd['rank']:
                    persons = persons.filter(personduty__rank__name = cd['rank'])
                if cd['burial_location']:
                    if not isinstance(cd['burial_location'], SimpleLocation):
                        cd['burial_location'] = SimpleLocation.objects.get(pk=cd['burial_location'])
                    if cd['burial_location'].country:
                        if cd['country_exclude']:
                            persons = persons.exclude(burial__location__country__pk = cd['burial_location'].country.pk)
                        else:
                            persons = persons.filter(burial__location__country__pk = cd['burial_location'].country.pk)

                        if cd['burial_location'].region:
                            persons = persons.filter(burial__location__region = cd['burial_location'].region)

                        if cd['burial_location'].district:
                            persons = persons.filter(burial__location__district = cd['burial_location'].district)

                        if cd['burial_location'].municipalitet:
                            persons = persons.filter(burial__location__municipalitet = cd['burial_location'].municipalitet)

                        if cd['burial_location'].city:
                            persons = persons.filter(burial__location__city = cd['burial_location'].city)

                if cd['birth_location']:
                    if not isinstance(cd['birth_location'], SimpleLocation):
                        cd['birth_location'] = SimpleLocation.objects.get(pk=cd['birth_location'])
                    if cd['birth_location'].country:
                        persons = persons.filter(birth_location__country = cd['birth_location'].country)

                    if cd['birth_location'].region:
                        persons = persons.filter(birth_location__region = cd['birth_location'].region)

                    if cd['birth_location'].district:
                        persons = persons.filter(birth_location__district = cd['birth_location'].district)

                    if cd['birth_location'].municipalitet:
                        persons = persons.filter(birth_location__municipalitet = cd['birth_location'].municipalitet)

                    if cd['birth_location'].city:
                        persons = persons.filter(birth_location__city = cd['birth_location'].city)

                        # //rd-- fio search field regex rules
 # ".етер"   # ^
 # "етер"    # ^
 # "етер.*"  # ^
 # ".етер.*" # ^
 # "етер."   # ^$
 # ".*етер"  # $
 # ".*етер." # $
                if cd['last_name']:
                    regex = re.sub(r'\?', r'.', cd['last_name']) # capitalize is due to not working Iregexp
                    regex = re.sub(u'[еёЕЁ]', u'[еёЕЁ]', regex)
                    regex = re.sub(r'\*', r'.*', regex)
                    persons = persons.filter(last_name__iregex=u'^%s' % regex)
                if cd['first_name']:
                    regex = re.sub(r'\?', r'.', cd['first_name']) # capitalize is due to not working Iregexp
                    regex = re.sub(u'[еёЕЁ]', u'[еёЕЁ]', regex)
                    regex = re.sub(r'\*', r'.*', regex)
                    persons = persons.filter(first_name__iregex=u'^%s' % regex)
                if cd['patronymic']:
                    regex = re.sub(r'\?', r'.', cd['patronymic']) # capitalize is due to not working Iregexp
                    regex = re.sub(u'[еёЕЁ]', u'[еёЕЁ]', regex)
                    regex = re.sub(r'\*', r'.*', regex)
                    persons = persons.filter(patronymic__iregex=u'^%s' % regex)

                if cd['birth_date_from']:
                    persons = persons.filter(birth_date__gte = cd['birth_date_from'])
                if cd['birth_date_to']:
                    persons = persons.filter(birth_date__lte = cd['birth_date_to'])
                if cd['death_date_from']:
                    persons = persons.filter(death_date__gte = cd['death_date_from'])
                if cd['death_date_to']:
                    persons = persons.filter(death_date__lte = cd['death_date_to'])
                if cd['death_cause']:
                    persons = persons.filter(death_cause = cd['death_cause'])
                if cd['category']:
                    persons = persons.filter(deadman_category = cd['category'])
                if cd['burial_passportid']:
                    persons = persons.filter(burial__passportid = cd['burial_passportid'])
                if cd['record_date_from']:
                    persons = persons.filter(date_of_creation__gte = cd['record_date_from'])
                if cd['record_date_to']:
                    persons = persons.filter(date_of_creation__lte = cd['record_date_to'])
                if cd['info']:
                    persons = persons.filter(info__icontains = cd['info'])
                if persons.exists():
                    persons_count = persons.count()

                    per_page = int(request.REQUEST.get('per_page') or 20)
                    paginator = Paginator(persons, per_page)
                    p = request.GET.get('p', '1')
                    try:
                        persons_page = paginator.page(p)
                    except EmptyPage:
                        persons_page = paginator.page(paginator.num_pages)
                        
                    query_vars = ''
                    for x in request.GET:
                        query_vars += '%s=%s&' % (x, request.GET[x])

                    template = request.REQUEST.get('template', 'persons.html')

                    context = {
                        'persons': persons_page,
                        'persons_count': persons_count,
                        'query_vars': query_vars,
                        'form': form,
                        'search_offset': per_page * (int(p) - 1),
                    }

                    return render_to_response(template, context_instance = RequestContext(request, context))
            return render_to_response('persons.html', context_instance=RequestContext(request, {
                'form': form
                }))
        # Если пользователь нажал кнопку 'Сброс'
        if request.GET['search'] == u'Сброс':
            return HttpResponseRedirect('/persons')
    form = PersonsForm()

    persons_count = cache.get('db_size')
    if not persons_count:
        persons_count = Person.objects.all().count()
        cache.set('db_size', persons_count, 3600)

    return render_to_response('persons.html', context_instance = RequestContext(request, {
        'is_first_search': True,
        'persons_count': persons_count,
        'form': form
        }))

def person(request, obj):
    """Страница просмотра данных воина.
    """
    try:
        person = Person.objects.get(pk=obj)
    except Person.DoesNotExist:
        return render_to_response('error.html', context_instance=RequestContext(request, {
            'error': 'Выбранный воин не обранужен.'
            }))

    template = request.REQUEST.get('template', 'person.html')

    return render_to_response(template, context_instance=RequestContext(request, {'person': person}))

def burials(request):
    """
    Поиск захоронений.
    Результат возвращается в виде таблицы. Для запроса используется метод GET.
    """
    template = request.REQUEST.get('template', 'burials.html')
    if 'search' in request.GET and request.GET['search']:
        form = BurialsForm(request.GET)

        if template == 'reports/report_4.html':
            form.fields['country'].required = True

        if template == 'reports/report_4a.html':
            form.fields['country'].required = True
            form.fields['region'].required = True

        # Если пользователь нажал кнопку 'Поиск'
        if request.GET['search'] == u'Поиск':
            if form.is_valid():
                cd = form.cleaned_data
                burials = Burial.objects.all()

                if cd['burial_passportid']:
                    burials = burials.filter(passportid = cd['burial_passportid'])
                if cd['bemptypassport']:
                    burials = burials.filter(passportid__isnull=True)
                else:
                    burials = burials.exclude(passportid__isnull=True)
                if cd['city']:
                    burials = burials.filter(location__city = cd['city'])
                if cd['city_name']:
                    burials = burials.filter(location__city__name__istartswith = cd['city_name'])
                elif cd['district']:
                    burials = burials.filter(location__district = cd['district'])
                elif cd['municipalitet']:
                    burials = burials.filter(location__municipalitet = cd['municipalitet'])
                elif cd['region']:
                    burials = burials.filter(location__region = cd['region'])
                elif cd['country']:
                    if cd['other_countries']:
                        burials = burials.exclude(location__country = cd['country'])
                    else:
                        burials = burials.filter(location__country = cd['country'])
                if cd['burial_type']:
                    burials = burials.filter(burial_type__name = cd['burial_type'])
                if cd['military_conflict']:
                    burials = burials.filter(military_conflict = cd['military_conflict'])
                if cd['burried_date_from']:
                    burials = burials.filter(date_burried__gte = cd['burried_date_from'])
                if cd['burried_date_to']:
                    burials = burials.filter(date_burried__lte = cd['burried_date_to'])
                if cd['info']:
                    burials = burials.filter(info__icontains = cd['info'])
                if cd['state']:
                    burials = burials.filter(state__name = cd['burial_type'])
                if cd['only_closed']:
                    burials = burials.filter(Q(date_closed__isnull=False) | Q(is_trash=True))

                burials_count = burials.count()

                if not burials_count:
                    return render_to_response('burials.html', context_instance=RequestContext(request, {
                        'form': form,
                        'template': urllib.unquote(request.REQUEST.get('template', '')) or 'burials.html',
                        }))
                else:
                    burials = burials.order_by('passportid')

                    paginator = Paginator(burials, int(request.REQUEST.get('per_page') or 20))
                    p = request.GET.get('p', 1)
                    try:
                        burials_page = paginator.page(p)
                    except EmptyPage:
                        burials_page = paginator.page(paginator.num_pages)

                    query_vars = ''
                    for x in request.GET:
                        query_vars += '%s=%s&' % (x, request.GET[x])

                    context = {
                        'burials': burials_page,
                        'burials_count': burials_count,
                        'query_vars': query_vars,
                        'form': form,
                        'template': urllib.unquote(request.REQUEST.get('template', '')) or 'burials.html',
                    }

                    if template == 'reports/report_2.html':
                        b = burials[0]
                        context.update({
                            'burial': b,
                        })
                        if b.person_set.all().count() > 100:
                            if request.user.is_authenticated():
                                report_2_deferred.delay(b.pk, request.user.email)
                                return direct_to_template(request, 'reports/report_2_deferred.html', context)
                            else:
                                return HttpResponseRedirect('%s?next=%s' % (reverse('login'), request.path + '%3F' + request.META['QUERY_STRING'].replace('&', '%26')))

                    if template == 'reports/report_2a.html':
                        context.update({
                            'region': cd['region'],
                            'district': cd['district'],
                            'city': cd['city'],
                            'burials': burials,
                            })

                    r = cemetery_redis.Redis()

                    if template == 'reports/report_2b.html':
                        bcats = BurialCategory.objects.filter(burial__in=burials)

                        dead_cats = [
                            DeadmanCategory.objects.get(name=u"Военнослужащий"),
                            DeadmanCategory.objects.get(name=u"Участник сопротивления"),
                            DeadmanCategory.objects.get(name=u"Жертва войны"),
                            DeadmanCategory.objects.get(name=u"Военнопленный"),
                            DeadmanCategory.objects.get(name=u"Другие"),
                        ]
                        burial_list = list(burials.select_related().order_by('passportid'))
                        for b in burial_list:
                            b.stats = b.stats(dead_cats)

                        burial_pks = [b.pk for b in burial_list]

                        known_count = r.known_for_burial_list(burial_pks)
                        unknown_count = r.unknown_for_burial_list(burial_pks)

                        context.update({
                            'region': cd['region'],
                            'district': cd['district'],
                            'city': cd['city'],
                            'all': burials.count(),
                            'burials': burial_list,
                            'conflicts': {
                                'WW': burials.filter(
                                    military_conflict__type__name=u"1МВ"
                                ).count(),
                                'WWII': burials.filter(
                                    military_conflict__type__name=u"2МВ"
                                ).count(),
                                'local': burials.filter(military_conflict__type__name=u"ЛВК").count(),
                                'other': burials.filter(
                                    military_conflict__type__name=u"ГР и др."
                                ).count(),
                            },
                            'types': {
                                'war': burials.filter(
                                    burial_type__type__name=u'ВК'
                                ).count(),
                                'group': burials.filter(
                                    burial_type__type__name=u"БМ"
                                ).count(),
                                'personal': burials.filter(
                                    burial_type__type__name=u"ИМ"
                                ).count(),
                                'mass': burials.filter(
                                    burial_type__type__name=u"ММУ"
                                ).count(),
                                'foreign': burials.filter(
                                    burial_type__type__name=u"ИН"
                                ).count(),
                            },
                            'persons': {
                                'all': known_count + unknown_count,
                                'known': known_count,
                                'unknown': unknown_count,
                                'soldiers': r.known_for_burial_list_and_cat(burial_pks, DeadmanCategory.objects.get(name=u"Военнослужащий")),
                                'resistance': r.known_for_burial_list_and_cat(burial_pks, DeadmanCategory.objects.get(name=u"Участник сопротивления")),
                                'prey': r.known_for_burial_list_and_cat(burial_pks, DeadmanCategory.objects.get(name=u"Жертва войны")),
                                'prisoners': r.known_for_burial_list_and_cat(burial_pks, DeadmanCategory.objects.get(name=u"Другие")),
                                'nowhere': 0,
                            },
                        })

                    if template == 'reports/report_3.html' or template == 'reports/report_5.html':
                        bcats = BurialCategory.objects.filter(burial__in=burials)
                        known_count = r.known_for_burial_list(burials) or bcats.aggregate(known=models.Sum('custom_known'))['known']
                        unknown_count = r.unknown_for_burial_list(burials) or bcats.aggregate(unknown=models.Sum('unknown'))['unknown']
                        burials_list = list(burials)
                        context.update({
                            'all': burials.count(),
                            'conflicts': {
                                'WW': burials.filter(
                                    military_conflict__type__name=u"1МВ"
                                ).count(),
                                'WWII': burials.filter(
                                    military_conflict__type__name=u"2МВ"
                                ).count(),
                                'local': burials.filter(military_conflict__type__name=u"ЛВК").count(),
                                'other': burials.filter(
                                    military_conflict__type__name=u"ГР и др."
                                ).count(),
                            },
                            'types': {
                                'war': burials.filter(
                                    burial_type__type__name=u'ВК'
                                ).count(),
                                'group': burials.filter(
                                    burial_type__type__name=u"БМ"
                                ).count(),
                                'personal': burials.filter(
                                    burial_type__type__name=u"ИМ"
                                ).count(),
                                'mass': burials.filter(
                                    burial_type__type__name=u"ММУ"
                                ).count(),
                                'foreign': burials.filter(
                                    burial_type__type__name=u"ИН"
                                ).count(),
                            },
                            'persons': {
                                'all': known_count + unknown_count,
                                'known': known_count,
                                'unknown': unknown_count,
                                'WW': r.known_for_burial_list(list(burials.filter(
                                    military_conflict__type__name=u"1МВ"
                                ))),
                                'WWII': r.known_for_burial_list(list(burials.filter(
                                    military_conflict__type__name=u"2МВ"
                                ))),
                                'local': r.known_for_burial_list(list(burials.filter(
                                    military_conflict__type__name=u"ЛВК"
                                ))),
                                'other': r.known_for_burial_list(list(burials.filter(
                                    military_conflict__type__name=u"ГР и др."
                                ))),
                                'soldiers': r.known_for_burial_list_and_cat(burials_list, DeadmanCategory.objects.get(name=u"Военнослужащий")),
                                'resistance': r.known_for_burial_list_and_cat(burials_list, DeadmanCategory.objects.get(name=u"Участник сопротивления")),
                                'prey': r.known_for_burial_list_and_cat(burials_list, DeadmanCategory.objects.get(name=u"Жертва войны")),
                                'prisoners': r.known_for_burial_list_and_cat(burials_list, DeadmanCategory.objects.get(name=u"Другие")),
                                'mia': Person.objects.filter(burial__isnull=True, mia=True).count(),
                                'outside_rb': Person.objects.filter(outside_rb=True).count(),
                            },
                        })

                    if template == 'reports/report_4.html' or template == 'reports/report_4a.html':
                        selected_persons = Person.objects.filter(burial__in=burials)

                        def filter_data(burials_all, persons_all, region, district):
                            if district:
                                burials_sel = burials_all.filter(location__district=district)
                            elif region:
                                burials_sel = burials_all.filter(location__region=region)
                            else:
                                burials_sel = burials_all

                            burials_sel = list(burials_sel.order_by('passportid'))
                            burials_pks = [b.pk for b in burials_sel]

                            b_cats = BurialCategory.objects.filter(burial__in=burials_sel)
                            bc_data = b_cats.aggregate(unknown=models.Sum('unknown'), known=models.Sum('custom_known'))
                            unknown = r.unknown_for_burial_list(burials_sel) or bc_data['unknown']
                            known = r.known_for_burial_list(burials_sel) or bc_data['known']

                            burials_count = len(burials_sel)

                            if not burials_count and not known and not unknown:
                                return {'burials': {'all': 0}, 'persons': {'all': 0}, }
                            else:
                                conflicts = MilitaryConflict.objects.filter(burial__pk__in=burials_pks).annotate(count=Count('burial')).select_related()
                                burial_types = BurialType.objects.filter(burial__pk__in=burials_pks).annotate(count=Count('burial')).select_related()

                                burials_data = {
                                    'all': burials_count,
                                    'WW': sum([c.count for c in conflicts if c.type and c.type.name == u"1МВ"], 0),
                                    'WWII': sum([c.count for c in conflicts if c.type and c.type.name == u"2МВ"], 0),
                                    'local': sum([c.count for c in conflicts if c.type and c.type.name == u"ЛВК"], 0),
                                    'other': sum([c.count for c in conflicts if c.type and c.type.name == u"ГР и др."], 0),
                                    'war': sum([b.count for b in burial_types if b.type and b.type.name == u'ВК'], 0),
                                    'group': sum([b.count for b in burial_types if b.type and b.type.name == u"БМ"], 0),
                                    'personal': sum([b.count for b in burial_types if b.type and b.type.name == u"ИМ"], 0),
                                    'mass': sum([b.count for b in burial_types if b.type and b.type.name == u"ММУ"], 0),
                                    'foreign': sum([b.count for b in burial_types if b.type and b.type.name == u"ИН"], 0),
                                }

                                conflicts = MilitaryConflict.objects.all().select_related()
                                for c in conflicts:
                                    c.count = r.all_for_burial_list([b.pk for b in burials_sel if b.military_conflict_id == c.pk])
                                deadman_cats = DeadmanCategory.objects.all()
                                for dc in deadman_cats:
                                    dc.count = r.known_for_burial_list_and_cat(burials_pks, dc)

                                persons_data = {
                                    'all': known + unknown,
                                    'known': known,
                                    'unknown': unknown,
                                    'WW': sum([c.count for c in conflicts if c.type and c.type and c.type.name == u"1МВ"], 0),
                                    'WWII': sum([c.count for c in conflicts if c.type and c.type and c.type.name == u"2МВ"], 0),
                                    'local': sum([c.count for c in conflicts if c.type and c.type and c.type.name == u"ЛВК"], 0),
                                    'other': sum([c.count for c in conflicts if c.type and c.type and c.type.name == u"ГР и др."], 0),
                                    'soldiers': sum([d.count for d in deadman_cats if d.name in [u"Военнослужащий",]], 0),
                                    'resistance': sum([d.count for d in deadman_cats if d.name in [u"Участник сопротивления",]], 0),
                                    'prey': sum([d.count for d in deadman_cats if d.name in [u"Жертва войны",]], 0),
                                    'prisoners': sum([d.count for d in deadman_cats if d.name in [u"Другие",]], 0),
                                }

                                return {
                                    'burials': burials_data,
                                    'persons': persons_data,
                                }

                        rows = []
                        context['region'] = form.cleaned_data.get('region')
                        if template == 'reports/report_4a.html':
                            districts = form.cleaned_data['region'].district_set.all().order_by('name')
                            if form.cleaned_data.get('district'):
                                districts = districts.filter(pk=form.cleaned_data.get('district').pk)
                            for district in districts:
                                data_key = 'form4a_data3_%s_%s' % (form.cleaned_data.get('region'), district.pk)
                                data = cache.get(data_key)
                                if not data:
                                    data = filter_data(
                                        burials, selected_persons, form.cleaned_data['region'], district
                                    )
                                    cache.set(data_key, data, 86400)
                                if not data['persons']['all'] and not data['burials']['all']:
                                    continue
                                rows.append({
                                    'district': district,
                                    'data': data
                                })
                            context['data'] = filter_data(
                                burials, selected_persons, form.cleaned_data['region'], None
                            )
                        else:
                            regions = form.cleaned_data['country'].georegion_set.all().order_by('name')
                            if form.cleaned_data.get('region'):
                                regions = regions.filter(pk=form.cleaned_data.get('region').pk)
                            for region in regions:
                                data_key = 'form4_data3_%s_%s' % (form.cleaned_data.get('country'), region.pk)
                                data = cache.get(data_key)
                                if not data:
                                    data = filter_data(
                                        burials, selected_persons, region, None
                                    )
                                    cache.set(data_key, data, 86400)
                                if not data['persons']['all'] and not data['burials']['all']:
                                    continue
                                rows.append({
                                    'region': region,
                                    'data': data
                                })
                            context['data'] = filter_data(
                                burials, selected_persons, None, None
                            )

                        context['rows'] = rows

                    return render_to_response(template, context_instance = RequestContext(request, context))
            return render_to_response('burials.html', context_instance=RequestContext(request, {
                'form': form,
                'template': urllib.unquote(request.REQUEST.get('template', '')) or 'burials.html',
                }))
        # Если пользователь нажал кнопку 'Сброс'
        if request.GET['search'] == u'Сброс':
            return HttpResponseRedirect('/burials')
    form = BurialsForm()
    burials_count = Burial.objects.count()
    return render_to_response('burials.html', context_instance = RequestContext(request, {
        'is_first_search': True,
        'burials_count': burials_count,
        'form': form,
        'template': urllib.unquote(request.REQUEST.get('template', '')) or 'burials.html',
    }))

def burial(request, obj):
    """Страница просмотра данных Захоронения.
    """
    try:
        burial = Burial.objects.get(pk=obj)
    except:
        return render_to_response('error.html', context_instance=RequestContext(request, {
            'error': 'Выбранный воин не обранужен.'
        }))

    per_page = int(request.REQUEST.get('per_page') or 20)

    return object_list(request,
        template_name='burial.html',
        queryset=burial.person_set.all(),
        paginate_by=per_page,
        extra_context={
            'burial': burial,
        }
    )

def import_xls(request):
    form = XLSImportForm(data=request.POST or None, files=request.FILES or None)
    if request.POST and form.is_valid():
        tmp_workbook = os.tmpnam()
        destination = open(tmp_workbook, 'wb+')
        for chunk in form.cleaned_data['xls'].chunks():
            destination.write(chunk)
        destination.close()
        burial_obj = form.cleaned_data['burial']

        errors = []
        try:
            xl = xlrd.open_workbook(filename=tmp_workbook)
        except xlrd.XLRDError:
            messages.error(request, u'Неверный формат файла')
            return redirect('import')
        worksheet = xl.sheets()[0]
        row = 1
        all_data = []
        any_errors = False
        bad_errrors = False

        while row < worksheet.nrows:
            has_errors = False
            data = map(lambda cell: cell.value, worksheet.row_slice(row, 0, 7))
            data = [d.strip() if isinstance(d, basestring) else d for d in data]
            duty, last_name, first_name, middle_name, birth, death, info = data
            last_name, first_name, middle_name = map(lambda s: s.upper().strip('.').strip(' '), [last_name, first_name, middle_name])
            data_row = {}
            if duty:
                try:
                    data_row['duty'] = Rank.objects.get(name=duty.strip().capitalize())
                except Rank.DoesNotExist:
                    data_row['duty'] = {
                        'value': duty,
                        'error': u'Звание не найдено в БД'
                    }
                    has_errors = True
                    bad_errrors = True

            if birth:
                if isinstance(birth, float):
                    try:
                        birth = datetime.datetime(*xlrd.xldate_as_tuple(birth, xl.datemode)).strftime('%d.%m.%Y')
                    except ValueError:
                        birth = int(birth)

                try:
                    bits = map(int, str(birth).split('.'))
                    bits.reverse()
                    y,m,d = list(bits + [None, None])[:3]
                    data_row['birth'] = UnclearDate(y,m,d)
                except ValueError, e:
                    data_row['birth'] = {
                        'value': birth,
                        'error': u'Не понимаю дату: %s' % e.message
                    }
                    has_errors = True
                    bad_errrors = True
            if death:
                if isinstance(death, float):
                    try:
                        death = datetime.datetime(*xlrd.xldate_as_tuple(death, xl.datemode)).strftime('%d.%m.%Y')
                    except ValueError:
                        death = int(death)

                try:
                    bits = map(int, str(death).split('.'))
                    bits.reverse()
                    y,m,d = list(bits + [None, None])[:3]
                    data_row['death'] = UnclearDate(y,m,d)
                except ValueError, e:
                    data_row['death'] = {
                        'value': death,
                        'error': u'Не понимаю дату: %s' % e.message
                    }
                    has_errors = True
                    bad_errrors = True

            if not last_name:
                data_row['person'] = {
                    'value': u'%s %s %s' % (last_name, first_name, middle_name),
                    'error': u'Фамилия обязательна'
                }
                has_errors = True
                bad_errrors = True
            else:
                persons = Person.objects.filter(first_name=first_name, last_name=last_name, patronymic=middle_name, burial=burial_obj)
                d = data_row.get('death')
                if d and isinstance(d, UnclearDate):
                    persons = persons.filter(death_date=d.d)
                if persons.exists():
                    data_row['person'] = {
                        'data': (last_name, first_name, middle_name),
                        'value': u'%s %s %s' % (last_name, first_name, middle_name),
                        'error': u'Такие ФИО уже существуют в указанном захоронении'
                    }
                    has_errors = True
                else:
                    data_row['person_value'] = ' '.join([last_name, first_name, middle_name])
                    data_row['person'] = [last_name, first_name, middle_name]

            data_row['info'] = info

            all_data.append({'errors': has_errors, 'bad_errrors': bad_errrors, 'data': data_row})
            if has_errors:
                any_errors = True
            row += 1

        os.unlink(tmp_workbook)
        return direct_to_template(request, 'import2.html', extra_context={
            'all_data': all_data,
            'burial_obj': burial_obj,
            'any_errors': any_errors,
            'bad_errrors': bad_errrors,
        })

    return direct_to_template(request, 'import.html', extra_context={
        'form': form,
    })

def import_xls_2(request):
    row = 0
    cnt = 0

    burial_obj = Burial.objects.get(pk=request.POST.get('burial'))
    book = xlwt.Workbook(encoding='cp1251')
    sheet = book.add_sheet(u'Ошибки'.encode('cp1251'))
    xli = 0

    while row < int(request.POST['lines']):
        last_name = request.POST.get('last_name_%s' % row) or ''
        first_name = request.POST.get('first_name_%s' % row, '') or ''
        middle_name = request.POST.get('middle_name_%s' % row, '') or ''
        birth = request.POST.get('birth_%s' % row, '') or ''
        death = request.POST.get('death_%s' % row, '') or ''
        info = request.POST.get('info_%s' % row, '') or ''
        error = request.POST.get('error_%s' % row, '') or ''

        if request.POST.get('check_%s' % row):
            params = dict(
                burial = burial_obj,
                last_name = last_name,
                first_name = first_name,
                patronymic = middle_name,
                info = info,
            )
            if birth:
                bits = map(int, str(birth).split('.'))
                bits.reverse()
                y,m,d = list(bits + [None, None])[:3]
                birth_date = UnclearDate(y,m,d)
                params.update(
                    birth_date = birth_date.d,
                    birth_date_no_month = birth_date.no_month,
                    birth_date_no_day = birth_date.no_day,
                )
            if death:
                bits = map(int, str(death).split('.'))
                bits.reverse()
                y,m,d = list(bits + [None, None])[:3]
                death_date = UnclearDate(y,m,d)
                params.update(
                    death_date = death_date.d,
                    death_date_no_month = death_date.no_month,
                    death_date_no_day = death_date.no_day,
                )


            Person.objects.get_or_create(**params)
            cnt += 1
        else:
            sheet.write(xli, 0, last_name.encode('cp1251'))
            sheet.write(xli, 1, first_name.encode('cp1251'))
            sheet.write(xli, 2, middle_name.encode('cp1251'))
            sheet.write(xli, 3, birth.encode('cp1251'))
            sheet.write(xli, 4, death.encode('cp1251'))
            sheet.write(xli, 5, info.encode('cp1251'))
            sheet.write(xli, 6, error.strip().encode('cp1251'))
            xli += 1

        row += 1

    messages.success(request, u"Импорт завершен, импортировано %s записей" % cnt)

    if xli > 0:
        content = StringIO()
        book.save(content)
        response = HttpResponse(content.getvalue(), mimetype='application/vnd.ms-excel')
        response['Content-Disposition'] = 'attachment; filename="import_%s_errors.xls"' % burial_obj.passportid
        return response

    return HttpResponseRedirect('/import/')