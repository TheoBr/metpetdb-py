import sys
import logging
import pprint
import json
import drest

def main(argv):
    print(argv)
    resource_name = argv[0]
    env = argv[1]
    pp = pprint.PrettyPrinter(indent=2)

    with open('data.json') as data_file:
        data = json.load(data_file)

    api = drest.api.TastyPieAPI(data['environments'][argv[1]]['url'])
    api.auth(user=data['environments'][argv[1]]['user'],
             api_key=data['environments'][argv[1]]['api_key'])

    print("###########################################################")
    print("Username: " + 'watera2@cs.rpi.edu')
    print("###########################################################")
    print('\n')

    api_resource = getattr(api, resource_name)

    print("###########################################################")
    print("Start POST request for creating a " + resource_name + " object")
    print("-----------------------------------------------------------")

    response = api_resource.post(data[resource_name + '_post_data'])
    resource_id = response.data[resource_name + '_id']
    if response.status == 201:
        print("POST request was successful")

    pp.pprint(response.headers)

    print("-----------------------------------------------------------")
    print("Complete POST request for creating a " + resource_name + " object")
    print("###########################################################")
    print('\n')

    print("###########################################################")
    print("Start GET request for a single " + resource_name + " object")
    print("-----------------------------------------------------------")

    response = api_resource.get(resource_id)
    if response.status == 200:
        print('GET request was successful')
    pp.pprint(response.data)

    print("-----------------------------------------------------------")
    print("Complete GET request for a single " + resource_name + " object")
    print("###########################################################")
    print('\n')


    print("###########################################################")
    print("Start PUT request for a single " + resource_name + " object")
    print("-----------------------------------------------------------")

    if resource_name == 'sample':
        response.data['description'] = 'Updated sample'
        response = api_resource.put(resource_id, response.data)
    elif resource_name == 'subsample':
        response.data['grid_id'] = 2
        response.data['name'] = data[resource_name + '_put_data']['name']
        response = api_resource.put(resource_id, response.data)
    elif resource_name == 'chemical_analysis':
        response.data['large_rock'] = 'N'
        response = api_resource.put(resource_id, response.data)

    pp.pprint(response.data)

    print("-----------------------------------------------------------")
    print("Complete PUT request for a single " + resource_name + " object")
    print("###########################################################")
    print('\n')


    print("###########################################################")
    print("Start DELETE request for deleting a " + resource_name + " object")
    print("-----------------------------------------------------------")

    response = api_resource.delete(resource_id)
    print(response.status)

    print("-----------------------------------------------------------")
    print("Complete DELETE request for deleting a " + resource_name + " object")
    print("###########################################################")
    print('\n')


if __name__ == "__main__":
    main(sys.argv[1:])
