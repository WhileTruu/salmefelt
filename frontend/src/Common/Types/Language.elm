module Common.Types.Language exposing (Language(..), decode, toString, toggle)

import Json.Decode


type Language
    = EN
    | ET


toggle : Language -> Language
toggle language =
    case language of
        EN ->
            ET

        ET ->
            EN


decode : Json.Decode.Decoder Language
decode =
    Json.Decode.string
        |> Json.Decode.andThen
            (\s ->
                case s of
                    "EN" ->
                        Json.Decode.succeed EN

                    "ET" ->
                        Json.Decode.succeed ET

                    _ ->
                        Json.Decode.fail ("Unrecognized language " ++ s)
            )


toString : Language -> String
toString language =
    case language of
        EN ->
            "EN"

        ET ->
            "ET"
