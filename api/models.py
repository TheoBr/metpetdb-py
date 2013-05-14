from django.db.models import Model, BigIntegerField, CharField, DateTimeField, FloatField, ForeignKey, IntegerField,ManyToManyField, SmallIntegerField, TextField
from compositekey.db import MultiFieldPK

PUBLIC_DATA_CHOICES = (('Y', 'Yes'),('N', 'No'))

class ImageType(Model):
    image_type_id = SmallIntegerField(primary_key=True)
    image_type = CharField(max_length=100, unique=True)
    abbreviation = CharField(max_length=10, unique=True, blank=True)
    comments = CharField(max_length=250, blank=True)
    class Meta:
        db_table = u'image_type'

class Image(Model):
    id = BigIntegerField(primary_key=True, db_column='image_id')
    checksum = CharField(max_length=50)
    version = IntegerField()
    sample = ForeignKey('Sample', related_name='images', null=True, blank=True)
    subsample = ForeignKey('Subsample', null=True, blank=True)
    image_format = ForeignKey('ImageFormat', null=True, blank=True)
    image_type = ForeignKey('ImageType')
    width = SmallIntegerField()
    height = SmallIntegerField()
    collector = CharField(max_length=50, blank=True)
    description = CharField(max_length=1024, blank=True)
    scale = SmallIntegerField(null=True, blank=True)
    owner = ForeignKey('User', db_column='user_id')
    public_data = CharField(max_length=1, choices=PUBLIC_DATA_CHOICES)
    checksum_64x64 = CharField(max_length=50)
    checksum_half = CharField(max_length=50)
    filename = CharField(max_length=256)
    checksum_mobile = CharField(max_length=50, blank=True)
    class Meta:
        db_table = u'images'
        
class Mineral(Model):
    mineral_id = SmallIntegerField(primary_key=True)
    real_mineral = ForeignKey('self')
    name = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'minerals'
        
class MetamorphicGrade(Model):
    metamorphic_grade_id = SmallIntegerField(primary_key=True)
    name = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'metamorphic_grades'
        
class MetamorphicRegion(Model):
    metamorphic_region_id = BigIntegerField(primary_key=True)
    name = CharField(max_length=50, unique=True)
    shape = TextField(blank=True) # This field type is a guess.
    description = TextField(blank=True)
    label_location = TextField(blank=True) # This field type is a guess.
    class Meta:
        db_table = u'metamorphic_regions'
        
class Reference(Model):
    reference_id = BigIntegerField(primary_key=True)
    name = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'reference'
        
class Region(Model):
    region_id = SmallIntegerField(primary_key=True)
    name = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'regions'
        
class RockType(Model):
    rock_type_id = SmallIntegerField(primary_key=True)
    rock_type = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'rock_type'
                

class Sample(Model):   
    id = BigIntegerField(primary_key=True, db_column='sample_id')
    version = IntegerField()
    sesar_number = CharField(max_length=9, blank=True)
    public_data = CharField(max_length=1, choices=PUBLIC_DATA_CHOICES)
    collection_date = DateTimeField(null=True, blank=True)
    date_precision = SmallIntegerField(null=True, blank=True)
    number = CharField(max_length=35)
    rock_type = ForeignKey(RockType)
    owner = ForeignKey('User', db_column='user_id', related_name='Sample_user')
    location_error = FloatField(null=True, blank=True)
    country = CharField(max_length=100, blank=True)
    description = TextField(blank=True)
    collector_name = CharField(db_column='collector', max_length=50, blank=True)
    collector = ForeignKey('User', db_column='collector_id',  blank=True) # would be collector_id_id
    location_text = CharField(max_length=50, blank=True)
    location = TextField() # This field type is a guess.
    aliases = ManyToManyField('SampleAlias', through='SampleAlias')
    images = ManyToManyField(Image, through='Image')
    metamorphic_grades = ManyToManyField(MetamorphicGrade, through='SampleMetamorphicGrade')
    metamorphic_regions = ManyToManyField(MetamorphicRegion, through='SampleMetamorphicRegion')
    minerals = ManyToManyField(Mineral, through='SampleMineral')
    references = ManyToManyField(Reference, through='SampleReference')
    regions = ManyToManyField(Region, through='SampleRegion')
    class Meta:
        db_table = u'samples'
        
class SampleAlias(Model):
    sample_alias_id = BigIntegerField(primary_key=True)
    sample = ForeignKey(Sample, related_name='aliases', null=True, blank=True)
    alias = CharField(max_length=35)
    class Meta:
        db_table = u'sample_aliases'
        unique_together = (('sample', 'alias'),)
        
