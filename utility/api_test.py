import sys
import pprint
import json
import drest

def main(argv):
    print(argv)
    resource_name = argv[0]
    pp = pprint.PrettyPrinter(indent=2)

    with open('request_data.json') as data_file:
        data = json.load(data_file)

    env = data[argv[1]]

    api = drest.api.TastyPieAPI(env['url'])
    api.auth(user=env['user'],
             api_key=env['api_key'])


    api_resource = getattr(api, resource_name)

    print("###########################################################")
    print("Start POST request for creating a " + resource_name + " object")
    print("-----------------------------------------------------------")

    response = api_resource.post(env[resource_name + '_post_data'])
    resource_id = response.data[resource_name + '_id']
    pp.pprint(response.headers)

    print("-----------------------------------------------------------")
    print("Complete POST request for creating a " + resource_name + " object")
    print("###########################################################")
    print('\n')

    print("###########################################################")
    print("Start GET request for a single " + resource_name + " object")
    print("-----------------------------------------------------------")

    response = api_resource.get(resource_id)
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
        response.data['name'] = env[resource_name + '_put_data']['name']
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
