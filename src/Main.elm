module Main exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, h1, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Note exposing (..)
import Task
import Time exposing (Posix)


main =
    Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }


type alias Model =
    { newName : Name
    , newContent : Content
    , timeZone : Time.Zone
    , notes : List Note
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { newName = ""
      , newContent = ""
      , notes = []
      , timeZone = Time.utc
      }
    , Task.perform AdjustTimeZone Time.here
    )


type Msg
    = UpdateName Name
    | UpdateContent Content
    | AddNote
    | AddNoteWithTimestamp Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddNote ->
            ( model, Task.perform AddNoteWithTimestamp Time.now )

        AddNoteWithTimestamp timeNow ->
            ( { model | notes = Note model.newName model.newContent timeNow :: model.notes }, Cmd.none )

        UpdateName name ->
            ( { model | newName = name }, Cmd.none )

        UpdateContent content ->
            ( { model | newContent = content }, Cmd.none )

        AdjustTimeZone zone ->
            ( { model | timeZone = zone }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "My Online Guestbook" ]
        , input [ placeholder "Your Name", onInput UpdateName ] []
        , input [ placeholder "Your Message", onInput UpdateContent ] []
        , button [ onClick AddNote ] [ text "Submit" ]
        , div [] (List.map noteHtml model.notes)
        ]
