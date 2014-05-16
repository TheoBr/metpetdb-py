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
from getenv import env



#direct stdout to stderr so that it is logged by the webserver
sys.stdout = sys.stderr

#Main interface view
def index(request):
	return render(request, 'homepage.html')

#Request to serve search.html
def search(request):
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
	username = env('API_USER')
	api_key = env('API_KEY')
	api = MetPet(username,api_key)
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


#Pagination function that could use a better implementation
#This function handles the previous link for pagination
def previous(request, pagenum=1, optional=''):
	pagenum = int(pagenum) - 40
	#Temporary User (may be different on production)
	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	user = env('API_USER')
	api_key = env('API_KEY')
	#More than 20 reources were found
	if pagenum > 1:
		data = api.getAllSamples(pagenum, user, api_key)
	else:
		data = api.getAllSamples()
	nextlist = data.data['meta']['next']
	samplelist =[]
	offsets = []
	total_count = data.data['meta']['total_count']
	for sample in data.data['objects']:
		samplelist.append([sample['sample_id'],sample['number']] )
	#CREATE PAGINATION
	if total_count > 20:
		pages = total_count / 20
	for x in range(0,pages):
		offsets.append(x*20)
	pagenum = int(nextlist.split('=')[-1])
	pageprev = pagenum - 20

	return render(request,'samplelist.html', {'samples':samplelist,
	 			  'nextURL': nextlist, 'total': total_count,
	 			  'offsets': offsets, 'pagenum':pagenum, 'pageprev': pageprev})
#List all samples
def samplelist(request, pagenum=1):
	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	user = env('API_USER')
	api_key = env('API_KEY')
	if pagenum > 1:
		data = api.getAllSamples(pagenum, user, api_key)
	else:
		data = api.getAllSamples()
	nextlist = data.data['meta']['next']
	samplelist =[]
	offsets = []
	total_count = data.data['meta']['total_count']
	for sample in data.data['objects']:
		print sample['sample_id']
		samplelist.append([sample['sample_id'],sample['number']] )
	#CREATE PAGINATION
	if total_count > 20:
		pages = total_count / 20
	for x in range(0,pages):
		offsets.append(x*20)
	pagenum = int(nextlist.split('=')[-1])
	pageprev = pagenum - 20
	return render(request,'samplelist.html', {'samples':samplelist,
				 'nextURL': nextlist, 'total': total_count, 'offsets': offsets,
				 'pagenum': pagenum, 'pageprev': pageprev})

def prevsamplelist(request, pagenum=1):
	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	user = env('API_USER')
	api_key = env('API_KEY')
	if pagenum > 1:
		pagenum -= 20
		data = api.getAllSamples(pagenum, user, api_key)
	else:
		data = api.getAllSamples()
	nextlist = data.data['meta']['next']
	samplelist =[]
	offsets = []
	total_count = data.data['meta']['total_count']
	for sample in data.data['objects']:
		print sample['sample_id']
		samplelist.append([sample['sample_id'],sample['number']] )
	#CREATE PAGINATION
	if total_count > 20:
		pages = total_count / 20
	for x in range(0,pages):
		offsets.append(x*20)
	pagenum = int(nextlist.split('=')[-1])
	pageprev = pagenum - 20
	return render(request,'samplelist.html', {'samples':samplelist,
	 			  'nextURL': nextlist, 'total': total_count,
	 			  'offsets': offsets, 'pagenum':pagenum, 'pageprev': pageprev})

def chemical_analysislist(request):
	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	data = api.getAllChemicalAnalysis()
	chemicallist =[]
	for chemical in data.data['objects']:
		chemicallist.append([chemical['chemical_analysis_id'], 
							chemical['where_done']] )
	return render(request,'chemicalanalysislist.html', {'chemicals':chemicallist})


def subsamplelist(request):
	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	data = api.getAllSubSamples()
	subsamplelist =[]
	# print dir(samplelist)
	for subsample in data.data['objects']:
		# print sample['sample_id']
		subsamplelist.append([subsample['subsample_id'],subsample['name']] )
	return render(request,'subsamplelist.html', {'subsamples':subsamplelist})

