module Common.Button.View exposing (default, link, maxSize, small)

import Common.Utilities exposing (onClickWithPreventDefault)
import Html exposing (Html, a, button)
import Html.Attributes exposing (class, classList, disabled, href, src)


internalButton : List String -> msg -> Bool -> List (Html msg) -> Html msg
internalButton classNames onClick selected children =
    button
        [ class <| String.join " " classNames
        , classList [ ( "selected", selected ) ]
        , disabled selected
        , onClickWithPreventDefault onClick
        ]
        children


default : msg -> Bool -> List (Html msg) -> Html msg
default onClick selected children =
    internalButton [ "button", "default" ] onClick selected children


small : msg -> Bool -> List (Html msg) -> Html msg
small onClick selected children =
    internalButton [ "button", "small" ] onClick selected children


link : List String -> String -> List (Html msg) -> Html msg
link classNames url children =
    a [ class <| String.join " " ("button" :: "default" :: classNames), href url ] children


maxSize : msg -> Bool -> List (Html msg) -> Html msg
maxSize onClick selected children =
    internalButton [ "button", "max-size" ] onClick selected children
