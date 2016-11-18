import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""


-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if conditions model then
        ("green", "OK")
      else
        ("red", "Passwords aren't good, but this is a bad error message!")
  in
    div [ style [("color", color)] ] [ text message ]

conditions : Model -> Bool
conditions model =
  String.length model.password >= 6
    && String.any Char.isUpper model.password
    && String.any Char.isLower model.password
    && String.any Char.isDigit model.password
    && model.password == model.passwordAgain
