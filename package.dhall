-- | Seihou Schema Package
--
-- Import this file to use Dhall record completion (::) for module authoring.
--
-- Example:
--   let S = ./package.dhall
--   in S.Module::{ name = "my-module"
--                , steps = [ S.Step::{ strategy = "template", src = "foo.tpl", dest = "foo" } ]
--                }
{ VarDecl = ./VarDecl.dhall
, VarExport = ./VarExport.dhall
, Prompt = ./Prompt.dhall
, Step = ./Step.dhall
, Command = ./Command.dhall
, Dependency = ./Dependency.dhall
, RemovalStep = ./RemovalStep.dhall
, Removal = ./Removal.dhall
, MigrationOp = ./MigrationOp.dhall
, Migration = ./Migration.dhall
, EntailedEdge = ./EntailedEdge.dhall
, BlueprintMigration = ./BlueprintMigration.dhall
, CommandVar = ./CommandVar.dhall
, Launch = ./Launch.dhall
, Module = ./Module.dhall
, RecipeReference = ./RecipeReference.dhall
, RecipeModuleOverride = ./RecipeModuleOverride.dhall
, Recipe = ./Recipe.dhall
, Blueprint = ./Blueprint.dhall
, AgentPrompt = ./AgentPrompt.dhall
, PromptGuidance = (./AgentPrompt.dhall).PromptGuidance
, Judgement = ./Judgement.dhall
, Check = (./Judgement.dhall).Check
, FindingCategory = (./Judgement.dhall).FindingCategory
, JudgementEvidence = (./Judgement.dhall).Evidence
, JudgementLimits = (./Judgement.dhall).Limits
, Answer = (./Judgement.dhall).Answer
, Enforcement = (./Judgement.dhall).Enforcement
, Severity = (./Judgement.dhall).Severity
, EvidenceScope = (./Judgement.dhall).EvidenceScope
, DeterministicCheck = (./Judgement.dhall).DeterministicCheck
}
