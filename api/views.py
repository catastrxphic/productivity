from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import TaskSerializer
from .models import Task
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer

@api_view(['GET'])
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
    return Response(routes)

@api_view(['GET'])
def getTasks(request):
    tasks = Task.objects.all()
    serializer = TaskSerializer(tasks, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getTask(request, pk):
    task = Task.objects.get(id=pk)
    serializer = TaskSerializer(task, many=False)
    return Response(serializer.data)


@api_view(['POST'])
def createTask(request):
    data = request.data

    task = Task.objects.create(
        body = data['body']
    )
    serializer = TaskSerializer(task, many=False)

    return Response(serializer.data)

@api_view(['PUT'])
def updateTask(request, pk):
    data = request.data

    task = Task.objects.get(id=pk)
    serializer = TaskSerializer(task, data= request.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)
    
@api_view(['DELETE'])
def deleteTask(request, pk):
    task = Task.objects.get(id=pk)
    task.delete()
    return Response("Task was deleted")
