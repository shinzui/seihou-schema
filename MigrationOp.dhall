-- | Migration operation — one filesystem operation applied during a
-- module-version migration.
--
-- Variants:
--   MoveFile   : rename a single file
--   MoveDir    : rename a directory (and all contained files in the manifest)
--   DeleteFile : delete a single file
--   DeleteDir  : recursively delete a directory
--   RunCommand : execute a shell command (escape hatch; manifest is not
--                rewritten by this op — the author is responsible for any
--                resulting drift)
--
-- Construct values via the union constructors:
--   S.MigrationOp.MoveFile { src = "old/Path.hs", dest = "new/Path.hs" }
--   S.MigrationOp.MoveDir { src = "app", dest = "src" }
--   S.MigrationOp.DeleteFile { path = "Setup.hs" }
--   S.MigrationOp.DeleteDir { path = "old-dir" }
--   S.MigrationOp.RunCommand { run = "rm -f foo", workDir = None Text }

< MoveFile : { src : Text, dest : Text }
| MoveDir : { src : Text, dest : Text }
| DeleteFile : { path : Text }
| DeleteDir : { path : Text }
| RunCommand : { run : Text, workDir : Optional Text }
>
