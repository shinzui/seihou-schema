-- | A reference from a module or recipe to a judgement it activates.
--
-- Applying the module or recipe with seihou run also adopts each referenced
-- judgement, previewed and with the same consent as seihou run NAME. The
-- name resolves through the ordinary search paths (project modules, user
-- modules, the install cache), then the catalogue built into seihou.
-- `source` names the registry that provides it, for installation; `when` is
-- an ordinary condition over the module's variables.
--
-- Required fields (no default): name
-- Usage: JudgementRef::{ name = "security-review" }
{ Type = { name : Text, source : Optional Text, when : Optional Text }
, default = { source = None Text, when = None Text }
}
