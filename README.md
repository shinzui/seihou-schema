# seihou-schema

Dhall schema package for [seihou](https://github.com/shinzui/seihou) modules.

## Usage

Import the schema in your `module.dhall`:

    let S =
          https://raw.githubusercontent.com/shinzui/seihou-schema/<commit>/package.dhall
            sha256:<hash>

    in  S.Module::{
        , name = "my-module"
        , description = Some "My module description"
        }

The package exports record types with defaults for use with Dhall's record completion (`::`) operator:

- `Module` -- Top-level module definition
- `VarDecl` -- Variable declaration
- `VarExport` -- Variable export
- `Prompt` -- User prompt
- `Step` -- Generation step
- `Command` -- Command execution
- `Dependency` -- Module dependency
- `MigrationOp` -- Module migration operation
- `Migration` -- Module version migration
- `EntailedEdge` -- Reference to an exact migration edge of another blueprint
- `BlueprintMigration` -- Agent-guided library upgrade edge
- `CommandVar` -- Command-derived variable
- `Launch` -- Agent launch preferences declared by an artifact
- `Blueprint` -- Agent-driven scaffolding definition
- `AgentPrompt` -- Reusable agent-session prompt definition

## Declaring launch settings

A blueprint or agent prompt can declare the agent provider, model, and
reasoning effort its prompt was written for:

```dhall
in  S.Blueprint::{
    , name = "payments-service"
    , prompt = ./prompt.md as Text
    , launch = Some S.Launch::{
      , provider = Some "claude-cli"
      , model = Some "claude-opus-4-8"
      , effort = Some "max"
      }
    }
```

Every field is optional; an omitted field means "let the invoking user's
configuration decide". `provider` is one of `claude-cli`, `codex-cli`,
`anthropic`, `openai`; `effort` is one of `minimal`, `low`, `medium`, `high`,
`xhigh`, `max`; `model` is free-form. A fourth field, `mode`, is reserved and
currently ignored by the runner.

Declared values override the invoking user's configuration files (the
project-local `.seihou/config.dhall` and the global `~/.config/seihou/config.dhall`,
per-command keys included) but lose to a `--provider` / `--model` / `--effort`
flag and to the `SEIHOU_AGENT_*` environment variables. The blueprint author
sets the sane default; the person at the keyboard keeps the last word.

## Blueprint library migrations

A blueprint can ship ordered, agent-guided upgrade instructions for consumers
of a library. Each edge uses dotted numeric versions and a Markdown prompt:

```dhall
in  S.Blueprint::{
    , name = "my-library"
    , version = Some "3.0.0"
    , prompt = "Inspect the project's real use of my-library before editing."
    , migrations =
      [ S.BlueprintMigration::{
        , from = "1.0.0"
        , to = "2.0.0"
        , prompt = ./migrations/1-to-2.md as Text
        }
      , S.BlueprintMigration::{
        , from = "2.5.0"
        , to = "3.0.0"
        , prompt = ./migrations/2-5-to-3.md as Text
        }
      ]
    }
```

Seihou selects in-window edges in ascending `from` order and permits version
gaps. The consumer can supply the window explicitly with
`seihou agent migrate my-library --from 1.0.0 --to 3.0.0`, or let seihou infer
it — see [Declaring a version probe](#declaring-a-version-probe). These prompts
guide an agent; they are distinct from deterministic module `MigrationOp`
records.

## Declaring a version probe

`versionProbe` is a shell command seihou runs in the project directory to
discover which version of the library that project currently declares. Its
standard output — trimmed, last non-empty line — must be a dotted numeric
version:

```dhall
in  S.Blueprint::{
    , name = "my-library"
    , version = Some "3.0.0"
    , prompt = ./prompt.md as Text
    , versionProbe = Some "jq -r .dependencies.my-library package.json"
    }
```

It supplies the default `--to` for `seihou agent migrate`, because the normal
workflow is to bump the dependency and then migrate the source up to it. Seihou
stays language-agnostic by never guessing the command: only the blueprint's
author knows where the version lives in their ecosystem.

A probe must be read-only and fast, and must work from the project root. It runs
under `--debug` too, so debug planning matches a real run.

## Entailed edges across a library cohort

When a breaking change reaches consumers through an intermediary library, the
consumer knows only the version of the library they actually declare. An edge
can therefore name exact edges of *other* blueprints that crossing it requires:

```dhall
in  S.Blueprint::{
    , name = "keiro-upgrade"
    , version = Some "3.0.0"
    , prompt = ./prompt.md as Text
    , migrations =
      [ S.BlueprintMigration::{
        , from = "2.4.0"
        , to = "3.0.0"
        , prompt = ./migrations/2-4-to-3.md as Text
        , entails =
          [ S.EntailedEdge::{
            , blueprint = "kiroku-upgrade"
            , from = "1.9.0"
            , to = "2.0.0"
            }
          ]
        }
      ]
    }
```

`seihou agent migrate keiro-upgrade --from 2.4.0 --to 3.0.0` then runs kiroku's
`1.9.0 -> 2.0.0` edge first — with kiroku's own reference files, allowed tools,
and variables — and keiro's edge second. Expansion is recursive, so an entailed
edge may entail further edges; a cycle is an authoring error. The entailed
edge's receipt is recorded under `kiroku-upgrade`, so a project that also runs
`seihou agent migrate kiroku-upgrade` directly crosses that edge exactly once.
