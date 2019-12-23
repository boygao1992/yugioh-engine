module Phase
  ( BattlePhase(..)
  , DamageStep(..)
  , Phase(..)
  ) where

-- https://yugioh.fandom.com/wiki/Phase
data Phase
  = DrawPhase
  | StandbyPhase
  | MainPhase1
  | BattlePhase BattlePhase
  | MainPhase2
  | EndPhase

-- https://yugioh.fandom.com/wiki/Battle_Phase
data BattlePhase
  = StartStep
  | BattleStep
  | DamageStep DamageStep
  | EndStep

-- https://www.yugioh-card.com/uk/gameplay/damage.html
-- https://yugioh.fandom.com/wiki/Damage_Step
data DamageStep
  = StartOfTheDamageStep
  | BeforeDamageCalculation
  | DamageCalculation
  | AfterDamageCalculation
  | EndOfTheDamageStep
