# AwAir AI Agent CLI Wrapper v5.4 - With Hardcoded Activation Protocol

param(
    [string]$Agent = "gemini",
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$PromptArray
)

$userPrompt = $PromptArray -join " "

if ([string]::IsNullOrWhiteSpace($userPrompt)) {
    Write-Host "Usage: .\agent.ps1 [-Agent gemini|qwen|iflow] '[Persona], [Your Request]'" -ForegroundColor Red
    return
}

# 1. HARDCODED ACTIVATION PROTOCOL CHECK
if ($userPrompt -match "report project status") {
    Write-Host "Session activation detected. Automatically running 'git status'..." -ForegroundColor Cyan
    try {
        $gitStatusOutput = Invoke-Expression "git status" 2>&1 | Out-String
        # Modify the user's prompt to include the status output for the first turn
        $userPrompt = "Here is the output from the mandatory initial 'git status' command:`n<command_output>`n$gitStatusOutput`n</command_output>`nNow, please provide the full project status report and suggest the next steps."
        Write-Host "--- GIT STATUS CAPTURED ---"
        Write-Host $gitStatusOutput
        Write-Host "--------------------------"
    } catch {
        $errorMessage = $_.Exception.Message
        $userPrompt = "The initial 'git status' command failed with an error: `n<command_output>`n$errorMessage`n</command_output>`n. Acknowledge the error and advise."
    }
}

# 2. Load the master nexus file.
$masterNexusContent = Get-Content -Path "./awair_nexus/awair-master-ai-knowledge-nexus.md" -Raw

# 3. Identify which persona is being requested.
$persona = "Guardian"
$personaFile = "The Smart Guardian for a Peaceful Development Workflow.md"
if ($userPrompt -match "Maestro") { $persona = "Maestro"; $personaFile = "Maestro.md" }
if ($userPrompt -match "QA Co-Pilot") { $persona = "QA Co-Pilot"; $personaFile = "Co-Pilot with an Integrated QA Lab.md" }

# 4. Load the specific persona profile.
$personaProfileContent = Get-Content -Path "./awair_nexus/ai_profiles/$($personaFile)" -Raw

# 5. Construct the full system prompt.
$systemPrompt = @"
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'. You MUST act as the '$persona' persona and follow all protocols defined in the Master Nexus.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $persona ---
$personaProfileContent
"@

# 6. --- EXECUTION LOOP (Simplified) ---
# Since we now handle the initial command, the loop is simpler for activation.
$currentPrompt = $userPrompt

Write-Host "Preparing prompt for LOCAL AI ($Agent), embodying '$persona'..." -ForegroundColor Yellow

$fullPrompt = @"
$systemPrompt

--- CURRENT CONVERSATION ---
$currentPrompt
"@

$aiResponse = $fullPrompt | & $Agent
Write-Host "--- AI ($persona) ---"
Write-Host $aiResponse

# NOTE: The full command execution loop is disabled for this simplified activation.
# If the AI asks for another command, you will run it manually for now.
# We will upgrade this back to a full loop after confirming this fix works.