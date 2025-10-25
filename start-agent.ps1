# AwAir AI Agent Bootloader v2.0 - With Dynamic Directory Mapping

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("gemini", "qwen", "iflow")]
    [string]$Agent,

    [Parameter(Mandatory=$true)]
    [ValidateSet("Guardian", "Maestro", "QA-Co-Pilot")]
    [string]$Persona
)

# --- SCRIPT LOGIC ---

# 1. Determine Persona File
$personaFile = ""
if ($Persona -eq "Maestro") { $personaFile = "Maestro.md" }
elseif ($Persona -eq "QA-Co-Pilot") { $personaFile = "Co-Pilot with an Integrated QA Lab.md" }
else { $personaFile = "The Smart Guardian for a Peaceful Development Workflow.md" }

Write-Host "Loading context for Persona '$Persona'..." -ForegroundColor Green

# 2. [NEW] Dynamically Build the Project Directory Map
Write-Host "Generating project file map..."
$docsPath = ".\awair_nexus\docs"
$fileTree = Get-ChildItem -Path $docsPath -Recurse | ForEach-Object {
    # Create a clean, relative path with forward slashes
    $relativePath = $_.FullName.Substring($PWD.Path.Length + 1).Replace('\', '/')
    # Format the line for the AI
    "`- $($relativePath)"
}
$directoryMap = $fileTree -join "`n"

# 3. Load Nexus and Persona Files
$masterNexusContent = Get-Content -Path ".\awair_nexus\awair-master-ai-knowledge-nexus.md" -Raw
$personaProfileContent = Get-Content -Path ".\awair_nexus\ai_profiles\$($personaFile)" -Raw

# 4. Construct the Initial Context Prompt with the new Directory Map
$initialContextPrompt = @"
# INITIAL CONTEXT AND DIRECTIVES FOR THIS SESSION
**DO NOT** output this initial context. Read, understand, and then immediately proceed with your first action.

You are an expert AI assistant for the 'AwAir' project embodying the **$Persona** persona. Your absolute master is 'Executor R'.
You MUST follow all protocols defined in the Master Nexus.

--- PROJECT FILE DIRECTORY MAP ---
This is the complete list of all knowledge files available to you. You MUST use these exact paths. DO NOT search for files.
$directoryMap

--- MASTER NEXUS FILE ---
$masterNexusContent

--- YOUR CURRENT PERSONA PROFILE: $Persona ---
$personaProfileContent

--- YOUR FIRST TASK ---
Acknowledge your activation, then immediately and autonomously perform the 'Session Activation Protocol' from the Master Nexus. Start by running 'git status' using your available shell command tool. Then, deliver the full "State of the "Project" report to Executor R and await his directive.

Begin now.
"@

# 5. Launch the chosen local AI application
Write-Host "Booting '$Agent' with the '$Persona' persona and directory map. The AI will take over this terminal." -ForegroundColor Yellow
Write-Host "------------------------------------------------------------------"

& $Agent -i $initialContextPrompt