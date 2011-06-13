# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'GeoCountry'
        db.create_table('common_geocountry', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=24, db_index=True)),
        ))
        db.send_create_signal('common', ['GeoCountry'])

        # Adding model 'GeoRegion'
        db.create_table('common_georegion', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=36, db_index=True)),
        ))
        db.send_create_signal('common', ['GeoRegion'])

        # Adding unique constraint on 'GeoRegion', fields ['country', 'name']
        db.create_unique('common_georegion', ['country_id', 'name'])

        # Adding model 'GeoCity'
        db.create_table('common_geocity', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=36, db_index=True)),
        ))
        db.send_create_signal('common', ['GeoCity'])

        # Adding unique constraint on 'GeoCity', fields ['region', 'name']
        db.create_unique('common_geocity', ['region_id', 'name'])

        # Adding model 'GeoStreet'
        db.create_table('common_geostreet', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=99, db_index=True)),
        ))
        db.send_create_signal('common', ['GeoStreet'])

        # Adding unique constraint on 'GeoStreet', fields ['city', 'name']
        db.create_unique('common_geostreet', ['city_id', 'name'])

        # Adding model 'Rank'
        db.create_table('common_rank', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['Rank'])

        # Adding model 'DeathCause'
        db.create_table('common_deathcause', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['DeathCause'])

        # Adding model 'DeadmanCategory'
        db.create_table('common_deadmancategory', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['DeadmanCategory'])

        # Adding model 'DocumentsPlace'
        db.create_table('common_documentsplace', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['DocumentsPlace'])

        # Adding model 'BurialType'
        db.create_table('common_burialtype', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['BurialType'])

        # Adding model 'MilitaryConflictType'
        db.create_table('common_militaryconflicttype', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('full', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('brief', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['MilitaryConflictType'])

        # Adding model 'MilitaryConflict'
        db.create_table('common_militaryconflict', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('brief', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('military_conflict_type', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.MilitaryConflictType'], null=True, blank=True)),
        ))
        db.send_create_signal('common', ['MilitaryConflict'])

        # Adding model 'InformationSource'
        db.create_table('common_informationsource', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['InformationSource'])

        # Adding model 'ClosureCause'
        db.create_table('common_closurecause', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['ClosureCause'])

        # Adding model 'Nationality'
        db.create_table('common_nationality', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['Nationality'])

        # Adding model 'Person'
        db.create_table('common_person', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('last_name', self.gf('django.db.models.fields.CharField')(max_length=128)),
            ('first_name', self.gf('django.db.models.fields.CharField')(max_length=30, blank=True)),
            ('patronymic', self.gf('django.db.models.fields.CharField')(max_length=30, blank=True)),
            ('birth_date', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('death_date', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('death_cause', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.DeathCause'], null=True, blank=True)),
            ('nationality', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Nationality'], null=True, blank=True)),
            ('deadman_category', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.DeadmanCategory'], null=True, blank=True)),
            ('documents_place', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.DocumentsPlace'], null=True, blank=True)),
            ('information_source', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.InformationSource'], null=True, blank=True)),
            ('creator', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'], null=True, blank=True)),
            ('date_of_creation', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('date_last_edit', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('additional_info', self.gf('django.db.models.fields.TextField')(null=True, blank=True)),
            ('is_trash', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal('common', ['Person'])

        # Adding model 'PersonEditCause'
        db.create_table('common_personeditcause', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('person', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Person'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('number', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('date', self.gf('django.db.models.fields.DateField')()),
        ))
        db.send_create_signal('common', ['PersonEditCause'])

        # Adding model 'PersonInformationLinks'
        db.create_table('common_personinformationlinks', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('person', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Person'])),
            ('link', self.gf('django.db.models.fields.URLField')(max_length=100)),
        ))
        db.send_create_signal('common', ['PersonInformationLinks'])

        # Adding model 'LocationBirth'
        db.create_table('common_locationbirth', (
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'], null=True, blank=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'], null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'], null=True, blank=True)),
            ('person', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['common.Person'], unique=True, primary_key=True)),
        ))
        db.send_create_signal('common', ['LocationBirth'])

        # Adding model 'Burial'
        db.create_table('common_burial', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('passportid', self.gf('django.db.models.fields.CharField')(max_length=128, null=True, blank=True)),
            ('date_passport', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('date_burried', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('date_discovered', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('burial_type', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.BurialType'], null=True, blank=True)),
            ('military_conflict', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.MilitaryConflict'], null=True, blank=True)),
            ('date_memorial', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('date_gosznak', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('unknown_count', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('foto', self.gf('django.db.models.fields.files.FileField')(max_length=100, null=True, blank=True)),
            ('creator', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'], null=True, blank=True)),
            ('date_of_creation', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('date_last_edit', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
            ('additional_info', self.gf('django.db.models.fields.TextField')(null=True, blank=True)),
            ('is_trash', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal('common', ['Burial'])

        # Adding model 'BurialEditCause'
        db.create_table('common_burialeditcause', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('burial', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Burial'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('number', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('date', self.gf('django.db.models.fields.DateField')()),
        ))
        db.send_create_signal('common', ['BurialEditCause'])

        # Adding model 'BurialPictures'
        db.create_table('common_burialpictures', (
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'], null=True, blank=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'], null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'], null=True, blank=True)),
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('burial', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Burial'])),
            ('photo', self.gf('django.db.models.fields.files.ImageField')(max_length=100, null=True)),
        ))
        db.send_create_signal('common', ['BurialPictures'])

        # Adding model 'BurialInformationLinks'
        db.create_table('common_burialinformationlinks', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('burial', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Burial'])),
            ('link', self.gf('django.db.models.fields.URLField')(max_length=100)),
        ))
        db.send_create_signal('common', ['BurialInformationLinks'])

        # Adding model 'SearchObject'
        db.create_table('common_searchobject', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('number', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('date', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('inv_number', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('burial', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['common.Burial'], unique=True)),
            ('link', self.gf('django.db.models.fields.URLField')(max_length=100)),
        ))
        db.send_create_signal('common', ['SearchObject'])

        # Adding model 'ClosedBurial'
        db.create_table('common_closedburial', (
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'], null=True, blank=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'], null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'], null=True, blank=True)),
            ('burial', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['common.Burial'], unique=True, primary_key=True)),
            ('burial_from', self.gf('django.db.models.fields.related.ForeignKey')(related_name='burial_from', to=orm['common.Burial'])),
            ('date', self.gf('django.db.models.fields.DateField')()),
            ('cause', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.ClosureCause'])),
        ))
        db.send_create_signal('common', ['ClosedBurial'])

        # Adding model 'LocationBurial'
        db.create_table('common_locationburial', (
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'], null=True, blank=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'], null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'], null=True, blank=True)),
            ('burial', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['common.Burial'], unique=True, primary_key=True)),
            ('post_index', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
            ('street', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoStreet'], null=True, blank=True)),
            ('house', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
            ('gps_x', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('gps_y', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('gps_z', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
        ))
        db.send_create_signal('common', ['LocationBurial'])

        # Adding model 'Duty'
        db.create_table('common_duty', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
        ))
        db.send_create_signal('common', ['Duty'])

        # Adding model 'PersonBurial'
        db.create_table('common_personburial', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('person', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Person'])),
            ('burial', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Burial'])),
            ('date_burried', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('date_exhumated', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('bnameonmemorial', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal('common', ['PersonBurial'])

        # Adding unique constraint on 'PersonBurial', fields ['person', 'burial']
        db.create_unique('common_personburial', ['person_id', 'burial_id'])

        # Adding model 'PersonDuty'
        db.create_table('common_personduty', (
            ('uuid', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('person', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Person'])),
            ('rank', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Rank'])),
            ('duty', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.Duty'])),
            ('date_from', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('date_to', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
        ))
        db.send_create_signal('common', ['PersonDuty'])

        # Adding model 'LocationDuty'
        db.create_table('common_locationduty', (
            ('country', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCountry'], null=True, blank=True)),
            ('region', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoRegion'], null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoCity'], null=True, blank=True)),
            ('duty', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['common.PersonDuty'], unique=True, primary_key=True)),
            ('post_index', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
            ('street', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['common.GeoStreet'], null=True, blank=True)),
            ('house', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
            ('block', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
            ('building', self.gf('django.db.models.fields.CharField')(max_length=16, blank=True)),
        ))
        db.send_create_signal('common', ['LocationDuty'])


    def backwards(self, orm):
        
        # Removing unique constraint on 'PersonBurial', fields ['person', 'burial']
        db.delete_unique('common_personburial', ['person_id', 'burial_id'])

        # Removing unique constraint on 'GeoStreet', fields ['city', 'name']
        db.delete_unique('common_geostreet', ['city_id', 'name'])

        # Removing unique constraint on 'GeoCity', fields ['region', 'name']
        db.delete_unique('common_geocity', ['region_id', 'name'])

        # Removing unique constraint on 'GeoRegion', fields ['country', 'name']
        db.delete_unique('common_georegion', ['country_id', 'name'])

        # Deleting model 'GeoCountry'
        db.delete_table('common_geocountry')

        # Deleting model 'GeoRegion'
        db.delete_table('common_georegion')

        # Deleting model 'GeoCity'
        db.delete_table('common_geocity')

        # Deleting model 'GeoStreet'
        db.delete_table('common_geostreet')

        # Deleting model 'Rank'
        db.delete_table('common_rank')

        # Deleting model 'DeathCause'
        db.delete_table('common_deathcause')

        # Deleting model 'DeadmanCategory'
        db.delete_table('common_deadmancategory')

        # Deleting model 'DocumentsPlace'
        db.delete_table('common_documentsplace')

        # Deleting model 'BurialType'
        db.delete_table('common_burialtype')

        # Deleting model 'MilitaryConflictType'
        db.delete_table('common_militaryconflicttype')

        # Deleting model 'MilitaryConflict'
        db.delete_table('common_militaryconflict')

        # Deleting model 'InformationSource'
        db.delete_table('common_informationsource')

        # Deleting model 'ClosureCause'
        db.delete_table('common_closurecause')

        # Deleting model 'Nationality'
        db.delete_table('common_nationality')

        # Deleting model 'Person'
        db.delete_table('common_person')

        # Deleting model 'PersonEditCause'
        db.delete_table('common_personeditcause')

        # Deleting model 'PersonInformationLinks'
        db.delete_table('common_personinformationlinks')

        # Deleting model 'LocationBirth'
        db.delete_table('common_locationbirth')

        # Deleting model 'Burial'
        db.delete_table('common_burial')

        # Deleting model 'BurialEditCause'
        db.delete_table('common_burialeditcause')

        # Deleting model 'BurialPictures'
        db.delete_table('common_burialpictures')

        # Deleting model 'BurialInformationLinks'
        db.delete_table('common_burialinformationlinks')

        # Deleting model 'SearchObject'
        db.delete_table('common_searchobject')

        # Deleting model 'ClosedBurial'
        db.delete_table('common_closedburial')

        # Deleting model 'LocationBurial'
        db.delete_table('common_locationburial')

        # Deleting model 'Duty'
        db.delete_table('common_duty')

        # Deleting model 'PersonBurial'
        db.delete_table('common_personburial')

        # Deleting model 'PersonDuty'
        db.delete_table('common_personduty')

        # Deleting model 'LocationDuty'
        db.delete_table('common_locationduty')


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
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'common.burial': {
            'Meta': {'object_name': 'Burial'},
            'additional_info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'burial_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.BurialType']", 'null': 'True', 'blank': 'True'}),
            'creator': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']", 'null': 'True', 'blank': 'True'}),
            'date_burried': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_discovered': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_gosznak': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_last_edit': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'date_memorial': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_of_creation': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'date_passport': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'foto': ('django.db.models.fields.files.FileField', [], {'max_length': '100', 'null': 'True', 'blank': 'True'}),
            'is_trash': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'military_conflict': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.MilitaryConflict']", 'null': 'True', 'blank': 'True'}),
            'passportid': ('django.db.models.fields.CharField', [], {'max_length': '128', 'null': 'True', 'blank': 'True'}),
            'persons': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['common.Person']", 'through': "orm['common.PersonBurial']", 'symmetrical': 'False'}),
            'unknown_count': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.burialeditcause': {
            'Meta': {'object_name': 'BurialEditCause'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'date': ('django.db.models.fields.DateField', [], {}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.burialinformationlinks': {
            'Meta': {'object_name': 'BurialInformationLinks'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.burialpictures': {
            'Meta': {'object_name': 'BurialPictures'},
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True', 'blank': 'True'}),
            'photo': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'null': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.burialtype': {
            'Meta': {'object_name': 'BurialType'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.closedburial': {
            'Meta': {'object_name': 'ClosedBurial'},
            'burial': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Burial']", 'unique': 'True', 'primary_key': 'True'}),
            'burial_from': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'burial_from'", 'to': "orm['common.Burial']"}),
            'cause': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.ClosureCause']"}),
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True', 'blank': 'True'}),
            'date': ('django.db.models.fields.DateField', [], {}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'})
        },
        'common.closurecause': {
            'Meta': {'object_name': 'ClosureCause'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.deadmancategory': {
            'Meta': {'object_name': 'DeadmanCategory'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.deathcause': {
            'Meta': {'object_name': 'DeathCause'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.documentsplace': {
            'Meta': {'object_name': 'DocumentsPlace'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.duty': {
            'Meta': {'object_name': 'Duty'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'persons': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['common.Person']", 'through': "orm['common.PersonDuty']", 'symmetrical': 'False'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.geocity': {
            'Meta': {'unique_together': "(('region', 'name'),)", 'object_name': 'GeoCity'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']"}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.geocountry': {
            'Meta': {'ordering': "['name']", 'object_name': 'GeoCountry'},
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '24', 'db_index': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.georegion': {
            'Meta': {'unique_together': "(('country', 'name'),)", 'object_name': 'GeoRegion'},
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']"}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'db_index': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.geostreet': {
            'Meta': {'ordering': "['city', 'name']", 'unique_together': "(('city', 'name'),)", 'object_name': 'GeoStreet'},
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']"}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '99', 'db_index': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.informationsource': {
            'Meta': {'object_name': 'InformationSource'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.locationbirth': {
            'Meta': {'object_name': 'LocationBirth'},
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True', 'blank': 'True'}),
            'person': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Person']", 'unique': 'True', 'primary_key': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'})
        },
        'common.locationburial': {
            'Meta': {'object_name': 'LocationBurial'},
            'burial': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Burial']", 'unique': 'True', 'primary_key': 'True'}),
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True', 'blank': 'True'}),
            'gps_x': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_y': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'gps_z': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'house': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'post_index': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'}),
            'street': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoStreet']", 'null': 'True', 'blank': 'True'})
        },
        'common.locationduty': {
            'Meta': {'object_name': 'LocationDuty'},
            'block': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'building': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCity']", 'null': 'True', 'blank': 'True'}),
            'country': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoCountry']", 'null': 'True', 'blank': 'True'}),
            'duty': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.PersonDuty']", 'unique': 'True', 'primary_key': 'True'}),
            'house': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'post_index': ('django.db.models.fields.CharField', [], {'max_length': '16', 'blank': 'True'}),
            'region': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoRegion']", 'null': 'True', 'blank': 'True'}),
            'street': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.GeoStreet']", 'null': 'True', 'blank': 'True'})
        },
        'common.militaryconflict': {
            'Meta': {'object_name': 'MilitaryConflict'},
            'brief': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'military_conflict_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.MilitaryConflictType']", 'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.militaryconflicttype': {
            'Meta': {'object_name': 'MilitaryConflictType'},
            'brief': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'full': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.nationality': {
            'Meta': {'object_name': 'Nationality'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.person': {
            'Meta': {'ordering': "['last_name']", 'object_name': 'Person'},
            'additional_info': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'birth_date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'creator': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']", 'null': 'True', 'blank': 'True'}),
            'date_last_edit': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            'date_of_creation': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'deadman_category': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DeadmanCategory']", 'null': 'True', 'blank': 'True'}),
            'death_cause': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DeathCause']", 'null': 'True', 'blank': 'True'}),
            'death_date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'documents_place': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.DocumentsPlace']", 'null': 'True', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'information_source': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.InformationSource']", 'null': 'True', 'blank': 'True'}),
            'is_trash': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'nationality': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Nationality']", 'null': 'True', 'blank': 'True'}),
            'patronymic': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.personburial': {
            'Meta': {'unique_together': "(('person', 'burial'),)", 'object_name': 'PersonBurial'},
            'bnameonmemorial': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'burial': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Burial']"}),
            'date_burried': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_exhumated': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.personduty': {
            'Meta': {'object_name': 'PersonDuty'},
            'date_from': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'date_to': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'duty': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Duty']"}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"}),
            'rank': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Rank']"}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.personeditcause': {
            'Meta': {'object_name': 'PersonEditCause'},
            'date': ('django.db.models.fields.DateField', [], {}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.personinformationlinks': {
            'Meta': {'object_name': 'PersonInformationLinks'},
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'}),
            'person': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['common.Person']"}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.rank': {
            'Meta': {'object_name': 'Rank'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        },
        'common.searchobject': {
            'Meta': {'object_name': 'SearchObject'},
            'burial': ('django.db.models.fields.related.OneToOneField', [], {'to': "orm['common.Burial']", 'unique': 'True'}),
            'date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'inv_number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'link': ('django.db.models.fields.URLField', [], {'max_length': '100'}),
            'number': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'uuid': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
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
