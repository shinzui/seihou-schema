-- | Command-derived variable schema.
--
-- A command variable declares a value that Seihou may obtain by running a
-- local command before rendering a prompt or another runnable artifact.
--
-- Required fields (no default): name, run
-- Usage:
--   let S = ./package.dhall
--   in S.CommandVar::{ name = "git.branch", run = "git branch --show-current" }
{ Type =
    { name : Text
    , run : Text
    , workDir : Optional Text
    , when : Optional Text
    , trim : Bool
    , maxBytes : Optional Natural
    }
, default =
  { workDir = None Text, when = None Text, trim = True, maxBytes = Some 4096 }
}
