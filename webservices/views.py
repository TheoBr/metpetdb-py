from django.core.urlresolvers import reverse
from django.http import HttpResponse, HttpResponseRedirect
import urllib
import ast
import json
import sys
from django.shortcuts import render
from django.db import connection as con
from webservices.SampleQuery import *
from webservices.utility import *
from webservices.sample import SampleObject, SampleImagesObject
from webservices.subsample import SubsampleObject, SubsampleTableObject, SubsampleImagesTableObject
from webservices.chemicalanalysis import ChemicalAnalysisObject, ChemicalAnalysisTableObject
from webservices.db import MetPet
from tastyapi.models import Region, Sample, Reference, MetamorphicRegion
from tastyapi.models import ChemicalAnalyses
from getenv import env


#direct stdout to stderr so that it is logged by the webserver
sys.stdout = sys.stderr

#Main interface view
def index(request):
    return render(request, 'homepage.html')

#Request to serve search.html
def search(request):
    filters = dict(request.GET.iterlists())
    filter_dictionary = {}

    for key in filters:
        if filters[key][0]:
          if key != "resource":
            filter_dictionary[key] = ",".join(filters[key])

    if request.GET.get('resource') == 'sample':
        url = reverse('samples') + '?' + urllib.urlencode(filter_dictionary)
        return HttpResponseRedirect(url)
    elif request.GET.get('resource') == 'chemicalanalysis':
        url = reverse('chemical_analyses') + '?' + urllib.urlencode(filter_dictionary)
        return HttpResponseRedirect(url)

    region_list = []
    collector_list = []
    reference_list = []
    metamorphic_region_list = []
    all_regions = Region.objects.all().order_by("name")
    all_samples = Sample.objects.all().order_by("collector")
    all_references = Reference.objects.all().order_by("name")
    all_metamorphic_regions = MetamorphicRegion.objects.all().order_by("name")

    for region in all_regions:
        region_list.append(region.name)
    for sample in all_samples:
        if sample.collector and sample.collector not in collector_list:
            collector_list.append(unicode(sample.collector))
    for ref in all_references:
        reference_list.append(ref.name)
    for mmr in all_metamorphic_regions:
        metamorphic_region_list.append(mmr.name)

    return render(request, 'search_form.html',
        {'samples': [], 'query': '', 'regions':region_list,
         'provenenances': collector_list, "references": reference_list,
          "mmrs": metamorphic_region_list})


def samples(request):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api

    filters = ast.literal_eval(json.dumps(request.GET))
    offset = request.GET.get('offset', 0)
    filters['offset'] = offset
    data = api.sample.get(params=filters)

    next, previous, last, total_count = paginate_model('samples', data, filters)

    samples = data.data['objects']
    for sample in samples:
        mineral_names = [mineral['name'] for mineral in sample['minerals']]
        sample['mineral_list'] = (', ').join(mineral_names)

    first_page_filters = filters
    del first_page_filters['offset']

    return render(request,
                 'samples.html',
                 {
                      'samples': samples,
                      'nextURL': next,
                      'prevURL': previous,
                      'total': total_count,
                      'firstPage': reverse('samples') + '?' + urllib.urlencode(first_page_filters),
                      'lastPage': last
                 })


