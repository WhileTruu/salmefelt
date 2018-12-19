module Pages.NotFound.View exposing (view)

import Common.Types.Translations exposing (Translations)
import Html exposing (Html, h1, p, section, text)
import Html.Attributes exposing (class)
import Types exposing (Msg)


view : Translations -> List (Html Msg)
view translations =
    [ section [ class "container" ]
        [ h1 [] [ text "404" ]
        , p [] [ text translations.page_not_found ]
        ]
    ]
