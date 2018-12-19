module State exposing (init, update)

import Common.Api as Api
import Common.Types.Language as Language exposing (Language)
import Common.Ports
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Dict exposing (Dict)
import Http
import Json.Decode
import Navigation exposing (Location)
import Routing
import Types exposing (Flags, Model, Msg(..))


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    ( { language =
            flags.language
                |> Json.Decode.decodeValue Language.decode
                |> Result.withDefault Language.EN
      , products = Dict.empty
      , route = Routing.parseLocation location
      }
    , Http.send GetProducts Api.getProducts
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLanguage ->
            ( { model | language = model.language |> Language.toggle }
            , Common.Ports.storeLanguage (model.language |> Language.toggle |> Language.toString)
            )

        GetProducts (Ok products) ->
            ( { model | products = products }, Cmd.none )

        GetProducts (Err string) ->
            let
                _ =
                    Debug.log "GetProducts error" string
            in
            ( model, Cmd.none )

        SelectProductImage index productImage ->
            ( { model
                | products =
                    replaceActiveProductImageInProducts index productImage model.products
              }
            , Cmd.none
            )

        ChangeLocation path ->
            ( model, Navigation.newUrl path )

        GoToProductPage path index productImage ->
            ( { model
                | products = replaceActiveProductImageInProducts index productImage model.products
              }
            , Navigation.newUrl path
            )

        OnLocationChange location ->
            ( { model | route = Routing.parseLocation location }, Cmd.none )


replaceActiveProductImageInProducts : Int -> ProductImage -> Dict Int Product -> Dict Int Product
replaceActiveProductImageInProducts index productImage products =
    products
        |> Dict.update
            index
            (Maybe.map
                (\product ->
                    { product | images = ProductImages.select productImage product.images }
                )
            )
