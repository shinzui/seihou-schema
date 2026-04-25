let Schema =
      https://raw.githubusercontent.com/shinzui/mori-schema/02a8a876f6f7074510eb03071116d57f5529378b/package.dhall
        sha256:a19f5dd9181db28ba7a6a1b77b5ab8715e81aba3e2a8f296f40973003a0b4412

in  Schema.Project::{
    , project = Schema.ProjectIdentity::{
      , name = "seihou-schema"
      , namespace = "shinzui"
      , type = Schema.PackageType.Library
      , language = Schema.Language.Dhall
      , lifecycle = Schema.Lifecycle.Active
      , description = Some
          "Dhall schema package for seihou modules (Module, Step, Recipe, etc.)"
      }
    , repos = [ Schema.Repo::{
        , name = "seihou-schema"
        , github = Some "shinzui/seihou-schema"
        }
      ]
    , packages =
      [ Schema.Package::{
        , name = "seihou-schema"
        , type = Schema.PackageType.Library
        , language = Schema.Language.Dhall
        , path = Some "."
        , description = Some
            "Record types with defaults for authoring seihou modules"
        }
      ]
    }
