-- | Seihou Agent Launch Settings
--
-- Optional launch preferences an agent-driven artifact (a Blueprint or an
-- AgentPrompt) can declare for the agent session it starts. Every field is
-- optional; an omitted field means "let the invoking user's configuration
-- decide".
--
-- Declared values override the user's configuration files (project-local and
-- global `agent.*` keys) but lose to a `--provider` / `--model` / `--effort`
-- flag and to the SEIHOU_AGENT_* environment variables.
--
-- provider : claude-cli | codex-cli | anthropic | openai
-- model    : any provider-specific model name or alias
-- effort   : minimal | low | medium | high | xhigh | max
-- mode     : reserved; currently ignored by the runner
--
-- Usage:
--   let S = ./package.dhall
--   in S.Blueprint::{ name = "payments-service"
--                   , prompt = ./prompt.md as Text
--                   , launch = Some S.Launch::{ effort = Some "max" }
--                   }
{ Type =
    { provider : Optional Text
    , model : Optional Text
    , effort : Optional Text
    , mode : Optional Text
    }
, default =
  { provider = None Text
  , model = None Text
  , effort = None Text
  , mode = None Text
  }
}
