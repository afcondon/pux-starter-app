module App.Layout where

import App.Counter as Counter
import App.D3      as D3Chart
import App.Routes (Route(Home, NotFound, D3))
import Prelude (($), map, const)
import Pux.Html (Html, div, h1, p, text, button)
import Pux.Html.Events (onClick)

data Action
  = Child   (Counter.Action)
  | D3Child (D3Chart.Action)
  | PageView Route

type State =
  { route :: Route
  , count :: Counter.State
  , d3state :: D3Chart.State }

init :: State
init =
  { route: NotFound
  , count: Counter.init
  , d3state: D3Chart.init }

update :: Action -> State -> State
update (PageView route) state = state { route = route }
update (Child action) state   = state { count = Counter.update action state.count }
update (D3Child action) state = state { d3state = D3Chart.update action state.d3state }

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
