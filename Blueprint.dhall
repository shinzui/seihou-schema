-- | Seihou Blueprint Schema
--
-- A blueprint is a Dhall record describing an agent-driven runnable.
-- Unlike a Module, a Blueprint produces non-deterministic output — its
-- prompt and reference files guide an AI coding agent that ultimately
-- decides what files are written. Blueprints cannot be directly run
-- via `seihou run`; use `seihou agent run BLUEPRINT` instead (EP-31).
--
-- Required fields (no default): name, prompt
-- Usage:
--   let S = ./package.dhall
--   in S.Blueprint::{ name = "payments-service", prompt = ./prompt.md as Text }

let VarDecl = ./VarDecl.dhall

let Prompt = ./Prompt.dhall

let Dependency = ./Dependency.dhall

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
        }
    , BlueprintFile = BlueprintFile
    }
