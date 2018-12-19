module TranslationsTest exposing (..)

import Common.Translations as Translations exposing (Translations)
import Dict exposing (Dict)
import Expect
import Http
import Json.Decode
import Json.Encode
import State
import Test exposing (..)
import Types


fakeTranslations : Translations
fakeTranslations =
    { dictionary = Dict.fromList [ ( "who.did.dis??????", "😂😂😂" ), ( "finna", "woke" ) ]
    , isLoading = False
    }


translate : Test
translate =
    describe "translate"
        [ describe "when asking translation which exists"
            [ test "returns translation" <|
                \_ ->
                    Translations.translate fakeTranslations "who.did.dis??????"
                        |> Expect.equal "😂😂😂"
            ]
        , describe "when asking for a translation that does not exist"
            [ test "returns a default message" <|
                \_ ->
                    Translations.translate fakeTranslations "420"
                        |> Expect.equal Translations.noTranslation
            ]
        ]
