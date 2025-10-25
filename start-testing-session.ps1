# AwAir AI Testing Specialist

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$TestingGoalArray
)

$testingGoal = $TestingGoalArray -join " "
if ([string]::IsNullOrWhiteSpace($testingGoal)) {
    Write-Host "Usage: .\start-testing-session.ps1 'The feature you want to test.'" -ForegroundColor Red
    return
}

$initialPrompt = "INITIATE TESTING SESSION. Goal: ""$testingGoal"". Act as an On-Demand QA Lab. Begin by clarifying the scope and selecting the most appropriate test strategy from your arsenal."

& .\start-session.ps1 -Agent gemini -Persona QA-Co-Pilot $initialPrompt