port module Common.Ports exposing (..)

-- port for storing language in localStorage


port storeLanguage : String -> Cmd msg
