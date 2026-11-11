-- | Seihou Judgement Schema
--
-- A judgement is a list of author-written yes/no checks that Seihou asks a
-- model about captured evidence (staged changes or a commit range), plus an
-- optional set of deterministic checks such as the secret scan.
--
-- Each check declares which answer is the concern (`concernWhen`, yes by
-- default), its enforcement, and two threshold pairs: `blockAt`/`passAt` for
-- the generative review and `gateBlockAt`/`gatePassAt` for the optional
-- judgment-only gate. Every threshold applies to the probability of the
-- concern, whichever answer that is, so a higher number is always worse. At or
-- above the block value the check blocks; at or below the pass value it may
-- pass; in between it needs human review. Equal values remove the band.
-- These probabilities are stated by a model, not calibrated measurements.
--
-- Required fields (no default): Judgement.name, Judgement.checks,
-- Check.name, Check.question, FindingCategory.name
--
-- Usage:
--   let S = ./package.dhall
--   in S.Judgement::{
--      , name = "docs-review"
--      , checks =
--        [ S.Check::{
--          , name = "stale-docs"
--          , question = "Does this change leave a documented behaviour out of date?"
--          }
--        ]
--      }
let Answer = < Yes | No >

let Enforcement = < Enforced | Advisory >

let Severity = < Info | Low | Medium | High | Critical >

let EvidenceScope = < StagedChanges | CommitRange >

let DeterministicCheck = < SecretScan >

let FindingCategory =
      { Type =
          { name : Text, severity : Severity, description : Optional Text }
      , default = { severity = Severity.Medium, description = None Text }
      }

let Check =
      { Type =
          { name : Text
          , question : Text
          , concernWhen : Answer
          , yesMeans : Optional Text
          , noMeans : Optional Text
          , categories : List FindingCategory.Type
          , enforcement : Enforcement
          , blockingSeverity : Severity
          , blockAt : Double
          , passAt : Double
          , gateBlockAt : Double
          , gatePassAt : Double
          , useGate : Bool
          }
      , default =
        { concernWhen = Answer.Yes
        , yesMeans = None Text
        , noMeans = None Text
        , categories = [] : List FindingCategory.Type
        , enforcement = Enforcement.Enforced
        , blockingSeverity = Severity.High
        , blockAt = 0.7
        , passAt = 0.3
        , gateBlockAt = 0.9
        , gatePassAt = 0.05
        , useGate = True
        }
      }

let Evidence =
      { Type =
          { scopes : List EvidenceScope
          , include : List Text
          , exclude : List Text
          }
      , default =
        { scopes = [ EvidenceScope.StagedChanges, EvidenceScope.CommitRange ]
        , include = [] : List Text
        , exclude = [] : List Text
        }
      }

let Limits =
      { Type =
          { maxFileBytes : Natural
          , maxChunkBytes : Natural
          , maxChunks : Natural
          , maxAttempts : Natural
          , timeoutSeconds : Natural
          , maxFindings : Natural
          }
      , default =
        { maxFileBytes = 262144
        , maxChunkBytes = 49152
        , maxChunks = 16
        , maxAttempts = 3
        , timeoutSeconds = 120
        , maxFindings = 20
        }
      }

in  { Type =
        { name : Text
        , version : Optional Text
        , description : Optional Text
        , instructions : Text
        , evidence : Evidence.Type
        , limits : Limits.Type
        , deterministicChecks : List DeterministicCheck
        , checks : List Check.Type
        }
    , default =
      { version = None Text
      , description = None Text
      , instructions = ""
      , evidence = Evidence.default
      , limits = Limits.default
      , deterministicChecks = [] : List DeterministicCheck
      }
    , Check
    , FindingCategory
    , Evidence
    , Limits
    , Answer
    , Enforcement
    , Severity
    , EvidenceScope
    , DeterministicCheck
    }
