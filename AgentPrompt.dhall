-- | Seihou Agent Prompt Schema
--
-- An agent prompt is a reusable agent-session template. It supplies a prompt
-- body, optional typed variables, optional command-derived variables, and
-- optional reference files without implying scaffolding semantics.
--
-- Required fields (no default): name, prompt
-- Usage:
--   let S = ./package.dhall
--   in S.AgentPrompt::{ name = "review-changes", prompt = ./prompt.md as Text }
let VarDecl = ./VarDecl.dhall

let Prompt = ./Prompt.dhall

let CommandVar = ./CommandVar.dhall

let PromptGuidance =
      { Type = { title : Text, body : Text, when : Optional Text }
      , default = { when = None Text }
      }

let PromptFile =
      { Type = { src : Text, description : Optional Text }
      , default.description = None Text
      }

let Launch =
      { Type =
          { provider : Optional Text
          , mode : Optional Text
          , model : Optional Text
          }
      , default = { provider = None Text, mode = None Text, model = None Text }
      }

in  { Type =
        { name : Text
        , version : Optional Text
        , description : Optional Text
        , prompt : Text
        , vars : List VarDecl.Type
        , prompts : List Prompt.Type
        , commandVars : List CommandVar.Type
        , guidance : List PromptGuidance.Type
        , files : List PromptFile.Type
        , allowedTools : Optional (List Text)
        , tags : List Text
        , launch : Optional Launch.Type
        }
    , default =
      { version = None Text
      , description = None Text
      , vars = [] : List VarDecl.Type
      , prompts = [] : List Prompt.Type
      , commandVars = [] : List CommandVar.Type
      , guidance = [] : List PromptGuidance.Type
      , files = [] : List PromptFile.Type
      , allowedTools = None (List Text)
      , tags = [] : List Text
      , launch = None Launch.Type
      }
    , PromptGuidance
    , PromptFile
    , Launch
    }
