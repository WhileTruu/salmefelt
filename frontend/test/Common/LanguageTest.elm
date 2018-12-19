module LanguageTest exposing (..)

import Common.Types.Language as Language exposing (Language)
import Dict exposing (Dict)
import Expect
import Http
import Json.Decode
import Json.Encode
import State
import Test exposing (..)
import Types


toggle : Test
toggle =
    describe "toggle"
        [ describe "when given english"
            [ test "returns estonian" <|
                \_ ->
                    Language.toggle Language.EN
                        |> Expect.equal Language.ET
            ]
        , describe "when given estonian"
            [ test "returns english" <|
                \_ ->
                    Language.toggle Language.ET
                        |> Expect.equal Language.EN
            ]
        ]


decode : Test
decode =
    describe "decode"
        [ describe "when decoding english language string"
            [ test "results in a successful conversion to english" <|
                \_ ->
                    Json.Encode.string "EN"
                        |> Json.Decode.decodeValue Language.decode
                        |> Expect.equal (Result.Ok Language.EN)
            ]
        , describe "when decoding estonian language string"
            [ test "results in a successful conversion to estonian" <|
                \_ ->
                    Json.Encode.string "ET"
                        |> Json.Decode.decodeValue Language.decode
                        |> Expect.equal (Result.Ok Language.ET)
            ]
        , describe "when decoding an unknown string"
            [ test "results in a successful conversion to estonian" <|
                \_ ->
                    Json.Encode.string "😂😂😂"
                        |> Json.Decode.decodeValue Language.decode
                        |> Expect.equal (Result.Err "I ran into a `fail` decoder: Unrecognized language 😂😂😂")
            ]
        ]
