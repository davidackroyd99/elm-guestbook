module Main exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, h1, input, p, text, textarea)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Note exposing (..)
import Task
import Time exposing (Posix)


main =
    Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }


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


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddNote ->
            ( model
            , if not (String.isEmpty model.newContent) then
                Task.perform AddNoteWithTimestamp Time.now

              else
                Cmd.none
            )

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


view : Model -> Document Msg
view model =
    Document "My Online Guestbook"
        [ div [ class "content" ]
            [ div [ class "header" ] [ h1 [] [ text "My Online Guestbook" ] ]
            , div [ class "form" ]
                [ input [ class "form-field form-name", placeholder "Your Name", onInput UpdateName ] []
                , textarea [ class "form-field form-content", placeholder "Your Message", onInput UpdateContent ] []
                , button [ class "form-field form-submit", onClick AddNote ] [ text "Submit" ]
                ]
            , div [ class "note-list" ] (List.map noteHtml model.notes)
            ]
        ]
