from django.conf.urls import patterns, url
from rest_framework.urlpatterns import format_suffix_patterns
from api import views

urlpatterns = patterns('',
    url(r'^samples/(?P<id>[0-9]+)/$', views.SampleDetails.as_view()),

    # for testing
    url(r'^samples/regions/(?P<id>[0-9]+)/$', views.SampleRegionDetails.as_view()),
)

urlpatterns = format_suffix_patterns(urlpatterns)
