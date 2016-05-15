module IncorrectList exposing (view)

import CommaList
import QuizTypes
import Array
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (style)


view : QuizTypes.Model -> Html QuizTypes.Msg
view model =
    let
        shouldBeTrue =
            Array.filter .value model.wrongAnswers

        notValue item =
            not item.value

        shouldBeFalse =
            Array.filter notValue model.wrongAnswers
    in
        if Array.isEmpty model.wrongAnswers then
            div [] []
        else
            div []
                [ h2 [ style [ ( "margin", "3rem 0 1rem" ) ] ]
                    [ text "Answers you missed" ]
                , div []
                    [ CommaList.view shouldBeTrue model.buttonTrue
                    , CommaList.view shouldBeFalse model.buttonFalse
                    ]
                ]
