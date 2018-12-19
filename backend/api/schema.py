import graphene
from .models import Product, ProductImage
from graphene_django.types import DjangoObjectType

class ProductType(DjangoObjectType):
    class Meta:
        model = Product


class ProductImageType(DjangoObjectType):
    class Meta:
        model = ProductImage

class Query(graphene.ObjectType):
    product = graphene.Field(ProductType,
        id=graphene.Int(),
        name_et=graphene.String(),
        name_en=graphene.String(),
        description_et=graphene.String(),
        description_en=graphene.String(),
        position=graphene.Int(),
    )
    products = graphene.List(ProductType)
    product_image = graphene.Field(ProductImageType, id=graphene.Int(), product_id=graphene.Int(), full_size=graphene.String(), optimized=graphene.String())
    product_images = graphene.List(ProductImageType)

    def resolve_product(self, info, **kwargs):
        id = kwargs.get('id')

        if id is not None:
            return Product.objects.get(pk=id)

        return None

    def resolve_products(self, info, **kwargs):
        return Product.objects.filter(visible=True)

    def resolve_product_image(self, info, **kwargs):
        id = kwargs.get('id')

        if id is not None:
            return ProductImage.objects.get(pk=id)

        return None

    def resolve_product_images(self, info, **kwargs):
        # We can easily optimize query count in the resolve method
        return ProductImage.objects.select_related('products').all()

schema = graphene.Schema(query=Query)
