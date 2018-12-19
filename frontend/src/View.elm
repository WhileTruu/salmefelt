module View exposing (view)

import Common.Translations as Translations
import Common.Types.Translations exposing (Translations)
import Dict
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (class)
import Pages.Main.View as MainPage
import Pages.NotFound.View as NotFoundPage
import Pages.Product.View as ProductPage
import Types exposing (..)


view : Model -> Html Msg
view model =
    div [ class "app" ]
        (page
            (Translations.getTranslationsForLanguage model.language)
            model
        )


page : Translations -> Model -> List (Html Msg)
page translations model =
    case model.route of
        Types.Root ->
            MainPage.view translations model.language model.products

        Types.Product id ->
            model.products
                |> Dict.get id
                |> Maybe.map
                    (\product ->
                        ProductPage.view
                            { translations = translations, index = id, product = product, language = model.language }
                    )
                |> Maybe.withDefault (NotFoundPage.view translations)
