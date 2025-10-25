# AwAir AI Planning Specialist

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$PlanningGoalArray
)

$planningGoal = $PlanningGoalArray -join " "
if ([string]::IsNullOrWhiteSpace($planningGoal)) {
    $planningGoal = "General project planning and strategy based on the roadmap."
}

# This specialist pre-loads the full content of the core blueprints for the Maestro
$extraContext = "`n--- PRE-LOADED BLUEPRINT: The Complete Awair Guide.md ---`n"
$extraContext += Get-Content -Path ".\awair_nexus\docs\The Complete Awair Guide.md" -Raw
$extraContext += "`n--- PRE-LOADED BLUEPRINT: 🗓️ AWAIR COMPLETE DEVELOPMENT ROADMAP.md ---`n"
$extraContext += Get-Content -Path ".\awair_nexus\docs\🗓️ AWAIR COMPLETE DEVELOPMENT ROADMAP.md" -Raw

$initialPrompt = "INITIATE PLANNING SESSION. Goal: ""$planningGoal"". Act as a Visionary Architect and Innovation Catalyst. The core blueprints have been pre-loaded into your context. Begin by outlining your approach. $extraContext"

& .\start-session.ps1 -Agent gemini -Persona Maestro $initialPrompt