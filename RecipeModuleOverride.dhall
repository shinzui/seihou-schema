-- | Change literal keys on one inherited member without adding an instance.
{ Type = { module : Text, vars : List { name : Text, value : Text } }
, default = { vars = [] : List { name : Text, value : Text } }
}
