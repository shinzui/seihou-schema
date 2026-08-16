-- | Seihou Blueprint Schema
--
-- A blueprint is a Dhall record describing an agent-driven runnable.
-- Unlike a Module, a Blueprint produces non-deterministic output — its
-- prompt and reference files guide an AI coding agent that ultimately
-- decides what files are written. Blueprints cannot be directly run
-- via `seihou run`; use `seihou agent run BLUEPRINT` instead (EP-31).
--
-- A blueprint may also declare optional launch preferences (`launch`) naming
-- the agent provider, model, and reasoning effort its prompt was written for.
-- Declared values override the invoking user's configuration files but lose to
-- a command-line flag or a SEIHOU_AGENT_* environment variable. See
-- ./Launch.dhall.
--
-- `versionProbe` is a shell command seihou runs in the project directory to
-- discover which version of the library this project currently declares. Its
-- standard output, trimmed, must be a dotted numeric version. It supplies the
-- default `--to` for `seihou agent migrate`: the normal workflow is to bump the
-- dependency and then migrate the source up to it, so the version the project
-- now declares is the target. Seihou stays language-agnostic by never guessing
-- the command — only the blueprint's author knows where the version lives.
--
--   versionProbe = Some "jq -r .dependencies.keiro package.json"
--   versionProbe = Some "nix eval --raw .#keiroVersion"
--
-- Required fields (no default): name, prompt
-- Usage:
--   let S = ./package.dhall
--   in S.Blueprint::{ name = "payments-service", prompt = ./prompt.md as Text }

let VarDecl = ./VarDecl.dhall

let Prompt = ./Prompt.dhall

let Dependency = ./Dependency.dhall

let BlueprintMigration = ./BlueprintMigration.dhall

let Launch = ./Launch.dhall

let BlueprintFile =
      { Type = { src : Text, description : Optional Text }
      , default = { description = None Text }
      }

in  { Type =
        { name : Text
        , version : Optional Text
        , description : Optional Text
        , prompt : Text
        , vars : List VarDecl.Type
        , prompts : List Prompt.Type
        , baseModules : List Dependency.Type
        , files : List BlueprintFile.Type
        , allowedTools : Optional (List Text)
        , tags : List Text
        , migrations : List BlueprintMigration.Type
        , launch : Optional Launch.Type
        , versionProbe : Optional Text
        }
    , default =
        { version = None Text
        , description = None Text
        , vars = [] : List VarDecl.Type
        , prompts = [] : List Prompt.Type
        , baseModules = [] : List Dependency.Type
        , files = [] : List BlueprintFile.Type
        , allowedTools = None (List Text)
        , tags = [] : List Text
        , migrations = [] : List BlueprintMigration.Type
        , launch = None Launch.Type
        , versionProbe = None Text
        }
    , BlueprintFile = BlueprintFile
    , Launch = Launch
    }
