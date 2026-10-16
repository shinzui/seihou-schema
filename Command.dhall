-- | Explicit application or repeatable checkout execution.
-- Checkout commands are recorded as resolved intent and repeat on seihou sync.
-- They must be repeatable and keep intended writes outside managed/tracked state.
-- Required: action. Legacy { run, workDir, when } records remain runtime-readable.
-- Usage: Command::{ action = Command.Action.Apply "echo applied" }

let Action = < Apply : Text | Checkout : Text >

in  { Type =
        { action : Action
        , workDir : Optional Text
        , when : Optional Text
        }
    , default = { workDir = None Text, when = None Text }
    , Action = Action
    }
