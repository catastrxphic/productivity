from django.urls import path
from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('tasks', views.TaskViewSet, basename='task')

# urlpatterns = [
#     path('', views.getRoutes),
#     path('tasks/', views.getTasks),
#     path('tasks/create/', views.createTask),
#     path('tasks/<str:pk>/update/', views.updateTask),
#     path('tasks/<str:pk>/delete/', views.deleteTask),
#     path('tasks/<str:pk>/', views.getTask),
#     path('signup/', views.signup),
#     path('login/', views.login),
#     ]

from .views import TaskViewSet

urlpatterns = [
    path('signup/', views.signup),
    path('login/', views.login),
] + router.urls