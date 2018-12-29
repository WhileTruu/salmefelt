module Common.Utilities exposing (ifThenElse, onClickWithPreventDefault)

import Html
import Html.Events
import Json.Decode


onClickWithPreventDefault : msg -> Html.Attribute msg
onClickWithPreventDefault message =
    Html.Events.preventDefaultOn
        "click"
        (Json.Decode.succeed message |> Json.Decode.map alwaysPreventDefault)


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


ifThenElse : Bool -> a -> a -> a
ifThenElse condition a1 a2 =
    if condition then
        a1

    else
        a2
