-- | One base recipe selected at its source default-branch HEAD.
-- The interval is inclusive at minimum and exclusive at before.
{ Type =
    { recipe : Text
    , source : Optional Text
    , versionRange : Optional { minimum : Text, before : Text }
    }
, default =
    { source = None Text
    , versionRange = None { minimum : Text, before : Text }
    }
}
