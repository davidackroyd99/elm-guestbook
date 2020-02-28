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


formatName : Name -> String
formatName name =
    case name of
        "" ->
            "Anonymous"

        nameGiven ->
            nameGiven


noteHtml : Note -> Html msg
noteHtml note =
    case note of
        Note name content ts ->
            div [ class "note-wrapper" ]
                [ p [ class "note-info" ] [ text ("On the " ++ getPosixString ts ++ ", " ++ formatName name ++ " wrote:") ]
                , p [ class "note-content" ] [ text content ]
                ]
