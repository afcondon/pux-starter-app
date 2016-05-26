module App.D3 where

import Prelude ((+), (-), const, show)
import Data.Tuple
import Pux.Html (Html, div, h1, svg, text, circle, g)
import Pux.Html.Events (onClick)
import Pux.Html.Attributes (classID, r, style)
import Graphics.D3.Base

data Action = Render

type State = Int  -- this should be the handle to the D3 SVG or something

init :: State
init = 211 -- initialize the D3 SVG

update :: Action -> State -> State
update Render state = state -- layout the data

view :: State -> Html Action
view state =
  div
    []
    [ svg [] [ circle [r "40px", style [Tuple "fill" "#c6dbef", Tuple "cx" "50", Tuple "cy" "50"]] [text "D3 SVG goes here"] ]
    ]
