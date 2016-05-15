module StringReplace exposing (replace)

import Regex


-- from https://github.com/lorenzo/elm-string-addons/blob/2.0.0/src/String/Addons.elm
-- Replace all occurrences of the search string with the substitution string.
-- replace "Mary" "Sue" "Hello, Mary" == "Hello, Sue"


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All (Regex.regex (Regex.escape search)) (\_ -> substitution)
