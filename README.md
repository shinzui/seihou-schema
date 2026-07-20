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
- `BlueprintMigration` -- Agent-guided library upgrade edge
- `CommandVar` -- Command-derived variable
- `Blueprint` -- Agent-driven scaffolding definition
- `AgentPrompt` -- Reusable agent-session prompt definition

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
gaps. The consumer supplies the current and target versions explicitly with
`seihou agent migrate my-library --from 1.0.0 --to 3.0.0`. These prompts guide
an agent; they are distinct from deterministic module `MigrationOp` records.
