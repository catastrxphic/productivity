from rest_framework.serializers import ModelSerializer
from .models import Task
from django.contrib.auth.models import User
from rest_framework.response import Response

class TaskSerializer(ModelSerializer):
    class Meta:
        model = Task
        fields='__all__'
        # including user field
        extra_kwargs = {'user': {'read_only': True}}

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'password']

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password']
        )
        return user
