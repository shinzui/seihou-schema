-- | Module dependency with optional variable bindings.
--
-- Required fields (no default): module
-- Usage: Dependency::{ module = "nix-base" }
-- External registry: Dependency::{ module = "base", source = Some "https://host/registry.git" }
-- No source means the declaring registry during install. Upgrade Seihou before
-- adopting this schema; legacy records and bare names remain supported by the CLI.
-- With vars: Dependency::{ module = "base", vars = [{ name = "x", value = "y" }] }

{ Type =
    { module : Text
    , source : Optional Text
    , vars : List { name : Text, value : Text }
    }
, default =
    { source = None Text
    , vars = [] : List { name : Text, value : Text }
    }
}