def sample(request, sample_id):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api
    sample = api.sample.get(sample_id).data

    location = sample['location'].split(" ")
    longtitude = location[1].replace("(","")
    latitude = location[2].replace(")","")
    loc = [longtitude, latitude]

    filter = {"sample__sample_id": sample['sample_id'], "limit": "0"}

    subsamples = api.subsample.get(params=filter).data['objects']

    aliases = api.sample_alias.get(params=filter).data['objects']
    aliases_str = [alias['alias'] for alias in aliases]

    regions = [region['name'] for region in sample['regions']]
    metamorphic_regions = [metamorphic_region['name'] for metamorphic_region in sample['metamorphic_regions']]
    metamorphic_grades = [metamorphic_grade['name'] for metamorphic_grade in sample['metamorphic_grades']]
    references = [reference['name'] for reference in sample['references']]
    minerals = [mineral['name'] for mineral in sample['minerals']]

    if sample:
        return render(request, 'sample.html',
                     {'sample':sample,
                      'location': loc,
                      'minerals': (', ').join(minerals),
                      'regions': (', ').join(regions),
                      'references': (', ').join(references),
                      'metamorphic_grades': (', ').join(metamorphic_grades),
                      'metamorphic_regions': (', ').join(metamorphic_regions),
                      'aliases': (', ').join(aliases_str),
                      'subsamples': subsamples})
    else:
        return HttpResponse("Sample does not Exist")


def subsamples(request):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api
    data = api.getAllSubSamples()
    subsamplelist =[]
    for subsample in data.data['objects']:
        subsamplelist.append([subsample['subsample_id'],subsample['name']] )
    return render(request,'subsamples.html', {'subsamples':subsamplelist})


def subsample(request, subsample_id):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api
    subsample = api.subsample.get(subsample_id).data
    user = api.user.get(subsample['user']['user_id']).data

    filter = {"subsample__subsample_id": subsample['subsample_id'],
              "limit": "0"}
    chemical_analyses = api.chemical_analysis.get(params=filter).data['objects']

    if subsample:
        return render(request, 'subsample.html',
                      {'subsample': subsample,
                       'user':user,
                       'chemical_analyses': chemical_analyses,
                       'sample_id': subsample['sample'].split('/')[-2]})
    else:
        return HttpResponse("Subsample does not Exist")



def chemical_analyses(request):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api

    filters = ast.literal_eval(json.dumps(request.GET))
    offset = request.GET.get('offset', 0)
    filters['offset'] = offset

    data = api.chemical_analysis.get(params=filters)
    next, previous, last, total_count = paginate_model('chemical_analyses',
                                                        data, filters)
    chemical_analyses = data.data['objects']

    first_page_filters = filters
    del first_page_filters['offset']

    return render(request,'chemical_analyses.html',
                 {'chemical_analyses': chemical_analyses,
                  'nextURL': next,
                  'prevURL': previous,
                  'total': total_count,
                  'firstPage': reverse('chemical_analyses') + '?' + urllib.urlencode(first_page_filters),
                  'lastPage': last})


def chemical_analysis(request, chemical_analysis_id):
    email = request.COOKIES.get('email', None)
    api_key = request.COOKIES.get('api_key', None)
    api = MetPet(email, api_key).api

    chem_analysis =ChemicalAnalysisObject(chemical_analysis_id)
    chem_analysis_obj = api.chemical_analysis.get(chemical_analysis_id).data

    subsample = api.subsample.get_by_uri(chem_analysis_obj['subsample']).data

    if chem_analysis:
        return render(request, 'chemical_analysis.html',
                      {'chemicalanalysis':chem_analysis,
                       'subsample_id': subsample['subsample_id'],
                       'sample_id': subsample['sample'].split('/')[-2]})
    else:
        return HttpResponse("Chemical Analysis does not exist")


def user(request, user_id):
    api = MetPet(None, None).api
    user = api.user.get(user_id).data
    if sample:
        return render(request, 'user.html', { 'user': user })
    else:
        return HttpResponse("User does not Exist")


def sample_images(request, sample_id):
    sampleimagesobj = SampleImagesObject(sample_id)

    if sampleimagesobj.exists():
        return HttpResponse(sampleimagesobj.json())
    else:
        return HttpResponse("Sample does not Exist")



