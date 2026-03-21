-- | Removal specification for a module.
--
-- steps: ordered list of removal operations (remove-file, remove-section, rewrite-file)
-- commands: shell commands to run after removal steps
--
-- Usage:
--   let S = ./package.dhall
--   in S.Removal::{
--     , steps = [ S.RemovalStep::{ action = "remove-file", dest = "README.md" } ]
--     }

let RemovalStep = ./RemovalStep.dhall

let Command = ./Command.dhall

in  { Type =
        { steps : List RemovalStep.Type
        , commands : List Command.Type
        }
    , default =
        { steps = [] : List RemovalStep.Type
        , commands = [] : List Command.Type
        }
    }
