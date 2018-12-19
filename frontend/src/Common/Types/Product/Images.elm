module Common.Types.Product.Images
    exposing
        ( ProductImage
        , ProductImages
        , decoder
        , init
        , list
        , select
        , selected
        )

import Json.Decode as Decode exposing (Decoder)


type alias ProductImage =
    { id : Int
    , fullPath : String
    , optimized : String
    , thumbnail : String
    }


type ProductImages
    = ProductImages
        { head : ProductImage
        , tail : List ProductImage
        }


init : ProductImage -> List ProductImage -> ProductImages
init productImage productImageList =
    ProductImages { head = productImage, tail = productImageList }


select : ProductImage -> ProductImages -> ProductImages
select productImage (ProductImages { head, tail }) =
    init
        productImage
        (head :: tail |> List.filter (.id >> (/=) productImage.id))


list : ProductImages -> List ProductImage
list (ProductImages { head, tail }) =
    (head :: tail)
        |> List.sortBy .id


selected : ProductImages -> ProductImage
selected (ProductImages { head, tail }) =
    head


productImageDecoder : Decoder ProductImage
productImageDecoder =
    ProductImage
        |> Decode.succeed
        |> Decode.andThen (flip Decode.map (Decode.field "id" Decode.int))
        |> Decode.andThen (flip Decode.map (Decode.field "fullSize" Decode.string))
        |> Decode.andThen (flip Decode.map (Decode.field "optimized" Decode.string))
        |> Decode.andThen (flip Decode.map (Decode.field "thumbnail" Decode.string))


decoder : Decoder ProductImages
decoder =
    Decode.list productImageDecoder
        |> Decode.andThen
            (\productImageList ->
                case productImageList of
                    a :: b ->
                        Decode.succeed (init a b)

                    _ ->
                        Decode.fail "there are no images"
            )
