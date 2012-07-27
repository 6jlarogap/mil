# -*- coding: utf-8 -*-

from django.contrib.admin.filterspecs import FilterSpec
from django.db import models
from django.utils.safestring import mark_safe
from django.utils.translation import ugettext as _

# FilterSpec.register places the new FilterSpec at the back
# of the list. This can be a problem, because the first
# matching FilterSpec is the one used.
def _register_front(cls, test, factory):
    cls.filter_specs.insert(0, (test, factory))

FilterSpec.register_front = classmethod(_register_front)

class NullFilterSpec(FilterSpec):
    fields = (models.CharField, models.IntegerField, models.FileField)

    #@classmethod
    def test(cls, field):
        return field.null and isinstance(field, cls.fields) and not field._choices
    test = classmethod(test)

    def __init__(self, f, request, params, model, model_admin, field_path=None):
        super(NullFilterSpec, self).__init__(f, request, params, model, model_admin, field_path=field_path)
        self.lookup_kwarg = '%s__isnull' % f.name
        self.lookup_val = request.GET.get(self.lookup_kwarg, None)

    def choices(self, cl):
        # bool(v) must be False for IS NOT NULL and True for IS NULL, but can only be a string
        for k, v in ((_('All'), None), (_(u'Задано'), ''), (_(u'Пусто'), '1')):
            yield {
                'selected' : self.lookup_val == v,
                'query_string' : cl.get_query_string({self.lookup_kwarg : v}),
                'display' : k
            }

FilterSpec.register_front(NullFilterSpec.test, NullFilterSpec)