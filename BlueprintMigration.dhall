-- | One agent-guided library migration declared by a blueprint.
--
-- All fields are required. `from` and `to` are dotted numeric versions and
-- `prompt` contains the source-change instructions for exactly this edge.
--
-- Usage:
--   let S = ./package.dhall
--   in  S.BlueprintMigration::{
--         from = "1.0.0",
--         to = "2.0.0",
--         prompt = ./migrations/1-to-2.md as Text
--       }

{ Type = { from : Text, to : Text, prompt : Text }
, default = {=}
}
