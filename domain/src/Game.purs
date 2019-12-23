module Game
  ( Card
  , CardDatabaseHandle
  , CardEvent(..)
  , CardNumber
  , CardState
  , Command(..)
  , Config
  , Effect(..)
  , Event(..)
  , EventStoreHandle
  , GameState
  , StateCacheHandle
  ) where

import Prelude
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Zone (Player, Zone)

type Config
  = { cardDatabase :: CardDatabaseHandle
    , eventStore :: EventStoreHandle
    , stateCache :: StateCacheHandle
    }

type CardDatabaseHandle
  = { get :: CardNumber -> Aff (Maybe Card)
    , search :: Unit
    }

type EventStoreHandle
  = { read :: Aff (Array Event)
    , write :: Event -> Aff Unit
    }

type StateCacheHandle
  = { read :: Aff GameState
    , write :: GameState -> Aff GameState
    }

type GameState
  = { card :: Array CardState
    , lp ::
      { bottomPlayer :: Int
      , topPlayer :: Int
      }
    }

type CardState
  = { static :: Card
    , location :: Zone
    , events :: Array CardEvent
    }

type Card
  = { number :: CardNumber
    , effects :: Array Effect
    }

type CardNumber
  = String

data CardEvent

-- https://yugipedia.com/wiki/Effect
-- https://yugipedia.com/wiki/Monster_effect
-- https://yugipedia.com/wiki/Quick_Effect
-- https://yugipedia.com/wiki/Unclassified_Effect
-- https://yugipedia.com/wiki/Pendulum_Effect
-- https://yugipedia.com/wiki/Lingering_effect
data Effect
  -- https://yugipedia.com/wiki/Continuous_Effect
  = ContinuousEffect
  -- https://yugipedia.com/wiki/Flip_effect
  | FlipEffect
  -- https://yugipedia.com/wiki/Ignition_Effect
  | IgnitionEffect
  -- https://yugipedia.com/wiki/Trigger_Effect
  -- https://yugipedia.com/wiki/Mandatory_effect
  | TriggerEffect { conditions :: Array Unit, mandatory :: Boolean }

-- intent
-- should be verified by the rule engine
data Command
  = CardTranslate { from :: Zone, to :: Zone }
  | DeckLoad (Array CardNumber)
  | DeckRandomize
  | DeckDraw Int
  | LPInit
  | LPIncrease { player :: Player, amount :: Int }
  | LPDecrease { player :: Player, amount :: Int }

data Event
  = CardTranslated { from :: Zone, to :: Zone }
  | DeckLoaded (Array CardState)
  | DeckRandomized { from :: Array CardState, to :: Array CardState }
  | DeckDrew Int
  | LPInited
  | LPIncreased { player :: Player, amount :: Int }
  | LPDecreased { player :: Player, amount :: Int }
