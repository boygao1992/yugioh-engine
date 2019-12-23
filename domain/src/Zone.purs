module Zone
  ( Zone(..)
  , Shared(..)
  , ExtraMonster(..)
  , Player(..)
  , Private(..)
  , Monster(..)
  , BackRow(..)
  , SpellTrap(..)
  , Pendulum(..)
  , Direction(..)
  , linked
  ) where

data Zone
  = Shared Shared
  | Private Player Private

data Shared
  = ExtraMonster ExtraMonster

data ExtraMonster
  = EL
  | ER

data Player
  = BottomPlayer
  | TopPlayer

data Private
  = MainDeck
  | ExtraDeck
  | Hand
  | Monster { zone :: Monster, xyzMaterial :: Boolean }
  | BackRow BackRow
  | Graveyard
  | Banished

data Monster
  = M1
  | M2
  | M3
  | M4
  | M5

data BackRow
  = SpellTrap SpellTrap
  | Pendulum Pendulum

data SpellTrap
  = ST1
  | ST2
  | ST3

data Pendulum
  = PL
  | PR

data Direction
  = U
  | UR
  | R
  | BR
  | B
  | BL
  | L
  | UL

linked :: Direction -> Zone -> Zone -> Boolean
linked dir source target = case dir of
  U -> case source, target of
    Private BottomPlayer (Monster { zone: M2 }), Shared (ExtraMonster EL) -> true
    Private BottomPlayer (Monster { zone: M4 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M2 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M4 }), Shared (ExtraMonster EL) -> true
    _, _ -> false
  UR -> case source, target of
    Private BottomPlayer (Monster { zone: M1 }), Shared (ExtraMonster EL) -> true
    Private BottomPlayer (Monster { zone: M3 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M1 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M3 }), Shared (ExtraMonster EL) -> true
    _, _ -> false
  R -> case source, target of
    Private BottomPlayer (Monster { zone: M1 }), Private BottomPlayer (Monster { zone: M2 }) -> true
    Private BottomPlayer (Monster { zone: M2 }), Private BottomPlayer (Monster { zone: M3 }) -> true
    Private BottomPlayer (Monster { zone: M3 }), Private BottomPlayer (Monster { zone: M4 }) -> true
    Private BottomPlayer (Monster { zone: M4 }), Private BottomPlayer (Monster { zone: M5 }) -> true
    Private TopPlayer (Monster { zone: M1 }), Private TopPlayer (Monster { zone: M2 }) -> true
    Private TopPlayer (Monster { zone: M2 }), Private TopPlayer (Monster { zone: M3 }) -> true
    Private TopPlayer (Monster { zone: M3 }), Private TopPlayer (Monster { zone: M4 }) -> true
    Private TopPlayer (Monster { zone: M4 }), Private TopPlayer (Monster { zone: M5 }) -> true
    _, _ -> false
  BR -> case source, target of
    Shared (ExtraMonster EL), Private BottomPlayer (Monster { zone: M3 }) -> true
    Shared (ExtraMonster ER), Private BottomPlayer (Monster { zone: M5 }) -> true
    Shared (ExtraMonster ER), Private TopPlayer (Monster { zone: M3 }) -> true
    Shared (ExtraMonster EL), Private TopPlayer (Monster { zone: M5 }) -> true
    _, _ -> false
  B -> case source, target of
    Shared (ExtraMonster EL), Private BottomPlayer (Monster { zone: M2 }) -> true
    Shared (ExtraMonster ER), Private BottomPlayer (Monster { zone: M4 }) -> true
    Shared (ExtraMonster ER), Private TopPlayer (Monster { zone: M2 }) -> true
    Shared (ExtraMonster EL), Private TopPlayer (Monster { zone: M4 }) -> true
    _, _ -> false
  BL -> case source, target of
    Shared (ExtraMonster EL), Private BottomPlayer (Monster { zone: M1 }) -> true
    Shared (ExtraMonster ER), Private BottomPlayer (Monster { zone: M3 }) -> true
    Shared (ExtraMonster ER), Private TopPlayer (Monster { zone: M1 }) -> true
    Shared (ExtraMonster EL), Private TopPlayer (Monster { zone: M3 }) -> true
    _, _ -> false
  L -> case source, target of
    Private BottomPlayer (Monster { zone: M2 }), Private BottomPlayer (Monster { zone: M1 }) -> true
    Private BottomPlayer (Monster { zone: M3 }), Private BottomPlayer (Monster { zone: M2 }) -> true
    Private BottomPlayer (Monster { zone: M4 }), Private BottomPlayer (Monster { zone: M3 }) -> true
    Private BottomPlayer (Monster { zone: M5 }), Private BottomPlayer (Monster { zone: M4 }) -> true
    Private TopPlayer (Monster { zone: M2 }), Private TopPlayer (Monster { zone: M1 }) -> true
    Private TopPlayer (Monster { zone: M3 }), Private TopPlayer (Monster { zone: M2 }) -> true
    Private TopPlayer (Monster { zone: M4 }), Private TopPlayer (Monster { zone: M3 }) -> true
    Private TopPlayer (Monster { zone: M5 }), Private TopPlayer (Monster { zone: M4 }) -> true
    _, _ -> false
  UL -> case source, target of
    Private BottomPlayer (Monster { zone: M3 }), Shared (ExtraMonster EL) -> true
    Private BottomPlayer (Monster { zone: M5 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M3 }), Shared (ExtraMonster ER) -> true
    Private TopPlayer (Monster { zone: M5 }), Shared (ExtraMonster EL) -> true
    _, _ -> false
