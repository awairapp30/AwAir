# AwAir AI Agent CLI Wrapper v1.0

# 1. Get the user's full prompt from the command-line arguments.
$userPrompt = $args -join " "

if ([string]::IsNullOrWhiteSpace($userPrompt)) {
    Write-Host "Usage: .\agent.ps1 '[Persona], [Your Request]'"
    return
}

# 2. Automatically load the master nexus file for context and protocols.
$masterNexusContent = Get-Content -Path "./awair_nexus/awair-master-ai-knowledge-nexus.md" -Raw

# 3. Identify which persona is being requested.
$persona = "Guardian" # Default persona
$personaFile = "The Smart Guardian for a Peaceful Development Workflow.md"
if ($userPrompt -match "Maestro") { 
    $persona = "Maestro" 
    $personaFile = "Maestro.md"
}
if ($userPrompt -match "QA Co-Pilot") { 
    $persona = "QA Co-Pilot"
    $personaFile = "Co-Pilot with an Integrated QA Lab.md"
}

# 4. Load the specific persona profile.
$personaProfileContent = Get-Content -Path "./awair_nexus/ai_profiles/$($personaFile)" -Raw

# 5. Construct the final "System Prompt" to send to the AI.
$systemPrompt = @"
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'.
You MUST follow all protocols defined in the Master Nexus.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $persona ---
$personaProfileContent

--- USER'S REQUEST ---
$userPrompt
"@

# 6. Send the combined prompt to the underlying AI model and display the response.
# In a real implementation, this would make the actual API call.
Write-Host "Embodying the '$persona' persona. Processing request..." -ForegroundColor Yellow
Write-Host "---"
Write-Host $systemPrompt
Write-Host "---"
Write-Host "(This is a simulation of the prompt being sent to the AI model. The model's response would appear below.)" -ForegroundColor Gray