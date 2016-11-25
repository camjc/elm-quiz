module Button exposing (view)

import QuizTypes
import Html exposing (Attribute, Html, button, text)
import Html.Attributes exposing (style)
import Html.Events


getStyle : String -> Attribute QuizTypes.Msg
getStyle backgroundColor =
    style
        [ ( "border", "0" )
        , ( "background-color", backgroundColor )
        , ( "color", "white" )
        , ( "font-size", "1.5rem" )
        , ( "margin-right", "1rem" )
        , ( "padding", "0.5rem 1rem" )
        ]


view : QuizTypes.ButtonTuple -> QuizTypes.Msg -> Html QuizTypes.Msg
view buttonTuple action =
    button
        [ buttonTuple
            |> Tuple.second
            |> getStyle
        , Html.Events.onClick action
        ]
        [ buttonTuple
            |> Tuple.first
            |> text
        ]
