from __future__ import unicode_literals

from django.db import models
from django.dispatch import receiver
from django.db.models.signals import post_save
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import User
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill, ResizeToFit, ResizeToCover

class Product(models.Model):
    def get_default_position():
        try:
            default_position = Product.objects.aggregate(models.Max('position'))['position__max'] + 1
        except:
            default_position = 0
        return default_position

    owner = models.ForeignKey(User, related_name='products', on_delete=models.CASCADE, blank=False)
    name_et = models.CharField(max_length=255, blank=False)
    name_en = models.CharField(max_length=255, blank=False)
    description_et = models.TextField()
    description_en = models.TextField()
    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)
    position = models.PositiveIntegerField(default=get_default_position)
    visible = models.BooleanField(default=False, blank=False)


    def save(self, *args, **kwargs):
        """
        Move product to a specified position, updating all affected product positions accordingly.
        """
        try:
            position = Product.objects.get(pk=self.pk).position
        except:
            position = Product.objects.aggregate(models.Max('position'))['position__max'] or 0

        qs = Product.objects
        if position > self.position:
            update_kwargs = {'position': models.F('position') + 1}
            qs.filter(**{'position' + '__lt': position, 'position' + '__gte': self.position})\
                .update(**update_kwargs)
        elif position < self.position:
            update_kwargs = {'position': models.F('position') - 1}
            qs.filter(**{'position' + '__gt': position, 'position' + '__lte': self.position})\
                .update(**update_kwargs)

        super().save(*args, **kwargs)

    def __str__(self):
        """Return a human readable representation of the model instance."""
        return "{}".format(self.name_en)

class ProductImage(models.Model):
    owner = models.ForeignKey(User, related_name='product_images', on_delete=models.CASCADE, blank=False)
    product_id = models.ForeignKey(Product, related_name='product_images', on_delete=models.CASCADE, blank=False)
    full_size = models.ImageField(upload_to='images', blank=False)
    optimized = ImageSpecField(source='full_size',
        processors=[ResizeToFit(800, 800)],
        format='JPEG',
        options={'quality': 80})
    thumbnail = ImageSpecField(source='full_size',
        processors=[ResizeToFill(400, 400)],
        format='JPEG',
        options={'quality': 60})

    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)

# This receiver handles token creation when a new user is created.
@receiver(post_save, sender=User)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
