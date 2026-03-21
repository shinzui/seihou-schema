-- | A single removal step describing how to reverse one effect of a module.
--
-- action: "remove-file" | "remove-section" | "rewrite-file"
-- dest: target file path (supports {{var}} placeholders)
-- src: for rewrite-file, path to a Dhall function in files/
--
-- Required fields (no default): action, dest
-- Usage: RemovalStep::{ action = "remove-file", dest = "README.md" }

{ Type =
    { action : Text
    , dest : Text
    , src : Optional Text
    }
, default =
    { src = None Text
    }
}
