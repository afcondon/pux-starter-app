module App.Layout where

import Prelude (($), map, const)
import Control.Monad.Eff (Eff())
import DOM (DOM)
import Pux.Html (Html, div, h1, p, text, button)
import Pux.Html.Events (onClick)
import Signal.Channel (CHANNEL, Channel)
import Graphics.D3.Base (D3)

import App.Counter as Counter
import App.Routes (Route(Home, NotFound, D3))
import App.Actions
import App.D3         as D3Chart
import App.D3.State   as D3Chart
import App.D3.Render  as D3Chart

type State =
  { route :: Route
  , count :: Counter.State
  , d3state :: D3Chart.State }

init :: Channel Action -> State -- forall e. Eff (d3 :: D3, dom :: DOM|e) State
init chan =
  { route: NotFound
  , count: Counter.init
  , d3state: D3Chart.init chan }

update :: Action -> State -> State
update (PageView route) state   = state { route = route }
update (Child action) state     = state { count = Counter.update action state.count }
update (D3Child d3action) state = state { d3state = D3Chart.update d3action state.d3state }
update Nop state                = state

view :: State -> Html Action
view state =
  div
    []
    [ h1 [] [ text "Pux Starter App" ]
    , div [] [ button [ onClick (const (PageView D3))] [text "D3"]
             , button [ onClick (const (PageView Home))] [text "Home"]
             ]
    , p [] [ text "Change src/Layout.purs and watch me hot-reload." ]
    , case state.route of
        Home -> map Child   $ Counter.view state.count
        D3   -> map D3Child $ D3Chart.view state.d3state
        NotFound -> App.NotFound.view state
    ]
