from django.db import connection as con
from webservices.util import dictfetchone, dictfetchall, CustomJSONEncoder
import json, ast
import drest
from getenv import env


#Custom Class that acts as a wrapper around the drest Framework
class MetPet():
  #Initialization variables should be set according to production server
  def __init__(self, user, api):
    self.username = user
    self.api_key = api
    self.api = drest.api.TastyPieAPI('{0}/api/v1/'.format(env('HOST_NAME')))
    if self.username:
      self.api.auth(user, api)

  def searchSamples(self, filters={}, nextpage=''):
    if filters:
      filter_dictionary = {}
      for k in filters:
        if filters[k][0]:
          if k != "resource":
            filter_dictionary[k] = ",".join(filters[k])
      filter_dictionary = ast.literal_eval(json.dumps(filter_dictionary))
      response = self.api.sample.get(params=filter_dictionary)
      return response
    else:
      response = self.api.sample.get()
      return response

  def searchChemicals(self, filters={}, nextpage=''):
    if nextpage:
      self.api = drest.api.TastyPieAPI('{0}{1}'.format(env('HOST_NAME'), nextpage))
    if filters:
      response = self.api.chemical_analysis.get(params=filters)
      return response
    else:
      response = self.api.chemical_analysis.get()
      return response

  def searchSubsamples(self, filters={}):
    if filters:
      response = self.api.subsample.get(params=filters)
    return response


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

        if (self.oneQuery and "error" not in data and self.manyQueries) or\
           (self.oneQuery is None and self.manyQueries):
            for item, query in self.manyQueries.iteritems():
                cursor.execute(query, conditions)
                data[item] = dictfetchall(cursor)
        return data
