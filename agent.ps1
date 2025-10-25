# AwAir AI Agent CLI Wrapper v5.3 - Ultra-Robust Manual Argument Parsing

# --- SCRIPT LOGIC ---

# --- MANUAL ARGUMENT PARSING ---
$Agent = "gemini" # Default agent
$PromptArray = @() # Initialize an empty array for the prompt parts

if ($args.Count -gt 1 -and ($args[0] -eq '-Agent' -or $args[0] -eq '-agent')) {
    # Case: The user has specified an agent, e.g., .\agent.ps1 -Agent qwen "prompt"
    $Agent = $args[1]
    if ($args.Count -gt 2) {
        $PromptArray = $args[2..($args.Count - 1)]
    }
} else {
    # Case: No agent was specified, all arguments are part of the prompt
    $PromptArray = $args
}

$userPrompt = $PromptArray -join " "

# --- DIAGNOSTIC DEBUGGING ---
# These lines will show us exactly what the script understood.
Write-Host "--- SCRIPT DEBUG ---"
Write-Host "Detected Agent: $Agent" -ForegroundColor Green
Write-Host "Detected Prompt: $userPrompt" -ForegroundColor Green
Write-Host "--------------------"

if ([string]::IsNullOrWhiteSpace($userPrompt)) {
    Write-Host "Usage: .\agent.ps1 [-Agent gemini|qwen|iflow] '[Persona], [Your Request]'" -ForegroundColor Red
    return
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
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'.
You MUST act as the '$persona' persona. You MUST follow all protocols defined in the Master Nexus, especially the Autonomous Action Protocol.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $persona ---
$personaProfileContent
"@

# 6. --- EXECUTION LOOP ---
$currentPrompt = $userPrompt
while ($true) {
    Write-Host "Preparing prompt for LOCAL AI ($Agent), embodying '$persona'..." -ForegroundColor Yellow

    $fullPrompt = @"
$systemPrompt

--- CURRENT CONVERSATION ---
$currentPrompt
"@

    $aiResponse = $fullPrompt | & $Agent
    Write-Host "--- AI ($persona) ---"
    Write-Host $aiResponse

    if ($aiResponse -match "<execute_command>(.*?)</execute_command>") {
        $commandToRun = $matches[1].Trim()
        Write-Host "AI has requested to run a command: '$commandToRun'" -ForegroundColor Cyan
        try {
            $commandOutput = Invoke-Expression $commandToRun 2>&1 | Out-String
            Write-Host "--- COMMAND OUTPUT ---"
            Write-Host $commandOutput
            $currentPrompt = "Here is the output from the command '$commandToRun':`n<command_output>`n$commandOutput`n</command_output>`nNow, please analyze this output and provide your final report or next steps."
        } catch {
            $errorMessage = $_.Exception.Message
            Write-Host "ERROR running command '$commandToRun': $errorMessage" -ForegroundColor Red
            $currentPrompt = "The command '$commandToRun' failed with an error: `n<command_output>`n$errorMessage`n</command_output>`n. Acknowledge the error and advise."
        }
    } else {
        break 
    }
}