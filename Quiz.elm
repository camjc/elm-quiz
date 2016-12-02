module Quiz exposing (update, view, Question, Model, Msg)

{-| Create a Quiz based on Boolean (True | False) questions.

Example:

    import Quiz exposing (update, view, Model)
    import Array exposing (fromList, empty)
    import Html exposing (beginnerProgram)
    import Markdown exposing (toHtml)


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


    main : Program Never
    main =
        Html.beginnerProgram { model = model, view = view, update = update }

# Definition
@docs update
@docs view
@docs Question
@docs Model
@docs Msg
-}

import Button
import Helpers
import ScoreCard
import EndMessage
import Question
import Array
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import QuizTypes


{-| A Tuple of the answer and the question.

    (True, "Do I like chocolate?")
-}
type alias Question =
    QuizTypes.Question


{-| The entire Model

    model =
        { questionId -- Should start at -1 to show the instructions.
        , questions -- An array of `Question`s.
        , correctAnswers -- Should start as an empty Array.
        , wrongAnswers -- Should start as an empty Array.
        , buttonTrue -- A Tuple of ("Text", "Colour").
        , buttonFalse -- A Tuple of ("Text", "Colour").
        , instructionsComponent -- HTML to show as instructions.
        }
-}
type alias Model =
    QuizTypes.Model


{-| The actions that can be performed
-}
type alias Msg =
    QuizTypes.Msg


getCurrentQuestion : QuizTypes.Model -> QuizTypes.Answer
getCurrentQuestion model =
    case Array.get model.questionId model.questions of
        Just question ->
            { id = model.questionId, value = (Tuple.first question), label = (Tuple.second question) }

        Nothing ->
            { id = -1, value = False, label = "End" }


isGuessCorrect : QuizTypes.Model -> Bool -> Bool
isGuessCorrect model guess =
    (getCurrentQuestion model).value == guess


updateModelWithGuess : Bool -> QuizTypes.Model -> QuizTypes.Model
updateModelWithGuess guess model =
    let
        correctGuess =
            (isGuessCorrect model guess)

        currentQuestion =
            getCurrentQuestion model
    in
        { model
            | questionId = model.questionId + 1
            , correctAnswers =
                if correctGuess then
                    Array.push currentQuestion model.correctAnswers
                else
                    model.correctAnswers
            , wrongAnswers =
                if (not correctGuess) then
                    Array.push currentQuestion model.wrongAnswers
                else
                    model.wrongAnswers
        }


{-| The update function, pass to Html.beginnerProgram
-}
update : QuizTypes.Msg -> QuizTypes.Model -> QuizTypes.Model
update action model =
    case action of
        QuizTypes.Start ->
            { model | questionId = 0 }

        QuizTypes.GuessTrue ->
            updateModelWithGuess True model

        QuizTypes.GuessFalse ->
            updateModelWithGuess False model



-- VIEW


{-| The view function, pass to Html.beginnerProgram
-}
view : QuizTypes.Model -> Html QuizTypes.Msg
view model =
    div
        [ style
            [ ( "margin", "5rem auto" )
            , ( "max-width", "25rem" )
            ]
        ]
        (if model.questionId == -1 then
            [ model.instructionsComponent
            , Button.view ( "Start", "green" ) QuizTypes.Start
            ]
         else if (getCurrentQuestion model).label == "End" then
            [ EndMessage.view (Helpers.getPercentageCorrect model)
            , ScoreCard.view model
            ]
         else
            [ Question.view (getCurrentQuestion model)
            , Button.view model.buttonTrue QuizTypes.GuessTrue
            , Button.view model.buttonFalse QuizTypes.GuessFalse
            , ScoreCard.view model
            ]
        )
