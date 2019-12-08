module Game where

import Prelude
import Zone (Zone)

type State
  = { card :: Array CardState
    , lp ::
      { bottomPlayer :: Int
      , topPlayer :: Int
      }
    }

type CardState
  = { location :: Zone
    , static :: Unit
    , events :: Unit
    }
