module Note exposing (..)

import Time exposing(Posix)

type alias Name =
    String


type alias Content =
    String


type Note
    = Note Name Content Posix


getContent : Note -> String
getContent note =
    case note of
        Note _ c _ ->
            c


getName : Note -> String
getName note =
    case note of
        Note "" _ _ ->
            "Anonymous"

        Note n _ _ ->
            n

getDate : Note -> String
getDate note = 
    case note of
        Note _ _ p ->
            p