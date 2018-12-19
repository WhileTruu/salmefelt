module StateTest exposing (..)

import Common.Api as Api
import Common.Types.Language as Language exposing (Language)
import Common.Translations exposing (Translations)
import Dict exposing (Dict)
import Expect
import Http
import Json.Encode
import State
import Test exposing (..)
import Types


fakeTranslations : Translations
fakeTranslations =
    { dictionary = Dict.fromList [ ( "bleep", "bloop" ), ( "meep", "moop" ) ]
    , isLoading = False
    }


init : Test
init =
    describe "init"
        [ describe "when initializing without language from localstorage" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.init { language = Json.Encode.null }
            in
            [ test "language defaults to english" <|
                \_ ->
                    result |> Tuple.first |> .language |> Expect.equal Language.EN
            , test "translations are loading" <|
                \_ -> result |> Tuple.first |> .translations |> .isLoading |> Expect.equal True
            ]
        , describe "when initializing with language from localstorage" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.init { language = Json.Encode.string "ET" }
            in
            [ test "language is decoded" <|
                \_ ->
                    result |> Tuple.first |> .language |> Expect.equal Language.ET
            , test "translations are loading" <|
                \_ -> result |> Tuple.first |> .translations |> .isLoading |> Expect.equal True
            ]
        ]


update : Test
update =
    describe "update"
        [ describe "when switching between languages" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.update Types.ToggleLanguage (Tuple.first <| State.init { language = Json.Encode.string "EN" })
            in
            [ test "langugage is changed" <|
                \_ -> result |> Tuple.first |> .language |> Expect.equal Language.ET
            , test "the update results in another command (hopefully requesting new translations)" <|
                \_ ->
                    result
                        |> Tuple.second
                        |> Expect.notEqual Cmd.none
            , test "translations are loading" <|
                \_ -> result |> Tuple.first |> .translations |> .isLoading |> Expect.equal True
            ]
        , describe "when getting translations is a success" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.update
                        (Types.GetTranslations (Result.Ok fakeTranslations.dictionary))
                        (Tuple.first <| State.init { language = Json.Encode.string "EN" })
            in
            [ test "translations are added to the state" <|
                \_ ->
                    result
                        |> Tuple.first
                        |> .translations
                        |> .dictionary
                        |> Expect.equal fakeTranslations.dictionary
            , test "translations are not loading" <|
                \_ -> result |> Tuple.first |> .translations |> .isLoading |> Expect.equal False
            ]
        , describe "when getting translations is a failure" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.update
                        (Types.GetTranslations (Result.Err Http.NetworkError))
                        (Tuple.first <| State.init { language = Json.Encode.string "EN" })
            in
            [ test "nothing changes" <|
                \_ ->
                    result
                        |> Tuple.first
                        |> .translations
                        |> .dictionary
                        |> Expect.equal Dict.empty
            , test "translations are not loading" <|
                \_ -> result |> Tuple.first |> .translations |> .isLoading |> Expect.equal False
            ]
        , describe "when called with NoOp"
            [ test "returns current state, changing nothing" <|
                let
                    initialModel : Types.Model
                    initialModel =
                        Tuple.first <| State.init { language = Json.Encode.string "EN" }
                in
                \_ ->
                    State.update Types.NoOp initialModel |> Expect.equal ( initialModel, Cmd.none )
            ]
        ]
