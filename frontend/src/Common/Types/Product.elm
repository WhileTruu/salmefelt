module Common.Types.Product exposing (..)

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
    Product
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "position" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "images" ProductImages.decoder))
        |> Json.Decode.andThen (flip Json.Decode.map (field "visible" bool))
