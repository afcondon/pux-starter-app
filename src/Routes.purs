module App.Routes where

import Data.Functor ((<$))
import Control.Apply ((<*))
import Data.Maybe (fromMaybe)
import Prelude (($))
import Pux.Router (end, router, lit)
import Control.Alt ((<|>))

data Route = Home | D3 | NotFound

match :: String -> Route
match url = fromMaybe NotFound $ router url $
  D3 <$ (lit "d3") <* end
  <|>
  Home <$ end