class SampleMetamorphicGrade(Model):
    sample_metamorphic_grade_id = MultiFieldPK('sample', 'metamorphic_grade')
    sample = ForeignKey(Sample)
    metamorphic_grade = ForeignKey(MetamorphicGrade)
    
    class Meta:
        db_table = u'sample_metamorphic_grades'

class SampleMetamorphicRegion(Model):
    sample_metamorphic_region_id = MultiFieldPK('sample', 'metamorphic_region')
    sample = ForeignKey(Sample)
    metamorphic_region = ForeignKey(MetamorphicRegion)
    class Meta:
        db_table = u'sample_metamorphic_regions'
        
class SampleMineral(Model):
    sample_mineral_id = MultiFieldPK('sample', 'mineral')
    sample = ForeignKey(Sample)
    mineral = ForeignKey(Mineral)
    amount = CharField(max_length=30, blank=True)
    class Meta:
        db_table = u'sample_minerals'

class SampleReference(Model):
    sample = ForeignKey(Sample)
    reference = ForeignKey(Reference)
    class Meta:
        db_table = u'sample_reference'

class SampleRegion(Model):
    sample_region_id = MultiFieldPK('sample', 'region')
    sample = ForeignKey(Sample)
    region = ForeignKey(Region)
    class Meta:
        db_table = u'sample_regions'





# Need to check these for validity
# VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

class MineralType(Model):
    mineral_type_id = SmallIntegerField(primary_key=True)
    name = CharField(max_length=50)
    class Meta:
        db_table = u'mineral_types'

class Element(Model):
    element_id = SmallIntegerField(primary_key=True)
    name = CharField(max_length=100, unique=True)
    alternate_name = CharField(max_length=100, blank=True)
    symbol = CharField(max_length=4, unique=True)
    atomic_number = IntegerField()
    weight = FloatField(null=True, blank=True)
    order_id = IntegerField(null=True, blank=True)
    class Meta:
        db_table = u'elements'

class Oxide(Model):
    oxide_id = SmallIntegerField(primary_key=True)
    element = ForeignKey(Element)
    oxidation_state = SmallIntegerField(null=True, blank=True)
    species = CharField(max_length=20, unique=True, blank=True)
    weight = FloatField(null=True, blank=True)
    cations_per_oxide = SmallIntegerField(null=True, blank=True)
    conversion_factor = FloatField()
    order_id = IntegerField(null=True, blank=True)
    class Meta:
        db_table = u'oxides'

class ImageFormat(Model):
    image_format_id = SmallIntegerField(primary_key=True)
    name = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'image_format'

class User(Model):
    user_id = IntegerField(primary_key=True)
    version = IntegerField()
    name = CharField(max_length=100)
    email = CharField(max_length=255, unique=True)
    password = TextField() # This field type is a guess.
    address = CharField(max_length=200, blank=True)
    city = CharField(max_length=50, blank=True)
    province = CharField(max_length=100, blank=True)
    country = CharField(max_length=100, blank=True)
    postal_code = CharField(max_length=15, blank=True)
    institution = CharField(max_length=300, blank=True)
    reference_email = CharField(max_length=255, blank=True)
    confirmation_code = CharField(max_length=32, blank=True)
    enabled = CharField(max_length=1)
    role_id = SmallIntegerField(null=True, blank=True)
    contributor_code = CharField(max_length=32, blank=True)
    contributor_enabled = CharField(max_length=1, blank=True)
    professional_url = CharField(max_length=255, blank=True)
    research_interests = CharField(max_length=1024, blank=True)
    request_contributor = CharField(max_length=1, blank=True)
    class Meta:
        db_table = u'users'

class SubsampleType(Model):
    subsample_type_id = SmallIntegerField(primary_key=True)
    subsample_type = CharField(max_length=100, unique=True)
    class Meta:
        db_table = u'subsample_type'

class Subsample(Model):
    subsample_id = BigIntegerField(primary_key=True)
    version = IntegerField()
    public_data = CharField(max_length=1)
    sample = ForeignKey(Sample)
    user = ForeignKey(User)
    grid_id = BigIntegerField(null=True, blank=True)
    name = CharField(max_length=100)
    subsample_type = ForeignKey(SubsampleType)
    class Meta:
        db_table = u'subsamples'



class GeographyColumns(Model):
    f_table_catalog = TextField(blank=True) # This field type is a guess.
    f_table_schema = TextField(blank=True) # This field type is a guess.
    f_table_name = TextField(blank=True) # This field type is a guess.
    f_geography_column = TextField(blank=True) # This field type is a guess.
    coord_dimension = IntegerField(null=True, blank=True)
    srid = IntegerField(null=True, blank=True)
    type = TextField(blank=True)
    class Meta:
        db_table = u'geography_columns'

