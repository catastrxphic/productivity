# from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.viewsets import ModelViewSet
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from .serializers import TaskSerializer, UserSerializer
from .models import Task
from django.contrib.auth.models import User

login = ObtainAuthToken.as_view()

# @api_view (['POST'])
# def login(request):
#     user= get_object_or_404(User, username= request.data['username'])
#     if not user.check_password(request.data['password']):
#         return Response({"detail": "Not found."}, status=status.HTTP_404_NOT_FOUND)
#     token, created = Token.objects.get_or_create(user=user)
#     serializer = UserSerializer(instance=user)
#     return Response({"token":token.key, "user": serializer.data})

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
            'Endpoint': '/blissfullden/tasks/',
            'method': 'GET',
            'body': None,
            'description': "Lists all tasks for the user"
        },
        {
            'Endpoint': '/blissfullden/tasks/<id>',
            'method': 'GET',
            'body': None,
            'description': "Returns a specific task"
        },
        {
            'Endpoint': '/blissfullden/tasks/',
            'method': 'POST',
            'body': None,
            'description': "Create a new task"
        },
        {
            'Endpoint': '/blissfullden/tasks/<id>',
            'method': 'PUT',
            'body': None,
            'description': "Update a specific existing task"
        },
        {
            'Endpoint': '/blissfullden/tasks/<id>',
            'method': 'DELETE',
            'body': None,
            'description': "deleted a specific existing task"
        },
        

        
        # {
        #     'Endpoint': '/blissfullden/id/',
        #     'method': 'GET',
        #     'body': None,
        #     'description': "Returns a single note"
        # },
        # {
        #     'Endpoint': '/blissfullden/create/',
        #     'method': 'POST',
        #     'body': {'Body': ""},
        #     'description': "Creates a new note with data sent in post request"
        # },
        # {
        #     'Endpoint': '/blissfullden/id/update/',
        #     'method': 'PUT',
        #     'body': {'Body':""},
        #     'description': "Creates an existing note with data sent in put"
        # },
        # {
        #     'Endpoint': '/blissfullden/id/delete/',
        #     'method': 'DELETE',
        #     'body': None,
        #     'description': "Deletes and existing note"
        # }
    ]
    return Response(routes)


# creating Task-Related Logic TaskViewSet
class TaskViewSet(ModelViewSet):
    serializer_class = TaskSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Task.objects.filter(user=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)    



    # @api_view(['GET'])
    # def getTasks(request):
    #     tasks = Task.objects.filter(user=request.user)
    #     serializer = TaskSerializer(tasks, many = True)
    #     return Response(serializer.data)


    # @api_view(['GET'])
    # def getTask(request, pk):
    #     task = Task.objects.filter(user=request.user).get(id=pk)
    #     serializer = TaskSerializer(task, many=False)
    #     return Response(serializer.data)


    # @api_view(['POST'])
    # def createTask(request):
    #     data = request.data

    #     task = Task.objects.create(
    #         title = data['title'],
    #         description = data['description'],
    #         status = data['status'],
    #         additional_notes = data['additional_notes'],
    #         updated = data['updated'],
    #         created = data['created']
    #     )
    #     serializer = TaskSerializer(task, many=False)

    #     return Response(serializer.data)

    # @api_view(['PUT'])
    # def updateTask(request, pk):
    #     data = request.data

    #     task = Task.objects.get(id=pk)
    #     serializer = TaskSerializer(task, data= request.data)

    #     if serializer.is_valid():
    #         serializer.save()

    #     return Response(serializer.data)
        
    # @api_view(['DELETE'])
    # def deleteTask(request, pk):
    #     task = Task.objects.get(id=pk)
    #     task.delete()
    #     return Response("Task was deleted")
