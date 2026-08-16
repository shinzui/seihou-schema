-- | One agent-guided library migration declared by a blueprint.
--
-- `from` and `to` are dotted numeric versions and `prompt` contains the
-- source-change instructions for exactly this edge.
--
-- `entails` names exact edges of *other* blueprints that crossing this edge
-- requires. Seihou resolves each named blueprint, expands its edge (and
-- anything that edge itself entails) recursively, and runs the entailed edges
-- first, in declaration order, before this one. Each entailed edge runs with
-- its own blueprint's reference files, allowed tools, and variables, and its
-- receipt is recorded under its own blueprint's identity — so a project that
-- also runs that blueprint directly crosses the shared edge only once. See
-- ./EntailedEdge.dhall.
--
-- Required fields (no default): from, to, prompt
-- Default: entails = [] (this edge implies no other blueprint's edges)
--
-- Usage:
--   let S = ./package.dhall
--   in  S.BlueprintMigration::{
--         from = "1.0.0",
--         to = "2.0.0",
--         prompt = ./migrations/1-to-2.md as Text
--       }
--
--   let S = ./package.dhall
--   in  S.BlueprintMigration::{
--         from = "2.4.0",
--         to = "3.0.0",
--         prompt = ./migrations/2-4-to-3.md as Text,
--         entails =
--           [ S.EntailedEdge::{
--               blueprint = "kiroku-upgrade",
--               from = "1.9.0",
--               to = "2.0.0"
--             }
--           ]
--       }

let EntailedEdge = ./EntailedEdge.dhall

in  { Type =
        { from : Text
        , to : Text
        , prompt : Text
        , entails : List EntailedEdge.Type
        }
    , default = { entails = [] : List EntailedEdge.Type }
    }
