module Main where

import App.Routes (match)
import App.Layout (Action(PageView, Nop), State, view, update)
import Control.Bind ((=<<))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Prelude (bind, return)
import Pux (App, Config, CoreEffects, fromSimple, renderToDOM)
import Pux.Router (sampleUrl)
import Signal ((~>), Signal)
import Signal.Channel (CHANNEL, subscribe, channel)
import Graphics.D3.Base (D3)

type AppEffects = (dom :: DOM)

-- | App configuration
config :: forall eff. State -> Eff (dom :: DOM, d3 :: D3| eff) (Config State Action AppEffects)
config state = do
  -- | Create a signal of URL changes.
  urlSignal <- sampleUrl
  -- | Map a signal of URL changes to PageView actions.
  let routeSignal = urlSignal ~> \r -> PageView (match r)
  -- | Create a new signal of Actions
  d3Input <- channel Nop
  -- | Create a channel from the Signal that can be given to D3 for "callback" actions
  -- | You could have a more refined set of Actions available to D3, here we're using entire set
  let d3Signal = subscribe d3Input :: Signal Action

  appState <- initialState d3Signal

  return
    { initialState: appState
    , update: fromSimple update
    , view: view
    , inputs: [routeSignal, d3Signal] }

-- | Entry point for the browser.
main :: State -> Eff (CoreEffects AppEffects) (App State Action)
main state = do
  app <- Pux.start =<< config state
  renderToDOM "#app" app.html
  -- | Used by hot-reloading code in support/index.js
  return app

-- | Entry point for the browser with pux-devtool injected.
debug :: State -> Eff (CoreEffects AppEffects) (App State (Pux.Devtool.Action Action))
debug state = do
  app <- Pux.Devtool.start =<< config state
  renderToDOM "#app" app.html
  -- | Used by hot-reloading code in support/index.js
  return app
