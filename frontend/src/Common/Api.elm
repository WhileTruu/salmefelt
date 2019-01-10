module Common.Api exposing (getProducts, getProductsWithGraphQl, graphQlJsonQuery)

import Common.Types.Product as Product exposing (Product)
import Dict exposing (Dict)
import Http
import Json.Decode
import Json.Encode
import Task exposing (Task)


getProducts : Http.Request (Dict Int Product)
getProducts =
    Http.get "/api/v1/products/"
        (Json.Decode.list Product.decoder
            |> Json.Decode.andThen
                (List.map (\a -> ( a.id, a )) >> Dict.fromList >> Json.Decode.succeed)
        )


getProductsWithGraphQl : Task Http.Error (Dict Int Product)
getProductsWithGraphQl =
    Http.post
        "/graphql"
        (Http.jsonBody graphQlJsonQuery)
        (Json.Decode.list Product.decoder
            |> Json.Decode.andThen
                (List.map (\a -> ( a.id, a )) >> Dict.fromList >> Json.Decode.succeed)
        )
        |> Http.toTask


graphQlJsonQuery : Json.Decode.Value
graphQlJsonQuery =
    Json.Encode.object
        [ ( "query"
          , Json.Encode.string
                """
                  {
                    products {
                      id,
                      nameEt
                      nameEn
                      images: productImages {
                        id,
                        path: image
                      }
                    }
                  }
                """
          )
        , ( "variables", Json.Encode.null )
        , ( "operationName", Json.Encode.null )
        ]
