module Helpers exposing (getGuessesCount, getPercentageCorrect)

import Array
import QuizTypes


getGuessesCount : QuizTypes.Model -> Int
getGuessesCount model =
    (Array.length model.correctAnswers) + (Array.length model.wrongAnswers)


getPercentageCorrect : QuizTypes.Model -> Int
getPercentageCorrect model =
    let
        correctAnswers =
            model.correctAnswers
                |> Array.length
                |> toFloat

        totalAnswers =
            model
                |> getGuessesCount
                |> toFloat
    in
        correctAnswers
            / max totalAnswers 1
            * 100
            |> round
