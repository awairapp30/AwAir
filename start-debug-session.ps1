# AwAir AI Debugging Specialist

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$ProblemDescriptionArray
)

$problemDescription = $ProblemDescriptionArray -join " "
if ([string]::IsNullOrWhiteSpace($problemDescription)) {
    $problemDescription = "I have encountered an unspecified bug. Please begin the Universal Debugging Workflow."
}

$initialPrompt = "INITIATE DEBUGGING SESSION. Problem: ""$problemDescription"". Your ONLY goal is to follow the Universal Debugging Workflow. Begin now by asking for the 3 Pillars of Evidence."

& .\start-session.ps1 -Agent gemini -Persona Guardian $initialPrompt