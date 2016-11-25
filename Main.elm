module Main exposing (main)

import Quiz exposing (update, view, Model)
import QuizTypes exposing (Msg)
import Array exposing (fromList, empty)
import Html exposing (beginnerProgram)
import Markdown


model : Quiz.Model
model =
    { questionId =
        -1
        -- Show Instructions
    , questions =
        Array.fromList
            [ ( True, "Something truthy" )
            , ( False, "Something falsy" )
            ]
    , correctAnswers = Array.empty
    , wrongAnswers = Array.empty
    , buttonTrue = ( "True", "green" )
    , buttonFalse = ( "False", "red" )
    , instructionsComponent =
        Markdown.toHtml [] """
# True or False
## How to Play
  - A question will appear.
  - Click *True* if you think the answer is true.
  - Click *False* if you think the answer is false.
"""
    }


main : Program Never Model QuizTypes.Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }
