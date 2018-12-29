module Routing exposing (parseUrl, parser, productPath)

import Types exposing (Route(..))
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser)


productPath : Int -> String
productPath productId =
    "/products/" ++ String.fromInt productId


parser : Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map Root Url.Parser.top
        , Url.Parser.map Product (Url.Parser.s "products" </> Url.Parser.int)
        ]


parseUrl : Url -> Route
parseUrl url =
    case Url.Parser.parse parser url of
        Just route ->
            route

        Nothing ->
            Root
