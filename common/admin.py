# -*- coding: utf-8 -*-

import pytils

from django.contrib import admin
from django import forms

from common.models import *
from common.forms import PersonAdminForm, BurialAdminForm

class PersonDutyInline(admin.TabularInline):
    model = PersonDuty
    extra = 1
    can_delete = False

class PersonCallInline(admin.TabularInline):
    model = PersonCall
    extra = 1
    can_delete = False

class PersonEditCauseInline(admin.TabularInline):
    model = PersonEditCause
    extra = 1
    can_delete = False

class ClosedBurialFromInLine(admin.TabularInline):
    model = ClosedBurial
    fk_name = "burial_from"
    extra = 1
    max_num = 1
    can_delete = False

class BurialCategoryInLine(admin.TabularInline):
    model = BurialCategory
    extra = 0
    readonly_fields = ['category', 'known', ]
    can_delete = False
    template = 'tabular_burialcat.html'
    fieldsets = [(None, {'fields': ['category', 'known', 'custom_known', 'unknown', ]})]

    def get_formset(self, request, obj=None):
        if not obj:
            if not request.POST:
                self.extra = DeadmanCategory.objects.all().count()
            FormSetClass = super(BurialCategoryInLine, self).get_formset(request, obj)

            class NewFormSetClass(FormSetClass):
                def __init__(self, *args, **kwargs):
                    super(NewFormSetClass, self).__init__(*args, **kwargs)
                    self.initial = []
                    for i, c in enumerate(DeadmanCategory.objects.all()):
                        self.forms[i].instance = BurialCategory(**{'category': c, 'known': 0, 'custom_known': 0})
            return NewFormSetClass
        else:
            return super(BurialCategoryInLine, self).get_formset(request, obj)

class BurialMemPhotoInline(admin.TabularInline):
    model = BurialPictures

class BurialAdmin(admin.ModelAdmin):
    inlines = [
        BurialCategoryInLine,
        BurialMemPhotoInline,
        ClosedBurialFromInLine,
    ]
    form = BurialAdminForm
    search_fields = ['passportid', ]
    readonly_fields = ['date_of_creation', 'date_of_update', 'creator', 'today', ]
    raw_id_fields = ['location', ]

    def today(self, obj):
        return pytils.dt.ru_strftime(date=datetime.date.today(), format=u'%d %B %Y', inflected=True)
    today.short_description = u"Cостояние на"

    def change_view(self, request, object_id, extra_context=None):
        try:
            obj = Burial.objects.get(pk=object_id)
        except Burial.DoesNotExist:
            pass
        else:
            for cat in DeadmanCategory.objects.all():
                bc, created = cat.burial_categories.get_or_create(burial=obj)
                if created or bc.updated < datetime.datetime.now() - datetime.timedelta(0, 3600):
                    bc.update()

        return super(BurialAdmin, self).change_view(request, object_id, extra_context)


    def save_model(self, request, obj, form, change):
        if not obj.creator:
            obj.creator = request.user
        obj.save()

class SortSearchAdmin(admin.ModelAdmin):
    search_fields = ['name', ]
    ordering = ['name', ]

class PersonAdmin(admin.ModelAdmin):
    class Media:
        js = ['js/admin/person.js', ]

    inlines = [
        PersonCallInline,
        PersonDutyInline,
        PersonEditCauseInline,
    ]
    form = PersonAdminForm
    search_fields = ['burial__passportid', 'last_name']
    readonly_fields = ['date_of_creation', 'last_edit', 'creator', ]
    raw_id_fields = ['birth_location', ]

    def __init__(self, *args, **kwargs):
        super(PersonAdmin, self).__init__(*args, **kwargs)
        self.opts.get_field_by_name('info')[0].verbose_name = u'Дополнительная информация о месте захоронения'
        self.opts.get_field_by_name('closed_burials')[0].help_text = None

    def get_fieldsets(self, *args, **kwargs):
        fieldsets = super(PersonAdmin, self).get_fieldsets(*args, **kwargs)
        if len(fieldsets) == 1:
            flist = fieldsets[0][1]['fields']
            flist.insert(flist.index('patronymic') + 1, flist.pop(flist.index('nationality')))
        return fieldsets

    def save_model(self, request, obj, form, change):
        if not obj.creator:
            obj.creator = request.user
        obj.save()

class DeadmanCategoryAdmin(admin.ModelAdmin):
    list_display = ['name', 'ordering',]
    list_editable = ['ordering',]
    search_fields = ['name', ]

class BurialPrintingGroupAdmin(admin.ModelAdmin):
    search_fields = ['name', 'description', ]
    ordering = ['name', ]

class ConflictPrintingGroupAdmin(admin.ModelAdmin):
    search_fields = ['name', 'description', ]
    ordering = ['name', ]

class LocationAdmin(SortSearchAdmin):
    raw_id_fields = ['location', ]

class InternalLocationAdmin(admin.ModelAdmin):
    search_fields = ['city__name', 'municipalitet__name', ]
    list_filter = ['country', 'region',]

admin.site.register(GeoCountry, SortSearchAdmin)
admin.site.register(GeoRegion, SortSearchAdmin)
admin.site.register(District, SortSearchAdmin)
admin.site.register(Municipalitet, SortSearchAdmin)
admin.site.register(CityType, SortSearchAdmin)
admin.site.register(GeoCity, SortSearchAdmin)
admin.site.register(Rank, SortSearchAdmin)
admin.site.register(Comissariat, LocationAdmin)
admin.site.register(MilitaryUnit, LocationAdmin)
#admin.site.register(SimpleLocation, InternalLocationAdmin)
#admin.site.register(StrictLocation, InternalLocationAdmin)
admin.site.register(DeathCause, SortSearchAdmin)
admin.site.register(DeadmanCategory, DeadmanCategoryAdmin)
admin.site.register(DocumentsPlace, SortSearchAdmin)
admin.site.register(BurialType, SortSearchAdmin)
admin.site.register(BurialPrintingGroup, BurialPrintingGroupAdmin)
admin.site.register(ConflictPrintingGroup, ConflictPrintingGroupAdmin)
admin.site.register(MilitaryConflict, SortSearchAdmin)
admin.site.register(ClosureCause, SortSearchAdmin)
admin.site.register(Burial, BurialAdmin)
admin.site.register(Person, PersonAdmin)
admin.site.register(ClosedBurial)
admin.site.register(InformationSource, SortSearchAdmin)
admin.site.register(Nationality, SortSearchAdmin)
admin.site.register(MemorialState, SortSearchAdmin)

