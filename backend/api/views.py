from rest_framework import generics, permissions
from .permissions import IsOwnerOrReadOnly
from .serializers import UserSerializer, ProductImageSerializer, ProductSerializer
from .models import ProductImage, Product
from django.contrib.auth.models import User


class ProductImagesView(generics.ListCreateAPIView):
    """This class handles the GET and POST requests of the api."""
    queryset = ProductImage.objects.all()
    serializer_class = ProductImageSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly)

    def perform_create(self, serializer):
        """Save the post data when creating new productImages."""
        if not serializer.is_valid():
            raise ValidationError(serializer.errors)
        serializer.save(owner=self.request.user)


class ProductImageView(generics.RetrieveUpdateDestroyAPIView):
    """This class handles GET, PUT, PATCH and DELETE requests."""
    queryset = ProductImage.objects.all()
    serializer_class = ProductImageSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly)

    def perform_update(self, serializer):
        """Save the post data when creating a new productImage."""
        if not serializer.is_valid():
            raise ValidationError(serializer.errors)
        serializer.save(owner=self.request.user)


class ProductsView(generics.ListCreateAPIView):
    """This class handles the GET and POST requests of the api."""
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly)

    def perform_create(self, serializer):
        """Save the post data when creating a new product."""
        if not serializer.is_valid():
            raise ValidationError(serializer.errors)
        serializer.save(owner=self.request.user)


class ProductView(generics.RetrieveUpdateDestroyAPIView):
    """This class handles GET, PUT, PATCH and DELETE requests."""
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly)

    def perform_update(self, serializer):
        """Save the post data when creating a new product."""
        if not serializer.is_valid():
            raise ValidationError(serializer.errors)
        serializer.save(owner=self.request.user)


class UserView(generics.ListAPIView):
    """View to list the user queryset."""
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetailsView(generics.RetrieveAPIView):
    """View to retrieve a user instance."""
    queryset = User.objects.all()
    serializer_class = UserSerializer
