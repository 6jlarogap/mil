# encoding: utf-8
import datetime
from south.db import db
from south.v2 import DataMigration
from django.db import models

class Migration(DataMigration):

    def forwards(self, orm):
        for pd in orm.PersonDuty.objects.all():
            if pd.unit and pd.unit.name:
                pd.unit_name = pd.unit.name
                pd.save()


    def backwards(self, orm):
        pass


    models = {
        'auth.group': {
            'Meta': {'object_name': 'Group'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'auth.permission': {
            'Meta': {'ordering': "('content_type__app_label', 'content_type__model', 'codename')", 'unique_together': "(('content_type', 'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2012, 11, 13, 3, 20, 16, 415005)'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime(2012, 11, 13, 3, 20, 16, 414768)'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'common.burial': {
            'Meta': {'ordering': "['passportid']", 'object_name': 'Burial'},
            'burial_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.BurialType']", 'null': 'True', 'blank': 'True'}),
            'creator': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']", 'null': 'True', 'blank': 'True'}),
            'date_burried': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_burried_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_burried_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_closed': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_discovered': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_discovered_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_discovered_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_gosznak': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_gosznak_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_gosznak_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_memorial': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_memorial_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_memorial_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_of_creation': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'db_index': 'True', 'blank': 'True'}),
            'date_of_update': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'db_index': 'True', 'blank': 'True'}),
            'date_passport': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'date_passport_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_passport_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'is_registered': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'is_trash': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'db_index': 'True'}),
            'location': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.SimpleLocation']", 'null': 'True', 'blank': 'True'}),
            'military_conflict': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.MilitaryConflict']", 'null': 'True', 'blank': 'True'}),
            'names_count': ('django.db.models.fields.PositiveSmallIntegerField', [], {'default': '0'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'oblocationid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'passportid': ('django.db.models.fields.PositiveIntegerField', [], {'db_index': 'True', 'unique': 'True', 'null': 'True', 'blank': 'True'}),
            'photo': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'scheme': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'state': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.MemorialState']", 'null': 'True', 'blank': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.burialattachment': {
            'Meta': {'object_name': 'BurialAttachment'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'file': ('django.db.models.fields.files.FileField', [], {'max_length': '100', 'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        'common.burialcategory': {
            'Meta': {'object_name': 'BurialCategory'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'burial_categories'", 'to': "orm['common.Burial']"}),
            'category': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'burial_categories'", 'to': "orm['common.DeadmanCategory']"}),
            'custom_known': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'known': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'}),
            'unknown': ('django.db.models.fields.PositiveIntegerField', [], {'default': '0'}),
            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
        },
        'common.burialeditcause': {
            'Meta': {'object_name': 'BurialEditCause'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'date': ('django.db.models.fields.DateField', [], {}),
            'date_edit': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'common.burialinformationlinks': {
            'Meta': {'object_name': 'BurialInformationLinks'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'})
        },
        'common.burialpictures': {
            'Meta': {'object_name': 'BurialPictures'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'mem_photos'", 'to': "orm['common.Burial']"}),
            'comment': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'photo': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'null': 'True'})
        },
        'common.burialprintinggroup': {
            'Meta': {'object_name': 'BurialPrintingGroup'},
            'description': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.burialtype': {
            'Meta': {'object_name': 'BurialType'},
            'brief': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.BurialPrintingGroup']", 'null': 'True', 'blank': 'True'})
        },
        'common.citytype': {
            'Meta': {'object_name': 'CityType'},
            'full_name': ('django.db.models.fields.CharField', [], {'max_length': '255', 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'})
        },
        'common.closedburial': {
            'Meta': {'object_name': 'ClosedBurial'},
            'burial_from': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'burial_from'", 'unique': 'True', 'primary_key': 'True', 'to': "orm['common.Burial']"}),
            'burial_to': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'burial_to'", 'to': "orm['common.Burial']"}),
            'cause': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.ClosureCause']"}),
            'date': ('django.db.models.fields.DateField', [], {}),
            'document': ('django.db.models.fields.files.FileField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'})
        },
        'common.closurecause': {
            'Meta': {'object_name': 'ClosureCause'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'common.comissariat': {
            'Meta': {'ordering': "['name']", 'object_name': 'Comissariat'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'location': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.SimpleLocation']", 'unique': 'True', 'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'})
        },
        'common.conflictprintinggroup': {
            'Meta': {'object_name': 'ConflictPrintingGroup'},
            'description': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.deadmancategory': {
            'Meta': {'ordering': "['ordering']", 'object_name': 'DeadmanCategory'},
            'brief': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'ordering': ('django.db.models.fields.PositiveSmallIntegerField', [], {'default': '1'})
        },
        'common.deathcause': {
            'Meta': {'object_name': 'DeathCause'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.district': {
            'Meta': {'object_name': 'District'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True'})
        },
        'common.documentsplace': {
            'Meta': {'object_name': 'DocumentsPlace'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'common.geocity': {
            'Meta': {'object_name': 'GeoCity'},
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True'}),
            'district': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.District']", 'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'municipalitet': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Municipalitet']", 'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True'}),
            'type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.CityType']", 'null': 'True', 'blank': 'True'})
        },
        'common.geocountry': {
            'Meta': {'ordering': "['name']", 'object_name': 'GeoCountry'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '36', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.georegion': {
            'Meta': {'unique_together': "(('country', 'name'),)", 'object_name': 'GeoRegion'},
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.informationsource': {
            'Meta': {'object_name': 'InformationSource'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.memorialstate': {
            'Meta': {'object_name': 'MemorialState'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.militaryconflict': {
            'Meta': {'object_name': 'MilitaryConflict'},
            'brief': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.ConflictPrintingGroup']", 'null': 'True', 'blank': 'True'})
        },
        'common.militaryunit': {
            'Meta': {'ordering': "['name']", 'object_name': 'MilitaryUnit'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'location': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.SimpleLocation']", 'unique': 'True', 'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.municipalitet': {
            'Meta': {'unique_together': "(('district', 'name'),)", 'object_name': 'Municipalitet'},
            'district': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.District']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.nationality': {
            'Meta': {'object_name': 'Nationality'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.person': {
            'Meta': {'ordering': "['last_name']", 'object_name': 'Person'},
            'birth_date': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'birth_date_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'birth_date_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'birth_location': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.SimpleLocation']", 'unique': 'True', 'null': 'True', 'blank': 'True'}),
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']", 'null': 'True', 'blank': 'True'}),
            'closed_burials': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'closed_persons'", 'symmetrical': 'False', 'to': "orm['common.Burial']"}),
            'creator': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']", 'null': 'True', 'blank': 'True'}),
            'date_of_creation': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'deadman_category': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DeadmanCategory']", 'null': 'True', 'blank': 'True'}),
            'death_cause': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DeathCause']", 'null': 'True', 'blank': 'True'}),
            'death_date': ('django.db.models.fields.DateField', [], {'db_index': 'True', 'null': 'True', 'blank': 'True'}),
            'death_date_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'death_date_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'documents_place': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DocumentsPlace']", 'null': 'True', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'db_index': 'True', 'max_length': '30', 'blank': 'True'}),
            'info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'information_source': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.InformationSource']", 'null': 'True', 'blank': 'True'}),
            'is_trash': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'db_index': 'True'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '128', 'db_index': 'True'}),
            'mia': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'db_index': 'True'}),
            'nationality': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Nationality']", 'null': 'True', 'blank': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'oblocationid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'outside_rb': ('django.db.models.fields.BooleanField', [], {'default': 'False', 'db_index': 'True'}),
            'patronymic': ('django.db.models.fields.CharField', [], {'db_index': 'True', 'max_length': '30', 'blank': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.personattachment': {
            'Meta': {'object_name': 'PersonAttachment'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"}),
            'file': ('django.db.models.fields.files.FileField', [], {'max_length': '100', 'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        'common.personcall': {
            'Meta': {'object_name': 'PersonCall'},
            'date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_no_day': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'date_no_month': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'person': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Person']", 'unique': 'True', 'primary_key': 'True'}),
            'unit': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Comissariat']", 'null': 'True', 'blank': 'True'})
        },
        'common.personduty': {
            'Meta': {'object_name': 'PersonDuty'},
            'person': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Person']", 'unique': 'True', 'primary_key': 'True'}),
            'post': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Post']", 'null': 'True', 'blank': 'True'}),
            'rank': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Rank']", 'null': 'True', 'blank': 'True'}),
            'unit': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.MilitaryUnit']", 'null': 'True'}),
            'unit_name': ('django.db.models.fields.CharField', [], {'max_length': '255', 'db_index': 'True'})
        },
        'common.personeditcause': {
            'Meta': {'object_name': 'PersonEditCause'},
            'date': ('django.db.models.fields.DateField', [], {}),
            'date_edit': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'file': ('django.db.models.fields.files.FileField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"})
        },
        'common.personinformationlinks': {
            'Meta': {'object_name': 'PersonInformationLinks'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"})
        },
        'common.post': {
            'Meta': {'object_name': 'Post'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'})
        },
        'common.rank': {
            'Meta': {'ordering': "['name']", 'object_name': 'Rank'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'db_index': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        'common.searchobject': {
            'Meta': {'object_name': 'SearchObject'},
            'burial': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Burial']", 'unique': 'True'}),
            'date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'inv_number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'common.simplelocation': {
            'Meta': {'object_name': 'SimpleLocation'},
            'city': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True'}),
            'district': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.District']", 'null': 'True', 'blank': 'True'}),
            'gps_x': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_y': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_z': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'municipalitet': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.Municipalitet']", 'null': 'True', 'blank': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'region': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'})
        },
        'common.strictlocation': {
            'Meta': {'object_name': 'StrictLocation'},
            'city': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.GeoCity']"}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True'}),
            'district': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.District']"}),
            'gps_x': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_y': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_z': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'municipalitet': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.Municipalitet']", 'null': 'True', 'blank': 'True'}),
            'obid': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'region': ('smart_selects.db_fields.ChainedForeignKey', [], {'to': "orm['common.GeoRegion']"})
        },
        'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        }
    }

    complete_apps = ['common']
