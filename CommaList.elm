module CommaList exposing (view)

import QuizTypes
import Array
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import String
import StringReplace


whitespaceToNbsp : String -> String
whitespaceToNbsp string =
    StringReplace.replace " " " " string


getListString : QuizTypes.Answers -> String
getListString array =
    array
        |> Array.map .label
        |> Array.map whitespaceToNbsp
        |> Array.toList
        |> String.join ", "


view : QuizTypes.Answers -> QuizTypes.ButtonTuple -> Html QuizTypes.Msg
view listOfLabels buttonTuple =
    if Array.isEmpty listOfLabels then
        div [] []
    else
        div
            [ style
                [ ( "color", (Tuple.second buttonTuple) )
                , ( "line-height", "1.6" )
                , ( "margin-top", "0.5rem" )
                ]
            ]
            [ text ((Tuple.first buttonTuple) ++ ": " ++ (getListString listOfLabels) ++ ".") ]
