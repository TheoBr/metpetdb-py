from django.conf.urls import patterns, include, url
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
# from django.views.generic.simple import direct_to_template
# from django.views.generic.simple import redirect_to
# from django.views.generic import TemplateView


# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

from tastyapi.resources import SampleResource, RockTypeResource, \
                               SubsampleResource, SubsampleTypeResource, \
                               ReferenceResource, ChemicalAnalysisResource, \
                               MineralResource, UserResource, RegionResource, \
                               MetamorphicGradeResource, SampleAliasResource, \
                               MetamorphicRegionResource
from tastypie.api import Api

api_v1 = Api(api_name='v1')
api_v1.register(UserResource())
api_v1.register(SampleResource())
api_v1.register(SampleAliasResource())
api_v1.register(RockTypeResource())
api_v1.register(SubsampleResource())
api_v1.register(SubsampleTypeResource())
api_v1.register(ReferenceResource())
api_v1.register(ChemicalAnalysisResource())
api_v1.register(MineralResource())
api_v1.register(RegionResource())
api_v1.register(MetamorphicGradeResource())
api_v1.register(MetamorphicRegionResource())

urlpatterns = patterns('',
  url(r'^api/', include(api_v1.urls)),

  url(r'^register/$', 'tastyapi.views.register'),
  url(r'^login/$', 'tastyapi.views.login', name="login"),
  url(r'^logout/$', 'tastyapi.views.logout', name="logout"),

  url(r'^confirm/([a-zA-Z0-9]*)/$', 'tastyapi.views.confirm'),
  url(r'^request_contributor_access/$',
      'tastyapi.views.request_contributor_access'),
  url(r'^grant_contributor_access/([a-zA-Z0-9]*)/$',
      'tastyapi.views.grant_contributor_access'),

  url(r'^$', 'webservices.views.index', name='index'),
  url(r'^search/$', 'webservices.views.search', name='search'),

  url(r'^samples/$', 'webservices.views.samples', name='samples'),
  url(r'^sample/(\d+)/$','webservices.views.sample', name='sample'),

  url(r'^subsamples/$', 'webservices.views.subsamples', name="subsamples"),
  url(r'^subsample/(\d+)/$','webservices.views.subsample', name='subsample'),

  url(r'^chemical_analyses/$', 'webservices.views.chemical_analyses',
                                name="chemical_analyses"),
  url(r'^chemical_analysis/(\d+)/$', 'webservices.views.chemical_analysis',
                                      name='chemical_analysis'),

  url(r'^user/(\d+)/$','webservices.views.user', name='user'),

  url(r'^api/metpetdb/$','webservices.views.metpetdb'),

  # Uncomment the admin/doc line below to enable admin documentation:
  # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

  # Uncomment the next line to enable the admin:
  # url(r'^admin/', include(admin.site.urls)),
)
urlpatterns+=staticfiles_urlpatterns()

