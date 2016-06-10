module App.D3 where

import Prelude ((+), (-), const, show, bind, return)
import Signal.Channel (CHANNEL, Channel)
import Data.Tuple
import Pux.Html (Html, div, h1, svg, text, circle, g)
import Pux.Html.Events (onClick)
import Pux.Html.Attributes (id_, r, style)

import App.D3.Actions
import App.D3.State
import App.D3.Render (init)

update :: D3Action -> State -> State
update Render state = state -- layout the data

view :: State -> Html D3Action
view state =
  div
    []
    [ svg [] [ circle [r "40px", style [Tuple "fill" "#c6dbef", Tuple "cx" "50", Tuple "cy" "50"]] [text "D3 SVG goes here"] ]
    ]
