module Main exposing (..)

import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Note exposing (..)

main =
    Browser.sandbox { init = init, update = update, view = view }

type alias Model = 
    {
        notes : Note
    }

init : Model
init =
    {
        notes = Named "David" "Hello"
    }

type Msg 
    = AddNote Note

update : Msg -> Model -> Model
update msg model = 
    case msg of
        AddNote newNote ->
            { model | notes = newNote}

view : Model -> Html Msg
view model = 
    div []
    [
        input [ placeholder "Name", value (getName model.notes) ] []
        , input [ placeholder "Your message", value (getContent model.notes) ] []
    ]