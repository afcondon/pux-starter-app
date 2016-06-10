module App.D3.Render where

import Prelude (return, bind)
import DOM (DOM)
import Signal.Channel (CHANNEL, Channel)
import Control.Monad.Eff (Eff)
import Graphics.D3.Base
import Graphics.D3.Util ((..), (...))
import Graphics.D3.Selection

import App.Actions
import App.D3.State
import App.D3.Actions

init :: forall eff.  Channel Action -> Eff (d3::D3,dom::DOM|eff) State
init chan = do
  svg <- rootSelect "d3chart"
    .. append "svg"
    .. append "g"
    .. attr "id" "lsmOuterGroup"

  return { svgS: svg
         , channel: chan }
