-- | Named module composition (recipe).
--
-- A recipe is a reusable, named combination of modules with optional
-- pre-configured variable bindings. Running a recipe expands it into its
-- constituent modules and executes the entire composition in one pass.
--
-- Required fields (no default): name, modules
-- Usage: Recipe::{ name = "haskell-library", modules = [ Dependency::{ module = "nix-flake" }, Dependency::{ module = "cabal-ghc" } ] }

let Dependency = ./Dependency.dhall

let VarDecl = ./VarDecl.dhall

let Prompt = ./Prompt.dhall

in  { Type =
        { name : Text
        , version : Optional Text
        , description : Optional Text
        , modules : List Dependency.Type
        , vars : List VarDecl.Type
        , prompts : List Prompt.Type
        }
    , default =
        { version = None Text
        , description = None Text
        , vars = [] : List VarDecl.Type
        , prompts = [] : List Prompt.Type
        }
    }
