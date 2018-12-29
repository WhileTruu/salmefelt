module Types exposing
    ( Flags
    , Model
    , Msg(..)
    , Route(..)
    )

import Browser.Navigation
import Common.Types.Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images
    exposing
        ( ProductImage
        )
import Dict exposing (Dict)
import Http
import Json.Decode


type Msg
    = ToggleLanguage
    | GetProducts (Result Http.Error (Dict Int Product))
    | ChangeUrl
    | GoToProductPage String Int ProductImage
    | SelectProductImage Int ProductImage
    | RequestUrl


type Route
    = Root
    | Product Int


type alias Flags =
    Json.Decode.Value



-- Hello world


type alias Model =
    { route : Route
    , key : Browser.Navigation.Key
    , language : Language
    , products : Dict Int Product
    }
