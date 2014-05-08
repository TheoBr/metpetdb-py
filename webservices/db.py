from django.db import connection as con
from webservices.util import dictfetchone, dictfetchall, CustomJSONEncoder
import json
import drest

class MetPet():
  # api = drest.API('http://localhost:8000/tastyapi/v1/')
  # username = "westp"
  # api_key = "c"
  # api.auth(username, api_key)
  
  # data = {
  #   'sample_id': 189,
  #     'version': 2,
  #     'user': '/tastyapi/v1/user/85/',
  #     'sesar_number': '1434a',
  #     'public_data': 'Y',
  #     'date_precision': 1,
  #     'number': 'NL-67:2005-36290',
  #     'rock_type': '/tastyapi/v1/rock_type/16/',
  #     'regions': ['Pune', 'Mumbai', 'Pune', 'Hyderabad'],
  #     'references': ['2004-061314',
  #                    '2004-065494',
  #                    '2004-065494'],
  #     'metamorphic_grades': ['/tastyapi/v1/metamorphic_grade/1/',
  #                            '/tastyapi/v1/metamorphic_grade/2/',
  #                            '/tastyapi/v1/metamorphic_grade/3/',
  #                            '/tastyapi/v1/metamorphic_grade/4/'],
  #     'metamorphic_regions': ['/tastyapi/v1/metamorphic_region/427/',
  #                            '/tastyapi/v1/metamorphic_region/428/',
  #                            '/tastyapi/v1/metamorphic_region/429/',
  #                            '/tastyapi/v1/metamorphic_region/430/'],
  #     'minerals': ['/tastyapi/v1/mineral/1/',
  #                  '/tastyapi/v1/mineral/2/',
  #                  '/tastyapi/v1/mineral/3/',
  #                  '/tastyapi/v1/mineral/4/'],
  #     'description': 'Created by a test case',
  #     'location_error': 2000,
  #     'country': 'Brazil',
  #     'location_text': 'amfadf',
  #     'location': 'POINT (-49.3400382995604971 -16.5187797546387003)'
  # }

  # rock = {
  #   "rock_type_id": 233,
  #   "rock_type": "HELLO"
  # }
  def __init__(self, user, api):
    self.username = user
    self.api_key = api
    self.api = drest.api.TastyPieAPI('http://localhost:8000/api/v1/')
    self.api.auth(user, api)
  def getSample(self, id):
    response = self.api.sample.get(id)
    return self.api.sample.get(id)


  def getAllSamples(self, nextpage=0, user='', api_key=''):
    if nextpage:
      self.api = drest.api.TastyPieAPI('http://localhost:8000/api/v1/')
      # offset_filter = ''
      # print filters
      # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
      response = self.api.sample.get(params=dict(limit=20, offset=nextpage, username=user, api_key=api_key))
      return response
    else:
      response = self.api.sample.get()
      return response
  def searchSamples(self, filters={}, nextpage=''):
    if filters:
      print filters
      # filters['offset'] = nextpage
      # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
      response = self.api.sample.get(params=filters)
      return response
    else:
      response = self.api.sample.get()
      return response
  def searchChemicals(self, filters={}, nextpage=''):
    if nextpage:
      self.api = drest.api.TastyPieAPI('http://localhost:8000{0}'.format(nextpage))
    if filters:
      print filters
      # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
      response = self.api.chemical_analysis.get(params=filters)
      return response
    else:
      response = self.api.chemical_analysis.get()
      return response

  def searchSubsamples(self, filters={}):
    if filters:
      response = self.api.subsample.get(params=filters)
    return response

  # def searchSamples(self, user='', api_key=''):
  # #   if nextpage:
  # #     self.api = drest.api.TastyPieAPI('http://localhost:8000/api/v1/')
  # #     # offset_filter = ''
  # #     # print filters
  # #     # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
  # #     response = self.api.sample.get(params=dict(limit=20, offset=nextpage, username=user, api_key=api_key))
  # #     return response
  # #   else:
  # #     response = self.api.sample.get()
  # #     return response
  # # def searchSamples(self, filters={}, nextpage=''):
  # #   if nextpage:
  # #     self.api = drest.api.TastyPieAPI('http://localhost:8000{0}'.format(nextpage))
  # #   if filters:
  # #     print filters
  # #     # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
  # #     response = self.api.sample.get(params=filters)
  # #     return response
  # #   else:
  # #     response = self.api.sample.get()
  # #     return response
  #   pass

  def createSample(self, data):
    response = self.api.sample.post(data)
    return response

  def updateSample(self, id, data):
    response = self.api.sample.put(id, data)
    return response

  def deleteSample(self, id):
    response = self.api.sample.delete(id)
    return response

  def getAllSubSamples(self):
    # self.api.add_resource('sample')
    response = self.api.subsample.get()
    return response

  def getSubSample(self, id):
    response = self.api.subsample.get(id)
    return response

  def createSubSample(self):
    response = self.api.subsample.post(id)
    return response    

  def updateSubSample(self, id, data):
    response = self.api.subsample.put(id, data)
    return response

  def deleteSubSample(self, id):
    response = self.api.subsample.delete(id)
    return response

  def getChemicalAnalysis(self, id):
    response = self.api.chemical_analysis.get(id)
    return response

  def getAllChemicalAnalysis(self, filters={}):
    if filters:
      print filters
      # filters = {u'collection_date': u'', u'region': u'', u'sesar': u'', u'version': u'1', u'public': u'', u'rock_type': u''}
      response = self.api.chemical_analysis.get(params=filters)
      return response
    else:
      response = self.api.chemical_analysis.get()
      return response

  def createChemicalAnalysis(self, data):
    response = self.api.chemical_analysis.post(data)
    return response

  def updateChemicalAnalysis(self, id, data):
    response = self.api.chemical_analysis.put(id, data)
    return response

  def deleteChemicalAnalysis(self, id):
    response = self.api.chemical_analysis.delete(id)
    return response

  def getUserByURI(self, uri):
    entities = uri.split("/")
    response = self.api.user.get(entities[-2])
    return response

  def getUserByID(self, id):
    response = self.api.user.get(id)
    return response

class _DbObject(object):
    attributes = {}

    getQuery = None
    
    def _get(self, conditions):
        self.attributes = self.getQuery.execute(conditions)
        return self.exists()
    
    def exists(self):
        raise NotImplementedError("Should have implemented this")
        
    def json(self):
        return json.dumps(self.attributes, cls=CustomJSONEncoder)

class _DbGetQuery(object):
    oneQuery = None
    manyQueries = None

    def __init__(self):
        raise NotImplementedError("Should have implemented this")

    def execute(self, conditions):
        data = {}
        cursor = con.cursor()

        if self.oneQuery:
            cursor.execute(self.oneQuery, conditions)
            data = dictfetchone(cursor)
        
        if (self.oneQuery and "error" not in data and self.manyQueries) or (self.oneQuery is None and self.manyQueries):
            for item, query in self.manyQueries.iteritems():
                cursor.execute(query, conditions)
                data[item] = dictfetchall(cursor)
        
        return data
