from django.db import models

class Task(models.Model):
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
        return self.body[:50]
    
    class Meta:
        ordering = ['-updated']