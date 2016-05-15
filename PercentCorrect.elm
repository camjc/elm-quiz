module PercentCorrect exposing (view)

import Helpers
import QuizTypes
import Html exposing (Html, div, text)


getPercentageCorrectString : QuizTypes.Model -> String
getPercentageCorrectString model =
    let
        percentString =
            model
                |> Helpers.getPercentageCorrect
                |> toString
    in
        percentString ++ "% Correct"


view : QuizTypes.Model -> Html QuizTypes.Msg
view model =
    div []
        [ model
            |> getPercentageCorrectString
            |> text
        ]