# view function renders sampleview.html
def sample(request, sample_id):

	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	sampleobj = api.getSample(sample_id).data
	sampleuser = api.getUserByURI(sampleobj['user']).data
	location = sampleobj['location']
	location = location.split(" ")
	longtitude = location[1].replace("(","")
	latitude = location[2].replace(")","")
	loc = [longtitude, latitude]
	samplelist = []
	filters = {"sample__sample_id": sampleobj["sample_id"], "limit": "0"}
	data = api.searchSamples(filters)
	subsamples = []
	subsamples_filter = {"sample__sample_id": sampleobj['sample_id'], "limit": "0"}
	subsamples_data = api.searchSubsamples(subsamples_filter)
	for sample in data.data['objects']:
		samplelist.append([sample['sample_id'], sample['public_data']])
	if sampleobj:
		print sampleobj
		return render(request, 'sampleview.html',{'sample':sampleobj, 
			'samples': samplelist,'user':sampleuser, 
			'location': loc, 'subsamples': subsamples_data.data['objects']})
	else:
		return HttpResponse("Sample does not Exist")

# List Subsamples
def subsample(request, subsample_id):

	api = MetPet(env('API_USER'),
				 env('API_KEY'))
	subsampleobj = api.getSubSample(subsample_id).data
	subsampleuser = api.getUserByURI(subsampleobj['user']).data
	if subsampleobj:
		return render(request, 'subsampleview.html',{'subsample': subsampleobj, 'user':subsampleuser})
	else:
		return HttpResponse("Subsample does not Exist")



# view function renders chemanalysisview.html/json data depending on the request
def chemicalanalysis(request, chemical_analysis_id):


	chemanalysisobj =ChemicalAnalysisObject(chemical_analysis_id)
	if chemanalysisobj.exists():
		return render(request, 'chemicalanalysisview.html',{'chemicalanalysis':chemanalysisobj,}) 
	else:
		return HttpResponse("Chemical Analysis does not exist")


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


def samples(request):
	samples_data=[]
	samples=Samples.objects.filter(public_data='Y')|Samples.objects.filter(user_id='139')
	i=0
	for sample in samples:
		#initialize the variables
		sample_data={}
		sample_latlon=""
		sample_number=""
		sample_metamorphic_regions=[]
        	sample_country=""
        	sample_owner=""
        	sample_rock_type=""
        	sample_metamorphic_grades=[]
		sample_minerals=[]
		sample_regions=[]
		sample_reference_first_authors=[]
		sample_reference_journal_names=[]
		sample_reference_publication_years=[]
		sample_number_link=""
		sample_id=""

		#get sample id
		sample_id=sample.sample_id
		
		#get sample metamorphic regions
		samplemetamorphicregions=sample.samplemetamorphicregionsdup_set.all()
		for samplemetamorphicregion in samplemetamorphicregions:
			sample_metamorphic_regions.append(samplemetamorphicregion.metamorphic_region.name)
		
		#get lat lon from location
		
		sample_location_x=Samples.objects.raw('select sample_id,st_X(location) as geo from samples where sample_id='+str(sample.sample_id))[0].geo
		sample_location_y=Samples.objects.raw('select sample_id,st_Y(location) as geo from samples where sample_id='+str(sample.sample_id))[0].geo
		sample_latlon=str(sample_location_y)+","+str(sample_location_x)
		
		'''
		sample_latlon=Samples.objects.raw('select sample_id,substr(ST_asText(location), 7) as geo from samples where sample_id='+str(sample.sample_id))[0].geo
		sample_latlon=sample_latlon.rstrip(')')
		sample_latlon=sample_latlon.replace(' ',',')		
		'''
		
		#get sample number
		sample_number=sample.number

		#get sample country
		sample_country=sample.country
		
		#get sample owner
		sample_owner=sample.user.name

		#get sample rock type
		sample_rock_type=sample.rock_type.rock_type

		#get sample metamorphic grades
		samplemetamorphicgrades=sample.samplemetamorphicgradesdup_set.all()
		for samplemetamorphicgrade in samplemetamorphicgrades:
			sample_metamorphic_grades.append(samplemetamorphicgrade.metamorphic_grade.name)
		
		#get sample minerals
		sampleminerals=sample.samplemineralsdup_set.all()
		for samplemineral in sampleminerals:
			sample_minerals.append(samplemineral.mineral.name)

		#get sample regions
		sampleregions=sample.sampleregionsdup_set.all()
		for sampleregion in sampleregions:
			sample_regions.append(sampleregion.region.name)

		#get sample references
		samplereferences=sample.samplereferencedup_set.all()
		for samplereference in samplereferences:
			referencenumber=samplereference.reference.name
			georeferences=Georeference.objects.filter(reference_number=str(referencenumber))
			for georeference in georeferences:
				sample_reference_first_authors.append(georeference.first_author)
				sample_reference_journal_names.append(georeference.journal_name_2)
				sample_reference_publication_years.append(georeference.publication_year)
	
		#url to metpetdb
                sample_link='http://metpetdb.rpi.edu/metpetweb/#sample/'+str(sample_id)
		
		sample_data["sample_id"]=sample_id
		sample_data["label"]=sample_number
		sample_data['sample_link']=sample_link
		sample_data["sample_metamorphic_regions"]=sample_metamorphic_regions
		sample_data["sample_country"]=sample_country
		sample_data["sample_owner"]=sample_owner
		sample_data["sample_rock_type"]=sample_rock_type
		sample_data["sample_metamorphic_grades"]=sample_metamorphic_grades
		sample_data["sample_minerals"]=sample_minerals
		sample_data["sample_regions"]=sample_regions
		sample_data["sample_reference_first_authors"]=sample_reference_first_authors
		sample_data["sample_reference_journal_names"]=sample_reference_journal_names
		sample_data['sample_reference_publication_years']=sample_reference_publication_years
		sample_data["sample_latlon"]=sample_latlon
		samples_data.append(sample_data)
		
	return HttpResponse("{\"items\":"+json.dumps(samples_data)+"}")

