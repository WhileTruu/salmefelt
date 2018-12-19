module Common.Utilities exposing (ifThenElse, onClickWithPreventDefault)

import Html
import Html.Events
import Json.Decode


onClickWithPreventDefault : msg -> Html.Attribute msg
onClickWithPreventDefault message =
    let
        options : Html.Events.Options
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
    Html.Events.onWithOptions "click" options (Json.Decode.succeed message)


ifThenElse : Bool -> a -> a -> a
ifThenElse condition a1 a2 =
    if condition then
        a1
    else
        a2
