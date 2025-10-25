# AwAir AI Agent CLI Wrapper v5.1 - Corrected to use Piping for Input

# --- PARAMETERS ---
param(
    [string]$Agent = "gemini" # Default agent is gemini
)

# --- SCRIPT LOGIC ---

# 1. Get the user's full prompt
$userPrompt = $args | Where-Object { $_ -ne "-Agent" -and $_ -ne $Agent } | ForEach-Object { "$_" }
$userPrompt = $userPrompt -join " "

if ([string]::IsNullOrWhiteSpace($userPrompt)) {
    Write-Host "Usage: .\agent.ps1 [-Agent gemini|qwen|iflow] '[Persona], [Your Request]'"
    return
}

# 2. Load the master nexus file
$masterNexusContent = Get-Content -Path "./awair_nexus/awair-master-ai-knowledge-nexus.md" -Raw

# 3. Identify which persona is being requested
$persona = "Guardian"
$personaFile = "The Smart Guardian for a Peaceful Development Workflow.md"
if ($userPrompt -match "Maestro") { $persona = "Maestro"; $personaFile = "Maestro.md" }
if ($userPrompt -match "QA Co-Pilot") { $persona = "QA Co-Pilot"; $personaFile = "Co-Pilot with an Integrated QA Lab.md" }

# 4. Load the specific persona profile
$personaProfileContent = Get-Content -Path "./awair_nexus/ai_profiles/$($personaFile)" -Raw

# 5. Construct the final system prompt
$systemPrompt = @"
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'.
You MUST act as the '$persona' persona. You MUST follow all protocols defined in the Master Nexus, especially the Autonomous Action Protocol for command execution.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $persona ---
$personaProfileContent
"@

# 6. --- EXECUTION LOOP ---
$currentPrompt = $userPrompt
while ($true) {
    Write-Host "Preparing prompt for LOCAL AI ($Agent), embodying '$persona'..." -ForegroundColor Yellow

    # Construct the full prompt for this turn
    $fullPrompt = @"
$systemPrompt

--- CURRENT CONVERSATION ---
$currentPrompt
"@

    # --- THIS IS THE CORRECTED LINE ---
    # Instead of passing the prompt as an argument, we PIPE it to the command's standard input.
    $aiResponse = $fullPrompt | & $Agent

    Write-Host "--- AI ($persona) ---"
    Write-Host $aiResponse

    # 7. Check if the AI wants to execute a command
    if ($aiResponse -match "<execute_command>(.*?)</execute_command>") {
        $commandToRun = $matches[1].Trim()
        Write-Host "AI has requested to run a command: '$commandToRun'" -ForegroundColor Cyan
        
        try {
            # Execute the command and capture its output
            $commandOutput = Invoke-Expression $commandToRun 2>&1 | Out-String
            Write-Host "--- COMMAND OUTPUT ---"
            Write-Host $commandOutput
            
            # Prepare the output to be sent back to the AI
            $currentPrompt = "Here is the output from the command '$commandToRun':`n<command_output>`n$commandOutput`n</command_output>`nNow, please analyze this output and provide your final report or next steps."

        } catch {
            $errorMessage = $_.Exception.Message
            Write-Host "ERROR running command '$commandToRun': $errorMessage" -ForegroundColor Red
            $currentPrompt = "The command '$commandToRun' failed with the following error: `n<command_output>`n$errorMessage`n</command_output>`n. Please acknowledge the error and advise on the next step."
        }
    } else {
        # The AI's response was just text, no command. Break the loop.
        break 
    }
}