-- | Generation step — describes a file to generate.
--
-- lifecycle: omitted/managed outputs stay managed; seed outputs are handed to the project.
-- Use strategy = "symlink" with lifecycle = Some "checkout" for project directory links.
-- Required fields (no default): strategy, src, dest
-- Usage: Step::{ strategy = "template", src = "README.md.tpl", dest = "README.md" }

{ Type =
    { strategy : Text
    , src : Text
    , dest : Text
    , when : Optional Text
    , lifecycle : Optional Text
    , patch : Optional Text
    }
, default =
    { when = None Text
    , lifecycle = None Text
    , patch = None Text
    }
}
