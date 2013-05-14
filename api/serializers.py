from django.forms import widgets
from rest_framework.serializers import ModelSerializer, SlugRelatedField
from api.models import *

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ('user_id', 'name')

class ImageTypeSerializer(ModelSerializer):
    class Meta:
        model = ImageType
        fields = ('image_type',)

class ImageSerializer(ModelSerializer):
    #owner = UserSerializer(read_only=True)
    image_type = SlugRelatedField(slug_field='image_type')
    class Meta:
        model = Image
        fields = ('id', 'owner', 'public_data', 'filename', 'image_type', 'checksum', 'checksum_64x64', 'checksum_half', 'checksum_mobile', 'height', 'width', 'version')
        
class MetamorphicGradeSerializer(ModelSerializer):
    class Meta:
        model = MetamorphicGrade
        fields = ('name',)

class MetamorphicRegionSerializer(ModelSerializer):
    class Meta:
        model = MetamorphicRegion
        fields = ('name',)

class MineralSerializer(ModelSerializer):
    class Meta:
        model = Mineral
        fields = ('name',)
        
class ReferencesSerializer(ModelSerializer):
    class Meta:
        model = Reference
        fields = ('name',)

class RegionSerializer(ModelSerializer):
    class Meta:
        model = Region
        fields = ('name',)

class RockTypeSerializer(ModelSerializer):
    class Meta:
        model = RockType
        fields = ('rock_type_id', 'rock_type')

class SampleAliasSerializer(ModelSerializer):
    class Meta:
        model = SampleAlias
        fields = ('sample_alias_id', 'alias',)

class SampleSerializer(ModelSerializer):
    owner = UserSerializer(read_only=True)
    collector = UserSerializer(read_only=True)
    rock_type = SlugRelatedField(slug_field='rock_type')
    aliases = SampleAliasSerializer(many=True, allow_add_remove=True)

    # rest_framework does not support ManyToMany at the moment hence read_only
    images = ImageSerializer(many=True, allow_add_remove=True)
    metamorphic_grades = MetamorphicGradeSerializer(many=True, read_only=True)
    metamorphic_regions = MetamorphicRegionSerializer(many=True, read_only=True)
    minerals = MineralSerializer(many=True, read_only=True)
    references = ReferencesSerializer(many=True, read_only=True)
    regions = RegionSerializer(many=True, read_only=True)

    class Meta:
        model = Sample
        fields = ('id', 'number', 'collection_date', 'public_data', 'country', 'description', 'location_text', 'owner', 'collector', 'collector_name', 'rock_type', 'aliases', 'images', 'metamorphic_grades', 'metamorphic_regions', 'minerals', 'references', 'regions', 'version')

class SampleRegionSerializer(ModelSerializer):
    region = SlugRelatedField(slug_field='name')

    def __init__(self, instance=None, data=None, files=None,
                 context=None, partial=False, many=None,
                 allow_add_remove=False, **kwargs):
        if data and u'id' in data and u'regions' in data:
            newData = []
            for region in data[u'regions']:
                if u'name' in region:
                    newRegion = {u'sample':data[u'id'],u'region':region[u'name']}
                    newData.append(newRegion)
        else:
            newData = data

        super(SampleRegionSerializer, self).__init__(instance, newData, files,
                 context, partial, many, allow_add_remove, **kwargs)

    class Meta:
        model = SampleRegion
        fields = ('sample', 'region')

