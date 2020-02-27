module Note exposing (..)

import Time exposing (Posix)
import Derberos.Date.Core exposing (DateRecord, posixToCivil)


type alias Name =
    String


type alias Content =
    String


type alias Timestamp =
    DateRecord


type Note
    = Note Name Content Timestamp
