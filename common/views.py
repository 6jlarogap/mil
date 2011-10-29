# -*- coding: utf-8 -*-

import simplejson

from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.db.models import *
from django.core.paginator import Paginator, EmptyPage
from django.core.cache import cache

from common.models import *
from common.forms import *

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
                persons = Person.objects.all().select_related()
                if cd['rank']:
                    persons = persons.filter(personduty__rank__name = cd['rank'])
                if cd['country']:
                    params = dict(burial__locationburial__city__region__country__pk = cd['country'].pk)
                    if cd['country_exclude']:
                        persons = persons.exclude(**params)
                    else:
                        persons = persons.filter(**params)
 # //rd-- fio search field regex rules
 # ".етер"   # ^
 # "етер"    # ^
 # "етер.*"  # ^
 # ".етер.*" # ^
 # "етер."   # ^$
 # ".*етер"  # $
 # ".*етер." # $
                if cd['last_name']:
                    regex = re.sub(r'\?', r'.', cd['last_name'].capitalize()) # capitalize is due to not working Iregexp
                    regex = re.sub(r'\*', r'.*', regex)
                    if not regex.startswith(".*"):
                        regex = u"^%s" % regex
                        if regex.endswith("."):
                            regex = u"%s$" % regex
                    else:
                        regex = u"%s$" % regex
                    persons = persons.filter(last_name__iregex=regex)
                if cd['first_name']:
                    regex = re.sub(r'\?', r'.', cd['first_name'].capitalize()) # capitalize is due to not working Iregexp
                    regex = re.sub(r'\*', r'.*', regex)
                    if not regex.startswith(".*"):
                        regex = u"^%s" % regex
                        if regex.endswith("."):
                            regex = u"%s$" % regex
                    else:
                        regex = u"%s$" % regex
                    persons = persons.filter(first_name__iregex=regex)
                if cd['patronymic']:
                    regex = re.sub(r'\?', r'.', cd['patronymic'].capitalize()) # capitalize is due to not working Iregexp
                    regex = re.sub(r'\*', r'.*', regex)
                    if not regex.startswith(".*"):
                        regex = u"^%s" % regex
                        if regex.endswith("."):
                            regex = u"%s$" % regex
                    else:
                        regex = u"%s$" % regex
                    persons = persons.filter(patronymic__iregex=regex)
                if cd['birth_date_from']:
                    persons = persons.filter(birth_date__gte = cd['birth_date_from'])
                if cd['birth_date_to']:
                    persons = persons.filter(birth_date__lte = cd['birth_date_to'])
                """
                if cd['city_birth']:
                    persons = persons.filter(location_birth__city__name__icontains = cd['city_birth'])
                if cd['region_birth']:
                    persons = persons.filter(location_birth__region__name__icontains = cd['region_birth'])
                if cd['country_birth']:
                    persons = persons.filter(location_birth__country__name__icontains = cd['country_birth'])
                if cd['mu']:
                    persons = persons.filter(personduty__unit__name = cd['duty'])
                """
                if cd['death_date_from']:
                    persons = persons.filter(death_date__gte = cd['death_date_from'])
                if cd['death_date_to']:
                    persons = persons.filter(death_date__lte = cd['death_date_to'])
