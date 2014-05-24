from django.core.urlresolvers import reverse
from django.http import HttpResponse, HttpResponseRedirect
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
    #TODO: Authenticate logged-in users against the API
    #Lists for filtering in search
    region_list = []
    collector_list = []
    reference_list = []
    metamorphic_region_list = []
    all_regions = Region.objects.all().order_by("name")
    all_samples = Sample.objects.all().order_by("collector")
    all_references = Reference.objects.all().order_by("name")
    all_metamorphic_regions = MetamorphicRegion.objects.all().order_by("name")
    #Populate lists
    for region in all_regions:
        region_list.append(region.name)
    for sample in all_samples:
        if sample.collector and sample.collector not in collector_list:
            collector_list.append(unicode(sample.collector))
    for ref in all_references:
        reference_list.append(ref.name)
    for mmr in all_metamorphic_regions:
        metamorphic_region_list.append(mmr.name)

    search_terms = {}
    error = False
    #Loop through search terms from search GET request in search form
    #Prepare dictionary of filters for api request
    for k,v in request.GET.iterlists():
        for listitem in v:
            if k:
                if k != 'resource':
                    search_terms[k] = []
                    search_terms[k].append(listitem)
    #Temporary credentials for api
    api = MetPet(None, None)
    #determine what resource to search for
    if search_terms:
        if request.GET['resource'] == 'sample':
            data = api.searchSamples(filters=dict(request.GET.iterlists()))
            search_results = data.data['objects']
            return render(request, 'search_results.html',
                {'samples': search_results, 'query': ''})
        if request.GET['resource'] == 'chemicalanalysis':
            #search for chemical analyses
            data = api.searchChemicals(filters=dict(request.GET.iterlists()))
            search_results = data.data['objects']
            return render(request, 'search_results.html',
                {'chemicals': search_results, 'query': ''})
    else:
        # data = api.searchSamples()
        return render(request, 'search_form.html',
            {'samples': [], 'query': '', 'regions':region_list,
             'provenenances': collector_list, "references": reference_list,
              "mmrs": metamorphic_region_list})
    return render(request, 'search_form.html', {'error': error})


def samples(request):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None).api
    offset = request.GET.get('offset', 0)
    data = api.sample.get(params={'offset': offset})

    next, previous = None, None
    if data.data['meta']['next']:
        next_offset = int(offset) + 20
        next = reverse('samples') + '?' + 'offset={0}'.format(next_offset)
    if data.data['meta']['previous']:
        prev_offset = int(offset) - 20
        previous = reverse('samples') + '?' + 'offset={0}'.format(prev_offset)

    total_count = data.data['meta']['total_count']
    last = reverse('samples') + '?' + 'offset={0}'.format(total_count -
                                                          total_count%20)

    samplelist =[]
    for sample in data.data['objects']:
        samplelist.append([sample['sample_id'],sample['number']] )

    return render(request,
                 'samples.html',
                 {
                      'samples':samplelist,
                      'nextURL': next,
                      'prevURL': previous,
                      'total': total_count,
                      'firstPage': reverse('samples'),
                      'lastPage': last
                 })


def sample(request, sample_id):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None).api
    sample = api.sample.get(sample_id).data
    user = api.user.get(sample['user'].split("/")[-2]).data

    location = sample['location'].split(" ")
    longtitude = location[1].replace("(","")
    latitude = location[2].replace(")","")
    loc = [longtitude, latitude]

    subsamples_filter = {"sample__sample_id": sample['sample_id'], "limit": "0"}
    subsamples_data = api.subsample.get(params=subsamples_filter)

    if sample:
        return render(request, 'sample.html',{'sample':sample, 'user':user,
            'location': loc, 'subsamples': subsamples_data.data['objects']})
    else:
        return HttpResponse("Sample does not Exist")


def subsamples(request):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None)
    data = api.getAllSubSamples()
    subsamplelist =[]
    # print dir(samplelist)
    for subsample in data.data['objects']:
        # print sample['sample_id']
        subsamplelist.append([subsample['subsample_id'],subsample['name']] )
    return render(request,'subsamples.html', {'subsamples':subsamplelist})


def subsample(request, subsample_id):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None).api
    subsample = api.subsample.get(subsample_id).data
    user = api.user.get(subsample['user']['user_id']).data
    if subsample:
        return render(request, 'subsample.html',{'subsample': subsample, 'user':user})
    else:
        return HttpResponse("Subsample does not Exist")


def chemical_analyses(request):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None)
    data = api.getAllChemicalAnalysis()
    chemicallist =[]
    for chemical in data.data['objects']:
        chemicallist.append([chemical['chemical_analysis_id'],
                            chemical['where_done']] )
    return render(request,'chemical_analyses.html', {'chemicals':chemicallist})


def chemical_analysis(request, chemical_analysis_id):
    #TODO: Authenticate logged-in users against the API
    chemanalysisobj =ChemicalAnalysisObject(chemical_analysis_id)
    if chemanalysisobj.exists():
        return render(request, 'chemical_analysis.html',{'chemicalanalysis':chemanalysisobj,})
    else:
        return HttpResponse("Chemical Analysis does not exist")


def user(request, user_id):
    #TODO: Authenticate logged-in users against the API
    api = MetPet(None, None).api
    user = api.user.get(user_id).data
    if sample:
        return render(request, 'user.html', { 'user': user })
    else:
        return HttpResponse("User does not Exist")


def sample_images(request, sample_id):
    #TODO: Authenticate logged-in users against the API
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
