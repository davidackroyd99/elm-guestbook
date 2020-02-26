module Main exposing (..)

import Browser
import Html exposing (Html, Attribute, div, input, text, p, h1, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

import Note exposing (..)

main =
    Browser.sandbox { init = init, update = update, view = view }

type alias Model = 
    {
        newName : String,
        newContent : String,
        notes : List Note
    }

init : Model
init =
    {
        newName = "",
        newContent = "",
        notes = []
    }

type Msg 
    = UpdateName String
    | UpdateContent String
    | AddNote

update : Msg -> Model -> Model
update msg model = 
    case msg of
        AddNote ->
            { model | notes = (Note model.newName model.newContent) :: model.notes}
        UpdateName name ->
            { model | newName = name}
        UpdateContent content ->
            { model | newContent = content}

noteHtml : Note -> Html Msg
noteHtml note =
    div []
    [
        p [] [text ("Name: " ++ (getName note))],
        p [] [text ("Message: " ++ (getContent note))]
    ]

view : Model -> Html Msg
view model = 
    div []
    [
        h1 [] [text "My Online Guestbook"],
        input [placeholder "Your Name", onInput UpdateName] [],
        input [placeholder "Your Message", onInput UpdateContent] [],
        button [onClick AddNote] [text "Submit"],
        div [] (List.map noteHtml model.notes)
    ]