def chemical_analyses(request):
	from django.db import connection
	chemical_analyses_data=[]
	#chemical_analyses=ChemicalAnalyses.objects.filter(public_data='Y')|ChemicalAnalyses.objects.filter(user_id='139')
	
	chemical_analyses=ChemicalAnalyses.objects.raw("select * from chemical_analyses where (public_data='Y' or user_id='139') and (large_rock='Y' or mineral_id is not null)");

	id=0
	i=0
	for chemical_analysis in chemical_analyses:
		chemical_analysis_data={}
		chemical_analysis_id=""
		chemical_analysis_large_rock=""
		chemical_analysis_count=""
		chemical_analysis_mineral_name=""
		chemical_analysis_owner=""
		chemical_analysis_rock_type=""
		chemical_analysis_metamorphic_grade=[]
		chemical_analysis_metamorphic_regions=[]
		chemical_analysis_method=""
		chemical_analysis_first_authors=[]
		chemical_analysis_publication_journal_names=[]
		chemical_analysis_publication_years=[]
		chemical_analysis_total_weight=""
		chemical_analysis_elements=[]
		chemical_analysis_oxides=[]
		chemical_analysis_latlon=""
		chemical_analysis_sample_number=""
		chemical_analysis_sample_id=""
		sample_minerals=[]

		#get chemical analysis id
		chemical_analysis_id=chemical_analysis.chemical_analysis_id

		#get chemical analysis sample id
                chemical_analysis_sample_id=chemical_analysis.subsample.sample.sample_id

		#get chemical analyses count
	        cursor=con.cursor()
        	cursor.execute('select count(chemical_analysis_id) from chemical_analyses where subsample_id='+str(chemical_analysis_sample_id))
        	row=cursor.fetchone()
		chemical_analysis_count=row[0]
		
		#get lat lon from location
                sample_location_x=Samples.objects.raw('select sample_id,st_X(location) as geo from samples where sample_id='+str(chemical_analysis_sample_id))[0].geo
                sample_location_y=Samples.objects.raw('select sample_id,st_Y(location) as geo from samples where sample_id='+str(chemical_analysis_sample_id))[0].geo
                chemical_analysis_latlon=str(sample_location_y)+","+str(sample_location_x)

		#get chemical analysis large rock
		chemical_analysis_large_rock=chemical_analysis.large_rock
		
		#get chemical analysis mineral name
		if chemical_analysis_large_rock=='Y' and chemical_analysis.mineral==None:
			chemical_analysis_mineral_name='Bulk Rock'
		elif chemical_analysis_large_rock=='N' and chemical_analysis.mineral!=None:
			chemical_analysis_mineral_name=chemical_analysis.mineral.name
		elif chemical_analysis_large_rock=='N' and chemical_analysis.mineral==None:
			chemical_analysis_mineral_name=None

		#get chemical analysis method
		chemical_analysis_method=chemical_analysis.analysis_method

		#get chemical analysis owner
		chemical_analysis_owner=chemical_analysis.user.name

		#get chemical analysis total weight
		chemical_analysis_total_weight=chemical_analysis.total

		#get chemical analysis oxides
		chemicalanalysisoxides=chemical_analysis.chemicalanalysisoxidesdup_set.all()
		for chemicalanalysisoxide in chemicalanalysisoxides:
			chemical_analysis_oxides.append(formatOxide(str(chemicalanalysisoxide.oxide.species)))
		
		#get chemical analysis elements
		chemicalanalysiselements=chemical_analysis.chemicalanalysiselementsdup_set.all()
		for chemicalanalysiselement in chemicalanalysiselements:
			chemical_analysis_elements.append(chemicalanalysiselement.element.name)

		#get chemical analysis rock type
		chemical_analysis_rock_type=chemical_analysis.subsample.sample.rock_type.rock_type
		
		#get chemical analysis metamorphic grade
		samplemetamorphicgrades=chemical_analysis.subsample.sample.samplemetamorphicgradesdup_set.all()
		for samplemetamorphicgrade in samplemetamorphicgrades:
			chemical_analysis_metamorphic_grade.append(samplemetamorphicgrade.metamorphic_grade.name)
		#get chemical analysis metamorphic regions
                samplemetamorphicregions=chemical_analysis.subsample.sample.samplemetamorphicregionsdup_set.all()
                for samplemetamorphicregion in samplemetamorphicregions:
                        chemical_analysis_metamorphic_regions.append(samplemetamorphicregion.metamorphic_region.name)
			
		#get chemical analysis references
		chemicalreferences=chemical_analysis.subsample.sample.samplereferencedup_set.all()
		for chemicalreference in chemicalreferences:
			referencenumber=chemicalreference.reference.name
			georeferences=Georeference.objects.filter(reference_number=str(referencenumber))
			for georeference in georeferences:
				chemical_analysis_first_authors.append(georeference.first_author)
				chemical_analysis_publication_journal_names.append(georeference.journal_name_2)
				chemical_analysis_publication_years.append(georeference.publication_year)
		
		#get chemical analysis sample number
		chemical_analysis_sample_number=chemical_analysis.subsample.sample.number

		#get sample minerals
		sampleminerals=SampleMineralsDup.objects.raw('select * from sample_minerals_dup where sample_id='+str(chemical_analysis_sample_id))
		for samplemineral in sampleminerals:
                        sample_minerals.append(samplemineral.mineral.name)


		#url to metpetdb
		chemical_analysis_link="http://metpetdb.rpi.edu/metpetweb/#sample/"+str(chemical_analysis_sample_id)

		chemical_analysis_data['chemical_analysis_id']=chemical_analysis_id
		chemical_analysis_data['sample_id']=chemical_analysis_sample_id
		chemical_analysis_data['label']=chemical_analysis_sample_number
		chemical_analysis_data['chemical_analysis_link']=chemical_analysis_link
		chemical_analysis_data['chemical_analysis_count']=chemical_analysis_count
		chemical_analysis_data['chemical_analysis_latlon']=chemical_analysis_latlon
		chemical_analysis_data['chemical_analysis_large_rock']=chemical_analysis_large_rock
		chemical_analysis_data['chemical_analysis_mineral_name']=chemical_analysis_mineral_name
		chemical_analysis_data['chemical_analysis_method']=chemical_analysis_method
		chemical_analysis_data['chemical_analysis_owner']=chemical_analysis_owner
		chemical_analysis_data['chemical_analysis_total_weight']=chemical_analysis_total_weight
		chemical_analysis_data['chemical_analysis_oxides']=chemical_analysis_oxides
		chemical_analysis_data['chemical_analysis_elements']=chemical_analysis_elements
		chemical_analysis_data['chemical_analysis_rock_type']=chemical_analysis_rock_type
		chemical_analysis_data['chemical_analysis_metamorphic_grade']=chemical_analysis_metamorphic_grade
		chemical_analysis_data['chemical_analysis_metamorphic_regions']=chemical_analysis_metamorphic_regions
		chemical_analysis_data['chemical_analysis_first_authors']=chemical_analysis_first_authors
		chemical_analysis_data['chemical_analysis_publication_journal_names']=chemical_analysis_publication_journal_names
		chemical_analysis_data['chemical_analysis_publication_years']=chemical_analysis_publication_years
		chemical_analysis_data['chemical_analysis_sample_minerals']=sample_minerals
		chemical_analyses_data.append(chemical_analysis_data)

	return HttpResponse("{\"items\":"+json.dumps(chemical_analyses_data)+"}")



	
			
