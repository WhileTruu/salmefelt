from django.contrib import admin
from .models import ProductImage, Product

from rest_framework.authtoken.admin import TokenAdmin

TokenAdmin.raw_id_fields = ('user',)

class ProductImageAdmin(admin.StackedInline):
    model = ProductImage
    #list_display = ('id', 'image')

    def get_changeform_initial_data(self, request):
        return { 'owner': request.user }

class ProductAdmin(admin.ModelAdmin):
    model = Product
    list_display = ['id', 'position', 'get_name_en', 'get_name_et',]

    def get_changeform_initial_data(self, request):
        return { 'owner': request.user }

    def get_name_en(self, obj):
        return obj.name_en

    get_name_en.admin_order_field  = 'position'
    get_name_en.short_description = 'Name (en)'

    def get_name_et(self, obj):
        return obj.name_et

    get_name_et.admin_order_field  = 'position'
    get_name_et.short_description = 'Name (et)'

    inlines = [ProductImageAdmin]



# Register your models here.
# admin.site.register(ProductImage, ProductImageAdmin)
class MyAdminSite(admin.AdminSite):
    # Disable View on Site link on admin page
    site_header = "salmefelt"
    site_url = None

admin_site = MyAdminSite(name='myadmin')
admin_site.register(Product, ProductAdmin)
