module Common.Types.Product exposing (Product, decoder)

import Common.Types.Product.Images as ProductImages exposing (ProductImages)
import Json.Decode exposing (Decoder, bool, decodeString, decodeValue, field, int, list, string)


type alias Product =
    { id : Int
    , position : Int
    , nameEN : String
    , nameET : String
    , descriptionEN : String
    , descriptionET : String
    , images : ProductImages
    , visible : Bool
    }


decoder : Decoder Product
decoder =
    Json.Decode.succeed Product
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "id" int))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "position" int))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "nameEn" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "nameEt" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "descriptionEn" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "descriptionEt" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "images" ProductImages.decoder))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "visible" bool))
