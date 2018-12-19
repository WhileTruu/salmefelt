from rest_framework import serializers
from .models import ProductImage, Product
from django.contrib.auth.models import User


class ProductImageSerializer(serializers.ModelSerializer):
    full_size = serializers.ImageField(use_url=False)
    optimized = serializers.ImageField(read_only=True, use_url=False)
    thumbnail = serializers.ImageField(read_only=True, use_url=False)

    class Meta:
        model = ProductImage
        fields = ('id', 'full_size', 'optimized', 'thumbnail')
        read_only_fields = ('date_created', 'date_modified')


class ProductSerializer(serializers.ModelSerializer):
    images = ProductImageSerializer(source='product_images', many=True, read_only=True)

    class Meta:
        model = Product
        fields = ('id', 'name_et', 'name_en', 'description_et', 'description_en', 'images', 'position', 'visible')
        read_only_fields = ('date_created', 'date_modified')

class UserSerializer(serializers.ModelSerializer):
    """A user serializer to aid in authentication and authorization."""

    products = serializers.PrimaryKeyRelatedField(many=True, queryset=Product.objects.all())

    class Meta:
        """Map this serializer to the default django user model."""
        model = User
        fields = ('id', 'username', 'products')
