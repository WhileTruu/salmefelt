module Pages.Product.View exposing (view)

import Common.Button.View as Button
import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Common.Types.Translations exposing (Translations)
import Header.View
import Html exposing (Html, button, div, h2, img, section, span, text)
import Html.Attributes exposing (alt, class, classList, src)
import Types exposing (Msg(..))


type alias Properties =
    { translations : Translations
    , language : Language
    , index : Int
    , product : Product
    }


productImageButton : Int -> Product -> ProductImage -> Html Msg
productImageButton index product image =
    Button.default
        (SelectProductImage index image)
        (image == ProductImages.selected product.images)
        [ img [ src <| "/" ++ image.thumbnail, alt <| "button-image-" ++ toString image.id ] [] ]


imageView : Properties -> Html Msg
imageView { index, product } =
    div [ class "section" ]
        [ div [ class "buttons" ] (ProductImages.list product.images |> List.map (productImageButton index product))
        , img [ src <| "/" ++ (product.images |> (ProductImages.selected >> .optimized)), alt product.nameEN ] []
        ]


description : { name : String, description : String } -> Html Msg
description { name, description } =
    div [ class "section" ] [ h2 [] [ text name ], text description ]


view : Properties -> List (Html Msg)
view properties =
    [ Header.View.view properties.translations properties.language True
    , section [ class "container product-view" ]
        [ imageView properties, description (getNameAndDescription properties) ]
    ]


getNameAndDescription : Properties -> { name : String, description : String }
getNameAndDescription { language, product } =
    case language of
        Language.EN ->
            { name = product.nameEN, description = product.descriptionEN }

        Language.ET ->
            { name = product.nameET, description = product.descriptionET }
