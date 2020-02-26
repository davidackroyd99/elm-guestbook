module Note exposing (..)

type alias Name = String
type alias Content = String
type Note 
    = Named Name Content 
    | Anon Content 

getContent : Note -> String
getContent note = case note of
    (Named _ c) -> c
    (Anon c) -> c

getName : Note -> String
getName note = case note of
    (Named n _) -> n
    (Anon _) -> "Anonymous"