'''S2S webservice view'''
#Main faceted serach view
def metpetdb(request):

    formattype=request.GET.get('format','json')

    returntype=request.GET.get('returntype','sampleresults')

    rocktype_id=request.GET.get('rocktype_id','')

    country=request.GET.get('country','')

    owner_id=request.GET.get('owner_id','')

    mineral_id=request.GET.get('mineral_id','')

    region_id=request.GET.get('region_id','')

    metamorphic_grade_id=request.GET.get('metamorphic_grade_id','')

    metamorphic_region_id=request.GET.get('metamorphic_region_id','')

    publication_id= request.GET.get('publication_id','')

    if rocktype_id!='':
        rocktype_id_list=rocktype_id.split(',')
    else:
        rocktype_id_list=[]

    if mineral_id!='':
        mineral_id_list=mineral_id.split(',')
    else:
        mineral_id_list=[]

    if owner_id!='':
        owner_id_list=owner_id.split(',')
    else:
        owner_id_list=[]

    if country!='':
        country_list=country.split(',')
    else:
        country_list=[]

    if region_id!='':
        region_id_list=region_id.split(',')
    else:
        region_id_list=[]

    if metamorphic_region_id!='':
        metamorphic_region_id_list=metamorphic_region_id.split(',')
    else:
        metamorphic_region_id_list=[]

    if metamorphic_grade_id!='':
        metamorphic_grade_id_list=metamorphic_grade_id.split(',')
    else:
        metamorphic_grade_id_list=[]

    if publication_id!='':
        publication_id_list=publication_id.split(',')
    else:
        publication_id_list=[]


    samples=SampleQuery(rock_type=rocktype_id_list,country=country_list,owner_id=owner_id_list,mineral_id=mineral_id_list,region_id=region_id_list,metamorphic_grade_id=metamorphic_grade_id_list, metamorphic_region_id=metamorphic_region_id_list, publication_id=publication_id_list)
    #sample_test = SampleQuery(rock_type=[3,], country=[], owner_id=[139,], mineral_id=[3,], region_id=[52,], metamorphic_grade_id=[17,], metamorphic_region_id=[], publication_id=[])
    if returntype=='rocktype_facet':
        return HttpResponse(getFacetJSON(samples.rock_type_facet()), content_type="application/json")
    elif returntype=='country_facet':
        return HttpResponse(getFacetJSON(samples.country_facet()), content_type="application/json")
    elif returntype=='mineral_facet':
        return HttpResponse(getFacetJSON(samples.mineral_facet()), content_type="application/json")
    elif returntype=='region_facet':
        return HttpResponse(getFacetJSON(samples.region_facet()), content_type="application/json")
    elif returntype=='owner_facet':
        return HttpResponse(getFacetJSON(samples.owner_facet()), content_type="application/json")
    elif returntype=='metamorphicgrade_facet':
        return HttpResponse(getFacetJSON(samples.metamorphic_grade_facet()), content_type="application/json")
    elif returntype=='metamorphicregion_facet':
        return HttpResponse(getFacetJSON(samples.metamorphic_region_facet()), content_type="application/json")
    elif returntype== 'publication_facet':
        return HttpResponse(getFacetJSON(samples.publication_facet()), content_type="application/json")
    elif returntype=='map':
        #q=test.get_main_brief()
        return HttpResponse(getAllJSON(samples.get_main_brief()), content_type="application/json")
    else:
        cursor=con.cursor()
        cursor.execute(samples.get_count())
        sample_count=cursor.fetchall()
        #this is currently a hack to pass a html element containing the sample_count
        htmlCount="<div id='sampleCount' display:'none'>"+str(sample_count[0][0])+"</div>"
        print htmlCount
        if sample_count>500:
            return HttpResponse(getSampleResults(samples.get_main(500))+htmlCount)
        else:
            return HttpResponse(getSampleResults(samples.get_main(500)))

#Not sure if below is used for anything right now
#Function to format oxides by subscripting digits
def formatOxide(species):
        retStr=""
        i=0
        while(i<len(species)):
                if species[i].isdigit():
                        retStr+='<sub>'+species[i]+'</sub>'
                else:
                        retStr+=species[i]
                i+=1
        return retStr