class ChemicalAnalysis(Model):
    chemical_analysis_id = BigIntegerField(primary_key=True)
    version = IntegerField()
    subsample = ForeignKey(Subsample)
    public_data = CharField(max_length=1)
    reference_x = FloatField(null=True, blank=True)
    reference_y = FloatField(null=True, blank=True)
    stage_x = FloatField(null=True, blank=True)
    stage_y = FloatField(null=True, blank=True)
    image = ForeignKey(Image, null=True, blank=True)
    analysis_method = CharField(max_length=50, blank=True)
    where_done = CharField(max_length=50, blank=True)
    analyst = CharField(max_length=50, blank=True)
    analysis_date = DateTimeField(null=True, blank=True)
    date_precision = SmallIntegerField(null=True, blank=True)
    reference = ForeignKey(Reference, null=True, blank=True)
    description = CharField(max_length=1024, blank=True)
    mineral = ForeignKey(Mineral, null=True, blank=True)
    user = ForeignKey(User)
    large_rock = CharField(max_length=1)
    total = FloatField(null=True, blank=True)
    spot_id = BigIntegerField()
    class Meta:
        db_table = u'chemical_analyses'

class ChemicalAnalysisOxide(Model):
    chemical_analysis = ForeignKey(ChemicalAnalysis)
    oxide = ForeignKey(Oxide)
    amount = FloatField()
    precision = FloatField(null=True, blank=True)
    precision_type = CharField(max_length=3, blank=True)
    measurement_unit = CharField(max_length=4, blank=True)
    min_amount = FloatField(null=True, blank=True)
    max_amount = FloatField(null=True, blank=True)
    class Meta:
        db_table = u'chemical_analysis_oxides'

class ElementMineralType(Model):
    element = ForeignKey(Element)
    mineral_type = ForeignKey(MineralType)
    id = IntegerField(primary_key=True)
    class Meta:
        db_table = u'element_mineral_types'

class GeometryColumns(Model):
    f_table_catalog = CharField(max_length=256)
    f_table_schema = CharField(max_length=256)
    f_table_name = CharField(max_length=256)
    f_geometry_column = CharField(max_length=256)
    coord_dimension = IntegerField()
    srid = IntegerField()
    type = CharField(max_length=30)
    class Meta:
        db_table = u'geometry_columns'

class Georeference(Model):
    georef_id = BigIntegerField(primary_key=True)
    title = TextField()
    first_author = TextField()
    second_authors = TextField(blank=True)
    journal_name = TextField()
    full_text = TextField()
    reference_number = TextField(blank=True)
    reference_id = BigIntegerField(null=True, blank=True)
    journal_name_2 = TextField(blank=True)
    doi = TextField(blank=True)
    publication_year = TextField(blank=True)
    class Meta:
        db_table = u'georeference'

class ImageComment(Model):
    comment_id = BigIntegerField(primary_key=True)
    image = ForeignKey(Image)
    comment_text = TextField()
    version = IntegerField()
    class Meta:
        db_table = u'image_comments'

class Grids(Model):
    grid_id = BigIntegerField(primary_key=True)
    version = IntegerField()
    subsample = ForeignKey(Subsample)
    width = SmallIntegerField()
    height = SmallIntegerField()
    public_data = CharField(max_length=1)
    class Meta:
        db_table = u'grids'

class ImageOnGrid(Model):
    image_on_grid_id = BigIntegerField(primary_key=True)
    grid = ForeignKey(Grids)
    image = ForeignKey(Image)
    top_left_x = FloatField()
    top_left_y = FloatField()
    z_order = SmallIntegerField()
    opacity = SmallIntegerField()
    resize_ratio = FloatField()
    width = SmallIntegerField()
    height = SmallIntegerField()
    checksum = CharField(max_length=50)
    checksum_64x64 = CharField(max_length=50)
    checksum_half = CharField(max_length=50)
    locked = CharField(max_length=1)
    angle = FloatField(null=True, blank=True)
    class Meta:
        db_table = u'image_on_grid'

class AdminUser(Model):
    admin_id = IntegerField(primary_key=True)
    user = ForeignKey(User)
    class Meta:
        db_table = u'admin_users'

class ImageReference(Model):
    image = ForeignKey(Image)
    reference = ForeignKey(Reference)
    class Meta:
        db_table = u'image_reference'


