module Routing exposing (parseLocation, productPath)

import Navigation exposing (Location)
import Types exposing (Route(..))
import UrlParser exposing ((</>), Parser)


productPath : Int -> String
productPath productId =
    "/products/" ++ toString productId


matchers : Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map Root UrlParser.top
        , UrlParser.map Product (UrlParser.s "products" </> UrlParser.int)
        ]


parseLocation : Location -> Route
parseLocation location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            Root
