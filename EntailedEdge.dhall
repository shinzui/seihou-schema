-- | One migration edge in another blueprint that this edge entails.
--
-- Declaring an entailed edge means: a project crossing the declaring edge
-- must also cross this exact edge of the named blueprint. Seihou resolves
-- the named blueprint the same way `seihou agent migrate` resolves the
-- blueprint you name on the command line, finds the edge whose `from` and
-- `to` match exactly, and runs it before the declaring edge.
--
-- The receipt for an entailed edge is recorded under the *entailed*
-- blueprint's identity, so a project that also runs that blueprint directly
-- crosses the edge only once.
--
-- Use this when a breaking change reaches consumers through an intermediary:
-- a library `keiro` that absorbs a breaking change from `kiroku` declares
-- that its own `2.4.0 -> 3.0.0` edge entails kiroku's `1.9.0 -> 2.0.0` edge,
-- so a project that depends on keiro alone still gets kiroku's upgrade
-- guidance without ever naming kiroku.
--
-- All fields are required.
--
-- Usage:
--   let S = ./package.dhall
--   in  S.EntailedEdge::{
--         blueprint = "kiroku-upgrade",
--         from = "1.9.0",
--         to = "2.0.0"
--       }

{ Type = { blueprint : Text, from : Text, to : Text }
, default = {=}
}
