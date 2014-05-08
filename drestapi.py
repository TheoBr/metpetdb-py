import drest
import json

class MetPet(object):
  api = drest.api.TastyPieAPI('http://localhost:8000/tastyapi/v1/')
  username = "westp"
  api_key = "c"
  api.auth(username, api_key)
  data = {
    'sample_id': 189,
      'version': 2,
      'user': '/tastyapi/v1/user/85/',
      'sesar_number': '1434a',
      'public_data': 'Y',
      'date_precision': 1,
      'number': 'NL-67:2005-36290',
      'rock_type': '/tastyapi/v1/rock_type/16/',
      'regions': ['Pune', 'Mumbai', 'Pune', 'Hyderabad'],
      'references': ['2004-061314',
                     '2004-065494',
                     '2004-065494'],
      'metamorphic_grades': ['/tastyapi/v1/metamorphic_grade/1/',
                             '/tastyapi/v1/metamorphic_grade/2/',
                             '/tastyapi/v1/metamorphic_grade/3/',
                             '/tastyapi/v1/metamorphic_grade/4/'],
      'metamorphic_regions': ['/tastyapi/v1/metamorphic_region/427/',
                             '/tastyapi/v1/metamorphic_region/428/',
                             '/tastyapi/v1/metamorphic_region/429/',
                             '/tastyapi/v1/metamorphic_region/430/'],
      'minerals': ['/tastyapi/v1/mineral/1/',
                   '/tastyapi/v1/mineral/2/',
                   '/tastyapi/v1/mineral/3/',
                   '/tastyapi/v1/mineral/4/'],
      'description': 'Created by a test case',
      'location_error': 2000,
      'country': 'Brazil',
      'location_text': 'amfadf',
      'location': 'POINT (-49.3400382995604971 -16.5187797546387003)'
  }

  rock = {
    "rock_type_id": 233,
    "rock_type": "HELLO"
  }
  def __intit__(self, user, api):
    self.username = user
    self.api_key = api

  def getSample(self, id):
    return api.sample.get(id).data

  # def getAllSamples(self):
  #   return api.sample.get().data

  def createSample(self, data):
    pass

  def updateSample(self, id):
    pass

  def deleteSample(self, id):
    pass

  def getSubSample(self, id):
    pass

  def createSubSample(self):
    pass

  def updateSubSample(self, id):
    pass

  def deleteSubSample(self, id):
    pass

  def getChemicalAnalysis(self):
    pass

  def createChemicalAnalysis(self):
    pass

  def updateChemicalAnalysis(self, id):
    pass

  def deleteChemicalAnalysis(self, id):
    pass

#Calls
# print "ROCKTYPE ID: 555"
# print api.rock_type.get(555).status

# print api.sample.post(data)

# print api.rock_type.post(rock)