from django.shortcuts import get_object_or_404
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import TaskSerializer
from .models import Task

from rest_framework.authtoken.models import Token
from .serializers import UserSerializer
from rest_framework import status
from django.contrib.auth.models import User

@api_view (['POST'])
def login(request):
    user= get_object_or_404(User, username= request.data['username'])
    if not user.check_password(request.data['password']):
        return Response({"detail": "Not found."}, status=status.HTTP_404_NOT_FOUND)
    token, created = Token.objects.get_or_create(user=user)
    serializer = UserSerializer(instance=user)
    return Response({"token":token.key, "user": serializer.data})

@api_view(['POST'])
def signup(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        # Create the user object but don't save it yet
        user = User.objects.create(username=request.data['username'])
        user.set_password(request.data['password']) # Set the password
        user.save()  # Save the user object

        # Now, create a token for the user
        token = Token.objects.create(user=user)
        
        # Serialize the user data
        serializer = UserSerializer(instance=user)

        return Response({"token": token.key, "user": serializer.data})
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# @api_view (['POST'])
# def signup(request):
#     serializer = UserSerializer(data=request.data)
#     if serializer.is_valid():
#         serializer.save()
#         user = User.objects.get(username= request.data['username'])
#         user.set_password(request.data['password']) # hashing password
#         user.save()
#         token = Token.objects.create(user=user)
#         return Response({"token":token.key, "user":serializer.data})
#     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def getRoutes(request):

    routes = [
        {
            'Endpoint': '/blissfullden/login/',
            'method': 'POST',
            'body': None,
            'description': "Logs users in"
        },
        {
            'Endpoint': '/blissfullden/signup/',
            'method': 'POST',
            'body': None,
            'description': "Creates a user"
        },
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
