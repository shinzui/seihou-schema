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
        }
    , BlueprintFile = BlueprintFile
    , Launch = Launch
    }
