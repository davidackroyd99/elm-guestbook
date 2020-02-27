module Note exposing (Content, Name, Note(..), Timestamp, noteHtml)

import Derberos.Date.Core exposing (DateRecord, posixToCivil)
import Html exposing (Attribute, Html, button, div, h1, input, p, text)
import Html.Attributes exposing (..)
import Time exposing (Posix)


type alias Name =
    String


type alias Content =
    String


type alias Timestamp =
    Posix


type Note
    = Note Name Content Timestamp


getPosixString : Posix -> String
getPosixString dp =
    getDateString (posixToCivil dp)


getDateString : DateRecord -> String
getDateString dr =
    let
        year =
            String.fromInt dr.year

        month =
            String.fromInt dr.month

        day =
            String.fromInt dr.day
    in
    String.join "/" [ day, month, year ]


noteHtml : Note -> Html msg
noteHtml note =
    case note of
        Note name content ts ->
            div [ class "note-wrapper" ]
                [ p [ class "note-date" ] [ text ("Date: " ++ getPosixString ts) ]
                , p [ class "note-name" ] [ text ("Name: " ++ name) ]
                , p [ class "note-content" ] [ text ("Message: " ++ content) ]
                ]
