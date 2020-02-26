module Note exposing (..)

import Html exposing (Html, div, text)


type alias Name =
    String


type alias Content =
    String


type Note
    = Note Name Content


getContent : Note -> String
getContent note =
    case note of
        Note _ c ->
            c


getName : Note -> String
getName note =
    case note of
        Note "" _ ->
            "Anonymous"

        Note n _ ->
            n