#                if cd['death_cause']:
#                    persons = persons.filter(death_cause__name = cd['death_cause'])
                if cd['burial_passportid']:
                    persons = persons.filter(burial__passportid = cd['burial_passportid'])
                """
                if cd['burial_date_from']:
                    persons = persons.filter(burial_date__gte = cd['burial_date_from'])
                if cd['burial_date_to']:
                    persons = persons.filter(burial_date__lte = cd['burial_date_to'])
                if cd['city_burial']:
                    persons = persons.filter(burial__location__city__name__icontains = cd['city_burial'])
                if cd['region_burial']:
                    persons = persons.filter(burial__location__region__name__icontains = cd['region_burial'])
                if cd['country_burial']:
                    persons = persons.filter(burial__location__country__name__icontains = cd['country_burial'])
                if cd['documents_place']:
                    persons = persons.filter(documents_place__name = cd['documents_place'])
                if cd['information_source']:
                    persons = persons.filter(information_source__name = cd['information_source'])
                if cd['deadman_category']:
                    persons = persons.filter(deadman_category__name = cd['deadman_category'])
                """
                if cd['info']:
                    persons = persons.filter(info__icontains = cd['info'])
                if persons:
                    persons_count = persons.count()

                    paginator = Paginator(persons, 20)
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
                        'search_offset': 20 * (int(p) - 1),
                    }

                    if template == 'reports/report_3.html':
                        all_count = Person.objects.all().count()
                        unknown_count = BurialCategory.objects.all().aggregate(unknown=models.Sum('unknown'))['unknown']
                        context.update({
                            'all': Burial.objects.all().count(),
                            'conflicts': {
                                'WW': Burial.objects.filter(
                                    military_conflict__name__in=[u"Иностранные 1мв", u"Первая мировая война"]
                                ).count(),
                                'WWII': Burial.objects.filter(
                                    military_conflict__name__in=[u"Иностранные 2мв", u"Вторая мировая война"]
                                ).count(),
                                'local': Burial.objects.filter(military_conflict__name=u"Локальные военные конфликты").count(),
                                'other': Burial.objects.exclude(
                                    military_conflict__name__in=[u"Иностранные 1мв", u"Первая мировая война", u"Иностранные 2мв", u"Вторая мировая война", u"Локальные военные конфликты"]
                                ).count(),
                            },
                            'types': {
                                'war': Burial.objects.filter(
                                    burial_type__name__in=[u"Воинское кладбище", u"Смешанное"]
                                ).count(),
                                'group': Burial.objects.filter(
                                    burial_type__name__in=[u"Братская могила"]
                                ).count(),
                                'personal': Burial.objects.filter(
                                    burial_type__name__in=[u"Индивидуальная могила", u"Локальные войны"]
                                ).count(),
                                'mass': Burial.objects.filter(
                                    burial_type__name__in=[u"Место массов.уничтож."]
                                ).count(),
                                'foreign': Burial.objects.filter(
                                    burial_type__name__in=[u"Иностранное"]
                                ).count(),
                            },
                            'persons': {
                                'all': all_count + unknown_count,
                                'known': all_count,
                                'unknown': unknown_count,
                                'WW': Person.objects.filter(
                                    burial__military_conflict__name__in=[u"Иностранные 1мв", u"Первая мировая война"]
                                ).count(),
                                'WWII': Person.objects.filter(
                                    burial__military_conflict__name__in=[u"Иностранные 2мв", u"Вторая мировая война"]
                                ).count(),
                                'local': Person.objects.filter(
                                    burial__military_conflict__name=u"Локальные военные конфликты"
                                ).count(),
                                'other': Person.objects.exclude(
                                    burial__military_conflict__name__in=[u"Иностранные 1мв", u"Первая мировая война", u"Иностранные 2мв", u"Вторая мировая война", u"Локальные военные конфликты"]
                                ).count(),
                                'soldiers': Person.objects.exclude(
                                    deadman_category__name__in=[u"Военнослужащий", ]
                                ).count(),
                                'resistance': Person.objects.exclude(
                                    deadman_category__name__in=[u"Участник сопротивления", ]
                                ).count(),
                                'prey': Person.objects.exclude(
                                    deadman_category__name__in=[u"Жертва войны", ]
                                ).count(),
                                'prisoners': Person.objects.exclude(
                                    deadman_category__name__in=[u"Другие", ]
                                ).count(),
                                'nowhere': Person.objects.filter(burial__isnull=True).count(),
                            },
                        })

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
    except:
        return render_to_response('error.html', context_instance=RequestContext(request, {
            'error': 'Выбранный воин не обранужен.'
            }))

    return render_to_response('person.html', context_instance=RequestContext(request, {
        'person': person
        }))

