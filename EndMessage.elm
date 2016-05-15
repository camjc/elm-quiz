module EndMessage exposing (view)

import Html exposing (Html, h1, text)
import QuizTypes


endMessage : Int -> String
endMessage percentage =
    if percentage == 100 then
        "Perfect"
    else if percentage > 90 then
        "Excellent"
    else if percentage > 80 then
        "Very good"
    else if percentage > 70 then
        "Good"
    else if percentage > 60 then
        "Nice"
    else if percentage > 50 then
        "Alright"
    else
        "Try again"


view : Int -> Html QuizTypes.Msg
view percentage =
    h1 [] [ text ((endMessage percentage) ++ ", you got") ]
