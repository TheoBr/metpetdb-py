from django.http import HttpResponse, Http404
from django.db import connection as con
import json

from api.permissions import IsOwnerOrProjectMember
from api.serializers import SampleSerializer, SampleRegionSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from models import Sample, SampleRegion

class SampleDetails(APIView):
    def get_object(self, id):
        try:
            return Sample.objects.get(id=id)
        except Sample.DoesNotExist:
            raise Http404

    def get(self, request, id, format=None):
        sample = self.get_object(id)
        serializer = SampleSerializer(sample)
        return Response(serializer.data)

    def put(self, request, id, format=None):
        sample = self.get_object(id)
        sampleSerializer = SampleSerializer(sample, data=request.DATA)
        sampleRegionSerializer = SampleRegionSerializer(SampleRegion.objects.filter(sample=sample).all(), many=True, data=request.DATA, allow_add_remove=True)
        if sampleSerializer.is_valid() and sampleRegionSerializer.is_valid():
            sampleSerializer.save()
            sampleRegionSerializer.save()
            return Response(sampleSerializer.data)
        return Response(sampleSerializer.errors, status=status.HTTP_400_BAD_REQUEST)

# for testing
class SampleRegionDetails(APIView):
    def get_objects(self, sample_id):
        try:
            return SampleRegion.objects.filter(sample=sample_id).all()
        except:
            raise Http404

    def get(self, request, id, format=None):
        sampleRegions = self.get_objects(id)
        serializer = SampleRegionSerializer(sampleRegions, many=True)
        return Response(serializer.data)

    def put(self, request, id, format=None):
        sampleRegions = self.get_objects(id)
        sampleRegionSerializer = SampleRegionSerializer(sampleRegions, many=True, data=request.DATA, allow_add_remove=True)
        if sampleRegionSerializer.is_valid():
            sampleRegionSerializer.save()
            return Response(sampleRegionSerializer.data)
        return Response(sampleRegionSerializer.errors, status=status.HTTP_400_BAD_REQUEST)
