{-
The `domain` codifies all of our business logic.

There should be very few dependencies in this package.
Interacting with `purescript-aff` and `purescript-effect` is expected.
However, nothing should be using any low-level effectful APIs, like
`purescript-halogen` or `purescript-mysql`.
-}
{ name =
    "domain"
, dependencies =
    [ "aff"
    , "either"
    , "prelude"
    , "variant"
    ]
, packages =
    ../packages.dhall
, sources =
    [ "src/**/*.purs" ]
}
