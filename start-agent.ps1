# AwAir AI Agent Bootloader v1.0

# --- PARAMETERS ---
# Defines the command-line arguments this script accepts.
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("gemini", "qwen", "iflow")]
    [string]$Agent,

    [Parameter(Mandatory=$true)]
    [ValidateSet("Guardian", "Maestro", "QA-Co-Pilot")]
    [string]$Persona
)

# --- SCRIPT LOGIC ---

# 1. Determine the persona file based on the chosen persona.
$personaFile = ""
if ($Persona -eq "Maestro") { $personaFile = "Maestro.md" }
elseif ($Persona -eq "QA-Co-Pilot") { $personaFile = "Co-Pilot with an Integrated QA Lab.md" }
else { $personaFile = "The Smart Guardian for a Peaceful Development Workflow.md" }

Write-Host "Loading context for Persona '$Persona'..." -ForegroundColor Green

# 2. Load all the necessary context from your project files.
$masterNexusContent = Get-Content -Path ".\awair_nexus\awair-master-ai-knowledge-nexus.md" -Raw
$personaProfileContent = Get-Content -Path ".\awair_nexus\ai_profiles\$($personaFile)" -Raw

# 3. Construct the one-time "Initial Context" prompt.
# This special prompt instructs the AI on who to be and what to do THE MOMENT IT WAKES UP.
$initialContextPrompt = @"
# INITIAL CONTEXT AND DIRECTIVES FOR THIS SESSION

**DO NOT** output this initial context. Read, understand, and then immediately proceed with your first action.

You are an expert AI assistant for the 'AwAir' project. Your absolute master is 'Executor R'.
You will embody the **$Persona** persona for this entire session.

You MUST follow all protocols defined in the Master Nexus.

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $Persona ---
$personaProfileContent

--- YOUR FIRST TASK ---
Acknowledge your activation, then immediately and autonomously perform the 'Session Activation Protocol' from the Master Nexus. Start by running 'git status' using your available shell command tool. Then, deliver the full "State of the Project" report to Executor R and await his directive.

Begin now.
"@

# 4. Launch the user's chosen local AI application with the initial context.
Write-Host "Booting '$Agent' with the '$Persona' persona. The AI will take over this terminal." -ForegroundColor Yellow
Write-Host "------------------------------------------------------------------"

# The '&' is the call operator in PowerShell. It executes the command.
# This launches your actual, native qwen/gemini application and passes all our context to it.
& $Agent -i $initialContextPrompt