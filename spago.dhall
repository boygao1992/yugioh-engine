{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "yugioh-engine"
, dependencies =
    [ "effect"
    , "console"
    , "domain"
    , "psci-support"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
