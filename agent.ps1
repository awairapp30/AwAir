# AwAir AI Agent CLI Wrapper v5.6 - Definitive Version

# --- 1. ROBUST MANUAL ARGUMENT PARSING ---
$Agent = "gemini" # Default agent
$PromptArray = @() # Initialize an empty array for the prompt parts

if ($args.Count -gt 1 -and ($args[0] -eq '-Agent' -or $args[0] -eq '-agent')) {
    $Agent = $args[1]
    if ($args.Count -gt 2) {
        $PromptArray = $args[2..($args.Count - 1)]
    }
} else {
    $PromptArray = $args
}

$userPrompt = $PromptArray -join " "

if ([string]::IsNullOrWhiteSpace($userPrompt)) {
    Write-Host "Usage: .\agent.ps1 [-Agent gemini|qwen|iflow] '[Persona], [Your Request]'" -ForegroundColor Red
    return
}

# --- 2. HARDCODED ACTIVATION PROTOCOL CHECK ---
if ($userPrompt -match "report project status") {
    Write-Host "Session activation detected. Automatically running 'git status'..." -ForegroundColor Cyan
    try {
        $gitStatusOutput = Invoke-Expression "git status" 2>&1 | Out-String
        $userPrompt = "Here is the output from the mandatory initial 'git status' command:`n<command_output>`n$gitStatusOutput`n</command_output>`nNow, please provide the full project status report and suggest the next steps."
        Write-Host "--- GIT STATUS CAPTURED ---"
        Write-Host $gitStatusOutput
        Write-Host "--------------------------"
    } catch {
        $errorMessage = $_.Exception.Message
        $userPrompt = "The initial 'git status' command failed with an error: `n<command_output>`n$errorMessage`n</command_output>`n. Acknowledge the error and advise."
    }
}

# --- 3. CONSTRUCT THE FULL PROMPT ---
$masterNexusContent = Get-Content -Path "./awair_nexus/awair-master-ai-knowledge-nexus.md" -Raw
$persona = "Guardian"
$personaFile = "The Smart Guardian for a Peaceful Development Workflow.md"
if ($userPrompt -match "Maestro") { $persona = "Maestro"; $personaFile = "Maestro.md" }
if ($userPrompt -match "QA Co-Pilot") { $persona = "QA Co-Pilot"; $personaFile = "Co-Pilot with an Integrated QA Lab.md" }
$personaProfileContent = Get-Content -Path "./awair_nexus/ai_profiles/$($personaFile)" -Raw

$systemPrompt = @"
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'. You MUST act as the '$persona' persona and follow all protocols defined in the Master Nexus.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $persona ---
$personaProfileContent
"@

$fullPrompt = @"
$systemPrompt

--- CURRENT CONVERSATION ---
$userPrompt
"@

# --- 4. EXECUTE LOCAL AI ---
Write-Host "Preparing prompt for LOCAL AI ($Agent), embodying '$persona'..." -ForegroundColor Yellow

$aiResponse = $fullPrompt | & $Agent
Write-Host "--- AI ($persona) ---"
Write-Host $aiResponse