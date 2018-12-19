from django.conf.urls import url, include
from rest_framework.urlpatterns import format_suffix_patterns
from .views import (
    UserView,
    UserDetailsView,
    ProductImagesView,
    ProductImageView,
    ProductsView,
    ProductView)
from rest_framework.authtoken.views import obtain_auth_token
from django.views.generic import RedirectView

urlpatterns = {
    url(r'^images/$', ProductImagesView.as_view(), name="product_images"),
    url(r'^images/(?P<pk>[0-9]+)/$', ProductImageView.as_view(), name="productimage"),
    url(r'^products/$', ProductsView.as_view(), name="products"),
    url(r'^products/(?P<pk>[0-9]+)/$', ProductView.as_view(), name="product"),
    url(r'^auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^users/$', UserView.as_view(), name="users"),
    url(r'^users/(?P<pk>[0-9]+)/$', UserDetailsView.as_view(), name="user_details"),
    url(r'^get-token/', obtain_auth_token),
}

urlpatterns = format_suffix_patterns(urlpatterns)