class SampleComment(Model):
    comment_id = BigIntegerField(primary_key=True)
    sample = ForeignKey(Sample)
    user = ForeignKey(User)
    comment_text = TextField()
    date_added = DateTimeField(null=True, blank=True)
    class Meta:
        db_table = u'sample_comments'

class OxideMineralType(Model):
    oxide = ForeignKey(Oxide)
    mineral_type = ForeignKey(MineralType)
    id = IntegerField(primary_key=True)
    class Meta:
        db_table = u'oxide_mineral_types'

class Project(Model):
    project_id = IntegerField(primary_key=True)
    version = IntegerField()
    user = ForeignKey(User)
    name = CharField(max_length=50)
    description = CharField(max_length=300, blank=True)
    isactive = CharField(max_length=1, blank=True)
    class Meta:
        db_table = u'projects'

class ProjectSample(Model):
    project = ForeignKey(Project)
    sample = ForeignKey(Sample)
    class Meta:
        db_table = u'project_samples'

class ProjectMembers(Model):
    project = ForeignKey(Project)
    user = ForeignKey(User)
    class Meta:
        db_table = u'project_members'

class ProjectInvite(Model):
    invite_id = IntegerField(primary_key=True)
    project = ForeignKey(Project)
    user = ForeignKey(User)
    action_timestamp = DateTimeField()
    status = CharField(max_length=32, blank=True)
    class Meta:
        db_table = u'project_invites'

class Roles(Model):
    role_id = SmallIntegerField(primary_key=True)
    role_name = CharField(max_length=50)
    rank = SmallIntegerField(null=True, blank=True)
    class Meta:
        db_table = u'roles'

class RoleChanges(Model):
    role_changes_id = BigIntegerField(primary_key=True)
    user = ForeignKey(User,related_name='RoleChanges_user')
    sponsor = ForeignKey(User,related_name='RoleChanges_sponsor')
    request_date = DateTimeField()
    finalize_date = DateTimeField(null=True, blank=True)
    role = ForeignKey(Roles)
    granted = CharField(max_length=1, blank=True)
    grant_reason = TextField(blank=True)
    request_reason = TextField(blank=True)
    class Meta:
        db_table = u'role_changes'

class Subsample(Model):
    subsample_id = BigIntegerField(primary_key=True)
    version = IntegerField()
    public_data = CharField(max_length=1)
    sample = ForeignKey(Sample)
    user = ForeignKey(User)
    grid_id = BigIntegerField(null=True, blank=True)
    name = CharField(max_length=100)
    subsample_type = ForeignKey(SubsampleType)
    class Meta:
        db_table = u'subsamples'

class SpatialRefSys(Model):
    srid = IntegerField(primary_key=True)
    auth_name = CharField(max_length=256, blank=True)
    auth_srid = IntegerField(null=True, blank=True)
    srtext = CharField(max_length=2048, blank=True)
    proj4text = CharField(max_length=2048, blank=True)
    class Meta:
        db_table = u'spatial_ref_sys'

class UserRoles(Model):
    user_id = IntegerField()
    role_id = SmallIntegerField()
    class Meta:
        db_table = u'users_roles'

class UploadedFiles(Model):
    uploaded_file_id = BigIntegerField(primary_key=True)
    hash = CharField(max_length=50)
    filename = CharField(max_length=255)
    time = DateTimeField()
    user = ForeignKey(User, null=True, blank=True)
    class Meta:
        db_table = u'uploaded_files'

class XrayImage(Model):
    image = ForeignKey(Image, primary_key=True)
    element = CharField(max_length=256, blank=True)
    dwelltime = SmallIntegerField(null=True, blank=True)
    current = SmallIntegerField(null=True, blank=True)
    voltage = SmallIntegerField(null=True, blank=True)
    class Meta:
        db_table = u'xray_image'

class ChemicalAnalysisElement(Model):
    chemical_analysis = ForeignKey(ChemicalAnalysis)
    element = ForeignKey(Element)
    amount = FloatField()
    precision = FloatField(null=True, blank=True)
    precision_type = CharField(max_length=3, blank=True)
    measurement_unit = CharField(max_length=4, blank=True)
    min_amount = FloatField(null=True, blank=True)
    max_amount = FloatField(null=True, blank=True)
    id = IntegerField(primary_key=True)
    class Meta:
        db_table = u'chemical_analysis_elements'

class MineralRelationship(Model):
    parent_mineral = ForeignKey(Mineral,related_name='MineralRelationships_parent_mineral')
    child_mineral = ForeignKey(Mineral,related_name='MineralRelationships_child_mineral')
    id = IntegerField(primary_key=True)
    class Meta:
        db_table = u'mineral_relationships'
