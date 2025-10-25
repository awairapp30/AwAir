# AwAir AI Interactive Session Manager v2.0 (The Engine)

param(
    [Parameter(Mandatory=$true)] [ValidateSet("gemini", "qwen", "iflow")] [string]$Agent,
    [Parameter(Mandatory=$true)] [ValidateSet("Guardian", "Maestro", "QA-Co-Pilot")] [string]$Persona,
    [Parameter(ValueFromRemainingArguments=$true)] [string[]]$InitialPromptArray
)

$initialPrompt = $InitialPromptArray -join " "
if ([string]::IsNullOrWhiteSpace($initialPrompt)) {
    $initialPrompt = "Acknowledge activation and role, then initiate the Session Activation Protocol by asking for 'git status'."
}

# --- This script is now the FOUNDATION. All other specialist scripts will call this one ---

$personaFile = ""
if ($Persona -eq "Maestro") { $personaFile = "Maestro.md" }
elseif ($Persona -eq "QA-Co-Pilot") { $personaFile = "Co-Pilot with an Integrated QA Lab.md" }
else { $personaFile = "The Smart Guardian for a Peaceful Development Workflow.md" }

$masterNexusContent = Get-Content -Path ".\awair_nexus\awair-master-ai-knowledge-nexus.md" -Raw
$personaProfileContent = Get-Content -Path ".\awair_nexus\ai_profiles\$($personaFile)" -Raw

$sessionID = (Get-Date).ToString("yyyyMMdd-HHmmss")
$logFileName = "./conversations/$($sessionID)_$($Persona)_$($Agent).log.md"
$logHeader = "# Conversation Log: $Persona via $Agent`n**Session ID:** $sessionID`n**Status:** Active`n---"
Set-Content -Path $logFileName -Value $logHeader
Write-Host "This session is being logged to: $logFileName" -ForegroundColor Gray

# --- THE INTERACTIVE CHAT LOOP ---
Write-Host "Booting '$Agent' with the '$Persona' persona..." -ForegroundColor Yellow
Write-Host "You are now in a live session. Type 'exit' to end." -ForegroundColor Green
$conversationHistory = ""
$currentPrompt = $initialPrompt

while ($true) {
    # Gather real-time context
    $realTimeContext = ""
    $otherLogs = Get-ChildItem -Path "./conversations" -Filter "*.log.md" | Where-Object { $_.Name -ne (Split-Path $logFileName -Leaf) } | Sort-Object LastWriteTime -Descending | Select-Object -First 2
    if ($otherLogs) {
        $realTimeContext = "`n--- REAL-TIME AWARENESS REPORT ---`n"
        foreach ($log in $otherLogs) {
            $realTimeContext += "CONTEXT from active session $($log.Name):`n" + ((Get-Content $log.FullName | Select-Object -Last 10) -join "`n") + "`n------------------`n"
        }
    }

    $systemPrompt = "You are an AI for the 'AwAir' project embodying the **$Persona** persona. Master is 'Executor R'. Follow all protocols from the Master Nexus."
    
    $fullPrompt = @"
$systemPrompt
--- REAL-TIME CONTEXT ---
$realTimeContext
--- MASTER NEXUS ---
$masterNexusContent
--- PERSONA PROFILE ---
$personaProfileContent
--- HISTORY ---
$conversationHistory
--- YOUR TASK ---
Respond to: "$currentPrompt"
"@

    Add-Content -Path $logFileName -Value "`n--- USER/SYSTEM: $($currentPrompt) ---"
    Write-Host "($($Persona) is thinking...)" -ForegroundColor Gray
    
    $aiResponse = $fullPrompt | & "$($Agent).ps1"
    
    Add-Content -Path $logFileName -Value "`n--- AI ($Persona): $($aiResponse) ---"
    Write-Host "`n--- $($Persona) ---" -ForegroundColor Cyan
    Write-Host "$($aiResponse)`n"

    $userInput = Read-Host "[Executor R] >"
    if ($userInput.ToLower() -in @("exit", "quit", "bye")) {
        Add-Content -Path $logFileName -Value "`n**Status:** Completed"
        break
    }
    $currentPrompt = $userInput
}