import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , age : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" "" ""


-- UPDATE

type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Age age ->
      { model | age = age }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "text", placeholder "Age", onInput Age ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if not (String.all Char.isDigit model.age) then
        ("red", "Age must be a number")
      else if String.length model.password < 6 then
        ("red", "Password must be at least 6 characters")
      else if not (String.any Char.isUpper model.password) then
        ("red", "Password must have at least 1 uppercase letter")
      else if not (String.any Char.isLower model.password) then
        ("red", "Password must have at least 1 lowercase letter")
      else if not (String.any Char.isDigit model.password) then
        ("red", "Password must have at least 1 digit")
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
