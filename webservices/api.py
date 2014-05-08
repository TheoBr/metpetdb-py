from django.http import HttpResponse
from webservices.sample import SampleObject
from webservices.subsample import SubsampleObject, SubsampleImagesTableObject, SubsampleTableObject
from webservices.chemicalanalysis import ChemicalAnalysisObject, ChemicalAnalysisTableObject
        
def sample(request, sample_id):
    sampleObj = SampleObject(sample_id)
    return HttpResponse(sampleObj.json())
    
def subsample(request, subsample_id):
    subsampleObj = SubsampleObject(subsample_id)
    return HttpResponse(subsampleObj.json())

def subsample_images(request, subsample_id):
    subsampleImagesTableObj = SubsampleImagesTableObject(subsample_id)
    return HttpResponse(subsampleImagesTableObj.json())
    
def subsamples(request, sample_id):
    subsampleTableObj = SubsampleTableObject(sample_id)
    return HttpResponse(subsampleTableObj.json())

def chemical_analysis(request, chemical_analysis_id):
    chemicalAnalysisObj = ChemicalAnalysisObject(chemical_analysis_id)
    return HttpResponse(chemicalAnalysisObj.json())
    
def chemical_analyses(request, subsample_id):
    chemicalAnalysisTableObj = ChemicalAnalysisTableObject(subsample_id)
    return HttpResponse(chemicalAnalysisTableObj.json())