module Main exposing (..)

import Browser
import Html exposing (Html, Attribute, div, input, text, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Note exposing (..)

main =
    Browser.sandbox { init = init, update = update, view = view }

type alias Model = 
    {
        notes : List Note
    }

init : Model
init =
    {
        notes = [Named "David" "Hello", Named "David" "Hello2", Anon "Hello3"]
    }

type Msg 
    = AddNote Note

update : Msg -> Model -> Model
update msg model = 
    -- case msg of
    --     AddNote newNote ->
    --         { model | notes = newNote}
    model

noteHtml : Note -> Html Msg
noteHtml note =
    div []
    [
        p [] [text ("Name: " ++ (getName note))],
        p [] [text ("Message: " ++ (getContent note))]
    ]

view : Model -> Html Msg
view model = 
    div [] (List.map noteHtml model.notes)