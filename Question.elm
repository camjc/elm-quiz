module Question exposing (view)

import QuizTypes
import Html exposing (Html, h1, text)


view : QuizTypes.Answer -> Html QuizTypes.Msg
view question =
    h1 []
        [ question
            |> .label
            |> text
        ]
