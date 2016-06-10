module App.D3.State where

import Signal.Channel (CHANNEL, Channel)
import Graphics.D3.Selection
import App.Actions
import App.D3.Actions

type State = { svgS        :: (Selection Void)
             , channel     :: Channel Action
             }