def burials(request):
    """
    Поиск захоронений.
    Результат возвращается в виде таблицы. Для запроса используется метод GET.
    """
    if 'search' in request.GET and request.GET['search']:
        form = BurialsForm(request.GET)
        # Если пользователь нажал кнопку 'Поиск'
        if request.GET['search'] == u'Поиск':
            if form.is_valid():
                cd = form.cleaned_data
                burials = Burial.objects.all()
                print burials.count()

                if cd['burial_passportid']:
                    burials = burials.filter(passportid = cd['burial_passportid'])
                if cd['bemptypassport']:
                    burials = burials.filter(passportid = u'')
                else:
                    burials = burials.exclude(passportid = u'')
                if cd['city']:
                    burials = burials.filter(locationburial__city__name__icontains = cd['city'])
                if cd['region']:
                    burials = burials.filter(locationburial__city__region__name__icontains = cd['region'])
                if cd['country']:
                    burials = burials.filter(locationburial__city__region__country__name__icontains = cd['country'])
                if cd['burial_type']:
                    burials = burials.filter(burial_type__name = cd['burial_type'])
                if cd['military_conflict']:
                    burials = burials.filter(military_conflict__name = cd['military_conflict'])
                if cd['burried_date_from']:
                    burials = burials.filter(date_burried__gte = cd['burried_date_from'])
                if cd['burried_date_to']:
                    burials = burials.filter(date_burried__lte = cd['burried_date_to'])
                """
                if cd['passport_date_from']:
                    burials = burials.filter(date_passport__gte = cd['passport_date_from'])
                if cd['passport_date_to']:
                    burials = burials.filter(date_passport__lte = cd['passport_date_to'])
                if cd['discovered_date_from']:
                    burials = burials.filter(date_discovered__gte = cd['discovered_date_from'])
                if cd['discovered_date_to']:
                    burials = burials.filter(date_discovered__lte = cd['discovered_date_to'])
                if cd['closure_date_from']:
                    burials = burials.filter(date_closure__gte = cd['closure_date_from'])
                if cd['closure_date_to']:
                    burials = burials.filter(date_closure__lte = cd['closure_date_to'])
                if cd['closure_cause']:
                    burials = burials.filter(closure_cause__name = cd['closure_cause'])
                if cd['memorial_date_from']:
                    burials = burials.filter(date_memorial__gte = cd['memorial_date_from'])
                if cd['memorial_date_to']:
                    burials = burials.filter(date_memorial__lte = cd['memorial_date_to'])
                if cd['gosznak_date_from']:
                    burials = burials.filter(date_gosznak__gte = cd['gosznak_date_from'])
                if cd['gosznak_date_to']:
                    burials = burials.filter(date_gosznak__lte = cd['gosznak_date_to'])
                """
                if cd['info']:
                    burials = burials.filter(info__icontains = cd['info'])
                if cd['state']:
                    burials = burials.filter(state__name = cd['burial_type'])
                if not burials:
                    return render_to_response('burials.html', context_instance=RequestContext(request, {
                        'form': form
                        }))
                else:
                    burials_count = burials.aggregate(number=Count('uuid'))

                    paginator = Paginator(burials, 20)
                    p = request.GET.get('p', 1)
                    try:
                        burials = paginator.page(p)
                    except EmptyPage:
                        burials = paginator.page(paginator.num_pages)
                        
                    query_vars = ''
                    for x in request.GET:
                        query_vars += '%s=%s&' % (x, request.GET[x])

                    return render_to_response('burials.html', context_instance = RequestContext(request, {
                        'burials': burials,
                        'burials_count': burials_count,
                        'query_vars': query_vars,
                        'form': form
                        }))
            return render_to_response('burials.html', context_instance=RequestContext(request, {
                'form': form
                }))
        # Если пользователь нажал кнопку 'Сброс'
        if request.GET['search'] == u'Сброс':
            return HttpResponseRedirect('/burials')
    form = BurialsForm()
    burials_count = Burial.objects.aggregate(number=Count('uuid'))
    return render_to_response('burials.html', context_instance = RequestContext(request, {
        'is_first_search': True,
        'burials_count': burials_count,
        'form': form
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

    return render_to_response('burial.html', context_instance=RequestContext(request, {
        'burial': burial
        }))

'''
def get_deadman(request):
    """
    Получение уникального списка ФИО захороненных.
    """
    persons = []
    q = request.GET.get('q', None)
    if q is not None:
        rezult = Person.objects.filter(buried__isnull=False, last_name__istartswith=q).values("last_name",
                          "first_name", "patronymic").order_by("last_name", "first_name", "patronymic").distinct()[:16]
        persons = ["%s %s %s" % (item["last_name"], item["first_name"], item["patronymic"]) for item in rezult]
    return direct_to_template(request, 'ajax.html', {'objects': persons,})


def get_street(request):
    """
    Получение улицы с городом, регионом и страной.
    """
    streets = []
    q = request.GET.get('term', None)
    if q is not None:
        rezult = Street.objects.filter(name__istartswith=q).order_by("name", "city__name", "city__region__name",
                                                                     "city__region__country__name")[:24]
        for s in rezult:
            streets.append(u"%s/%s/%s/%s" % (s.name, s.city.name, s.city.region.name, s.city.region.country.name))
    return HttpResponse(JSONEncoder().encode(streets))


def get_countries(request):
    """
    Получение списка стран с пом. AJAX-запроса.
    """
    countries = []
    q = request.GET.get('term', None)
    if q is not None:
        rezult = GeoCountry.objects.filter(name__istartswith=q).order_by("name")[:8]
        for s in rezult:
            countries.append(s.name)
    return HttpResponse(JSONEncoder().encode(countries))


def get_cities(request):
    """
    Получение списка нас. пунктов с пом. AJAX-запроса.
    """
    cities = []
    q = request.GET.get('term', None)
    if q is not None:
        rezult = GeoCity.objects.filter(name__istartswith=q).order_by("name", "region__name",
                                                                      "region__country__name")[:24]
        for s in rezult:
            cities.append(u"%s/%s/%s" % (s.name, s.region.name, s.region.country.name))
    return HttpResponse(JSONEncoder().encode(cities))


def get_regions(request):
    """
    Получение списка регионов с пом. AJAX-запроса.
    """
    regions = []
    q = request.GET.get('term', None)
    if q is not None:
        rezult = GeoRegion.objects.filter(name__istartswith=q).order_by("name", "country__name")[:24]
        for s in rezult:
            regions.append(u"%s/%s" % (s.name, s.country.name))
    return HttpResponse(JSONEncoder().encode(regions))
'''
