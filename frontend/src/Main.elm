module Main exposing (..)

import Navigation exposing (Location)
import State
import Types exposing (Flags, Model, Msg)
import View


main : Program Flags Model Msg
main =
    Navigation.programWithFlags Types.OnLocationChange
        { view = View.view
        , init = State.init
        , update = State.update
        , subscriptions = always Sub.none
        }
