# AwAir Interactive Chat Session v1.0

# --- INITIAL SETUP ---
Write-Host "--- AwAir AI Chat ---" -ForegroundColor Green
$Agent = Read-Host "Which agent will you be using? (gemini, qwen, iflow)"
$PersonaName = Read-Host "Which persona shall the agent embody? (Guardian, Maestro, QA Co-Pilot)"

# Determine the persona file based on user's choice
$personaFile = ""
if ($PersonaName -match "Maestro") { $personaFile = "Maestro.md" }
elseif ($PersonaName -match "QA") { $personaFile = "Co-Pilot with an Integrated QA Lab.md" }
else { $personaFile = "The Smart Guardian for a Peaceful Development Workflow.md" }

Write-Host "Session started. You are now in a chat with '$($PersonaName)' via the '$($Agent)' model. Type 'exit' to end the session." -ForegroundColor Yellow

# --- CONTEXT LOADING ---
$masterNexusContent = Get-Content -Path "./awair_nexus/awair-master-ai-knowledge-nexus.md" -Raw
$personaProfileContent = Get-Content -Path "./awair_nexus/ai_profiles/$($personaFile)" -Raw

$systemPrompt = @"
You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'.
You MUST act as the '$PersonaName' persona. You MUST follow all protocols defined in the Master Nexus.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $PersonaName ---
$personaProfileContent
"@

$conversationHistory = ""

# --- CHAT LOOP ---
while ($true) {
    # Get user input from the interactive prompt
    $userPrompt = Read-Host "[Executor R] >"
    
    if ($userPrompt.ToLower() -in @("exit", "quit", "bye")) {
        Write-Host "Ending session." -ForegroundColor Yellow
        break
    }
    
    # Add the new user prompt to the history
    $conversationHistory += "`n--- USER'S REQUEST ---`n$userPrompt"
    
    # Construct the full prompt for this turn
    $fullPrompt = @"
$systemPrompt

--- CURRENT CONVERSATION HISTORY ---
$conversationHistory
"@

    # --- EXECUTE LOCAL AI ---
    Write-Host "($($PersonaName) is thinking...)" -ForegroundColor Gray
    
    # Pipe the full prompt into the selected local AI command
    $aiResponse = $fullPrompt | & $Agent
    
    # Add the AI's response to the history for the next turn
    $conversationHistory += "`n--- AI RESPONSE ---`n$aiResponse"
    
    # Display the AI's response
    Write-Host "`n--- $($PersonaName) ---" -ForegroundColor Cyan
    Write-Host "$($aiResponse)`n"
}```