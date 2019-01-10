module Pages.Main.View exposing (view)

import Common.Button.View as Button
import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Common.Types.Translations exposing (Translations)
import Dict exposing (Dict)
import Header.View
import Html exposing (Html, a, div, h2, img, p, section, text)
import Html.Attributes exposing (alt, class, href, property, src)
import Json.Encode
import Routing
import Types exposing (Msg(..))


intro : Translations -> Html Msg
intro translations =
    p [ class "intro" ] (translations.body_text |> List.map text |> List.intersperse (Html.br [] []))


getName : Language -> Product -> String
getName language product =
    case language of
        Language.EN ->
            product.nameEN

        Language.ET ->
            product.nameET


productButton : Int -> Product -> ProductImage -> Html Msg
productButton index product productImage =
    Button.maxSize
        (GoToProductPage (Routing.productPath product.id) index productImage)
        False
        [ div
            [ class "square-image-container" ]
            [ img [ src productImage.thumbnail, alt <| product.nameEN ++ " " ++ String.fromInt productImage.id ] [] ]
        ]


productList : Language -> Int -> Product -> Html Msg
productList language index product =
    div [ class "product" ]
        [ h2 [] [ text <| getName language product ]
        , div [ class "grid" ]
            (ProductImages.list product.images
                |> List.map (productButton index product)
            )
        ]


view : Translations -> Language -> Dict Int Product -> List (Html Msg)
view translations language products =
    [ Header.View.view translations language False
    , section
        [ class "container products" ]
        ([ intro translations ]
            ++ (products
                    |> Dict.toList
                    |> List.sortBy (Tuple.second >> .position)
                    |> List.foldl
                        (\( index, product ) accumulator ->
                            if product.visible then
                                accumulator ++ [ productList language index product ]

                            else
                                accumulator
                        )
                        []
               )
        )
    ]
