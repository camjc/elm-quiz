module ScoreCard exposing (view)

import Helpers
import IncorrectList
import PercentCorrect
import QuizTypes
import Array
import Html exposing (Html, div, h1, text)


scoreComponent : QuizTypes.Model -> Html QuizTypes.Msg
scoreComponent model =
    let
        correctAnswers =
            model.correctAnswers
                |> Array.length
                |> toString

        totalAnswers =
            model
                |> Helpers.getGuessesCount
                |> toString
    in
        h1 [] [ text (correctAnswers ++ " out of " ++ totalAnswers) ]


view : QuizTypes.Model -> Html QuizTypes.Msg
view model =
    div []
        [ scoreComponent model
        , PercentCorrect.view model
        , IncorrectList.view model
        ]
