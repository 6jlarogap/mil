# -*- coding: utf-8 -*-

from django.contrib import admin
from common.models import *

class PersonDutyInline(admin.TabularInline):
    model = PersonDuty
    extra = 1

class PersonBurialInline(admin.TabularInline):
    model = PersonBurial
    extra = 1

class LocationBirthInLine(admin.TabularInline):
    model = LocationBirth

class LocationBurialInLine(admin.TabularInline):
    model = LocationBurial

class ClosedBurialInLine(admin.TabularInline):
    model = ClosedBurial
    fk_name = "burial"

class ClosedInBurialInLine(admin.TabularInline):
    model = ClosedBurial
    fk_name = "burial_from"

class PersonAdmin(admin.ModelAdmin):
    inlines = [
        PersonBurialInline,
        PersonDutyInline,
        LocationBirthInLine,
    ]

class BurialAdmin(admin.ModelAdmin):
    inlines = [
#        PersonBurialInline,
        LocationBurialInLine,
        ClosedBurialInLine,
        ClosedInBurialInLine,
    ]
    search_fields = ['passportid']

admin.site.register(GeoCountry)
admin.site.register(GeoRegion)
admin.site.register(GeoCity)
admin.site.register(GeoStreet)
admin.site.register(Rank)
admin.site.register(MilitaryUnit)
admin.site.register(DeathCause)
admin.site.register(DeadmanCategory)
admin.site.register(DocumentsPlace)
admin.site.register(BurialType)
admin.site.register(MilitaryConflictType)
admin.site.register(MilitaryConflict)
admin.site.register(ClosureCause)
admin.site.register(Burial, BurialAdmin)
admin.site.register(Person, PersonAdmin)
#admin.site.register(PersonBurial)
#admin.site.register(PersonDuty)
admin.site.register(InformationSource)

