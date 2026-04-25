-- | A single migration that moves a project from module version `from` to
-- module version `to`. The `ops` list is applied in order.
--
-- Migrations are linear and contiguous: the planner picks migrations whose
-- `from` matches the currently installed version and chains them until
-- `to` reaches the target version. There is no graph search; ambiguous
-- starts (two migrations declaring the same `from`) are an error.
--
-- Required fields (no default): from, to
-- Default: ops = [] (no operations)
--
-- Usage:
--   let S = ./package.dhall
--   in  S.Migration::{
--         from = "1.0.0",
--         to = "2.0.0",
--         ops =
--           [ S.MigrationOp.MoveDir { src = "app", dest = "src" }
--           , S.MigrationOp.DeleteFile { path = "Setup.hs" }
--           ]
--       }

let MigrationOp = ./MigrationOp.dhall

in  { Type =
        { from : Text
        , to : Text
        , ops : List MigrationOp
        }
    , default = { ops = [] : List MigrationOp }
    }
