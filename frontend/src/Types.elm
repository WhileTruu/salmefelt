module Types exposing (..)

import Common.Types.Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images exposing (ProductImage)
import Dict exposing (Dict)
import Http
import Json.Decode
import Navigation exposing (Location)


type Msg
    = ToggleLanguage
    | GetProducts (Result Http.Error (Dict Int Product))
    | OnLocationChange Location
    | GoToProductPage String Int ProductImage
    | SelectProductImage Int ProductImage
    | ChangeLocation String


type Route
    = Root
    | Product Int


type alias Flags =
    { language : Json.Decode.Value
    }


type alias Model =
    { route : Route
    , language : Language
    , products : Dict Int Product
    }
