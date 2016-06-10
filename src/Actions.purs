module App.Actions where

import App.Counter as Counter
import App.Routes (Route(Home, NotFound, D3))
import App.D3.Actions as D3Chart

data Action
  = Child   (Counter.Action)
  | D3Child (D3Chart.D3Action)
  | PageView Route
  | Nop
