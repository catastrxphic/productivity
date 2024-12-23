from django.db import models
from django.contrib.auth.models import User

class Task(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="tasks", null=True)
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    status = models.CharField(max_length=50, choices= [
        ('pending', "Pending"),
        ('in_progress', "In Progress"),
        ('completed', "Completed")
    ])
    additional_notes = models.CharField(max_length=500, blank=True, null=True)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self) :
        return self.title
    
    class Meta:
        ordering = ['-updated']