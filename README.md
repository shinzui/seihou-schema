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
