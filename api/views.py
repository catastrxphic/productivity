from django.http import JsonResponse


def getRoutes(request):

    routes = [
        {
            'Endpoint': '/blissfullden/',
            'method': 'GET',
            'body': None,
            'description': "Returns an array of notes"
        },
        {
            'Endpoint': '/blissfullden/id/',
            'method': 'GET',
            'body': None,
            'description': "Returns a single note"
        },
        {
            'Endpoint': '/blissfullden/create/',
            'method': 'POST',
            'body': {'Body': ""},
            'description': "Creates a new note with data sent in post request"
        },
        {
            'Endpoint': '/blissfullden/id/update/',
            'method': 'PUT',
            'body': {'Body':""},
            'description': "Creates an existing note with data sent in put"
        },
        {
            'Endpoint': '/blissfullden/id/delete/',
            'method': 'DELETE',
            'body': None,
            'description': "Deletes and existing note"
        }
    ]

    return JsonResponse(routes, safe=False)