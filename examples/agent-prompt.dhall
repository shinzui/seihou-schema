let S = ../package.dhall

in  S.AgentPrompt::{
    , name = "review-changes"
    , prompt = "Review the current repository and summarize risky changes."
    , commandVars =
      [ S.CommandVar::{ name = "git.branch", run = "git branch --show-current" }
      ]
    , files =
      [ S.AgentPrompt.PromptFile::{
        , src = "README.md"
        , description = Some "Repository overview"
        }
      ]
    , launch = Some S.AgentPrompt.Launch::{ provider = Some "codex-cli" }
    }
