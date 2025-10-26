param(
    [Parameter(Mandatory=$true)] 
    [ValidateSet("gemini", "qwen", "iflow")] 
    [string]$Agent,
    
    [Parameter(Mandatory=$true)] 
    [ValidateSet("Guardian", "Maestro", "QA-Co-Pilot")] 
    [string]$Persona,
    
    [Parameter(ValueFromRemainingArguments=$true)] 
    [string[]]$InitialPromptArray
)

# --- SCRIPT CONFIGURATION ---

# AI CLI commands (npm-installed tools)
$aiCommands = @{
    "gemini" = "gemini"
    "qwen"   = "qwen"
    "iflow"  = "iflow"
}

$aiCommand = $aiCommands[$Agent]

# Test if the command exists
try {
    $null = Get-Command $aiCommand -ErrorAction Stop
} catch {
    Write-Error "ERROR: Cannot find '$aiCommand' command. Is it installed?"
    Write-Host "Please install it using: npm install -g $aiCommand" -ForegroundColor Yellow
    return
}

# --- PREPARE INITIAL PROMPT ---
$initialPrompt = $InitialPromptArray -join " "
if ([string]::IsNullOrWhiteSpace($initialPrompt)) {
    $initialPrompt = "Acknowledge activation and role, then initiate the Session Activation Protocol by asking for 'git status'."
}

# --- LOAD PERSONA FILES ---
$personaFile = ""
if ($Persona -eq "Maestro") { 
    $personaFile = "Maestro.md" 
}
elseif ($Persona -eq "QA-Co-Pilot") { 
    $personaFile = "Co-Pilot with an Integrated QA Lab.md" 
}
else { 
    $personaFile = "The Smart Guardian for a Peaceful Development Workflow.md" 
}

# Validate paths
$masterNexusPath = ".\awair_nexus\awair-master-ai-knowledge-nexus.md"
$personaPath = ".\awair_nexus\ai_profiles\$personaFile"
$docsPath = ".\awair_nexus\docs"

if (-not (Test-Path $masterNexusPath)) {
    Write-Error "ERROR: Cannot find master nexus file at: $masterNexusPath"
    return
}

if (-not (Test-Path $personaPath)) {
    Write-Error "ERROR: Cannot find persona file at: $personaPath"
    return
}

if (-not (Test-Path $docsPath)) {
    Write-Error "ERROR: Cannot find docs folder at: $docsPath"
    return
}

Write-Host "`n" + "="*70 -ForegroundColor Cyan
Write-Host "   AWAIR AI SESSION - INITIALIZING CONTEXT" -ForegroundColor Cyan
Write-Host "="*70 -ForegroundColor Cyan

# --- LOAD MASTER NEXUS ---
Write-Host "`n[1/5] Loading Master AI Knowledge Nexus..." -ForegroundColor Yellow
$masterNexusContent = Get-Content -Path $masterNexusPath -Raw
Write-Host "      ✓ Loaded successfully" -ForegroundColor Green

# --- LOAD PERSONA PROFILE ---
Write-Host "`n[2/5] Loading $Persona persona profile..." -ForegroundColor Yellow
$personaProfileContent = Get-Content -Path $personaPath -Raw
Write-Host "      ✓ Loaded successfully" -ForegroundColor Green

# --- BUILD DIRECTORY MAP OF ALL DOCUMENTATION ---
Write-Host "`n[3/5] Building complete directory map of all blueprints..." -ForegroundColor Yellow
$allDocFiles = Get-ChildItem -Path $docsPath -Filter "*.md" -File | Sort-Object Name
$directoryMap = "`n" + "="*70 + "`n"
$directoryMap += "COMPLETE DOCUMENTATION DIRECTORY MAP`n"
$directoryMap += "Location: awair_nexus/docs/`n"
$directoryMap += "Total Files: $($allDocFiles.Count)`n"
$directoryMap += "="*70 + "`n`n"

$fileCategories = @{
    "Core Blueprints" = @("The Complete Awair Guide", "AWAIR COMPLETE DEVELOPMENT ROADMAP")
    "Architecture & Schemas" = @("Technology Stack", "audio-architecture", "database-schema", "state-and-screen-architecture")
    "Implementation Guides" = @("ml-implementation", "monetization-tech")
    "Debugging Playbooks" = @("what happens when things go wrong", "Complete AI Debugging Playbook", "Expo & React Native Debugging", "Master Debugging Playbook")
    "Ecosystem & Language" = @("Entire Expo ecosystem", "javascript-hoisting-guide")
    "Meta & Tooling" = @("cross-ai-discovery", "knowledge-domain-guide", "validation-and-quality")
}

foreach ($category in $fileCategories.Keys) {
    $directoryMap += "[$category]`n"
    foreach ($file in $allDocFiles) {
        $fileName = $file.Name
        foreach ($keyword in $fileCategories[$category]) {
            if ($fileName -like "*$keyword*") {
                $directoryMap += "  • $fileName`n"
                break
            }
        }
    }
    $directoryMap += "`n"
}

$directoryMap += "="*70 + "`n"
$directoryMap += "USAGE: To access any file's full content, ask Executor R:`n"
$directoryMap += "'Please show me [filename]' or 'Load [filename] for me'`n"
$directoryMap += "="*70 + "`n"

Write-Host "      ✓ Directory map created ($($allDocFiles.Count) files catalogued)" -ForegroundColor Green

# --- LOAD ESSENTIAL FILES (FULL CONTENT) ---
Write-Host "`n[4/5] Loading essential files (full content)..." -ForegroundColor Yellow

$essentialFiles = @(
    "The Complete Awair Guide.md",
    "database-schema.md",
    "state-and-screen-architecture.md",
    "Technology Stack.md"
)

$essentialContent = "`n" + "="*70 + "`n"
$essentialContent += "ESSENTIAL FILES - FULL CONTENT LOADED`n"
$essentialContent += "="*70 + "`n"

foreach ($fileName in $essentialFiles) {
    $filePath = Join-Path $docsPath $fileName
    if (Test-Path $filePath) {
        $fileContent = Get-Content -Path $filePath -Raw
        $essentialContent += "`n`n" + "-"*70 + "`n"
        $essentialContent += "FILE: $fileName`n"
        $essentialContent += "-"*70 + "`n"
        $essentialContent += $fileContent
        $essentialContent += "`n" + "-"*70 + "`n"
        Write-Host "      ✓ $fileName" -ForegroundColor Green
    } else {
        Write-Host "      ⚠ $fileName not found (skipping)" -ForegroundColor Yellow
    }
}

$essentialContent += "`n" + "="*70 + "`n"

# --- GATHER REAL-TIME AWARENESS FROM OTHER SESSIONS ---
Write-Host "`n[5/5] Scanning for other active AI sessions..." -ForegroundColor Yellow

$realTimeAwareness = ""
if (Test-Path ".\conversations") {
    $otherLogs = Get-ChildItem -Path ".\conversations" -Filter "*.log.md" -File |
                 Sort-Object LastWriteTime -Descending |
                 Select-Object -First 3
    
    if ($otherLogs) {
        $realTimeAwareness = "`n" + "="*70 + "`n"
        $realTimeAwareness += "REAL-TIME AWARENESS REPORT - OTHER ACTIVE SESSIONS`n"
        $realTimeAwareness += "="*70 + "`n`n"
        
        foreach ($log in $otherLogs) {
            $realTimeAwareness += "Session: $($log.Name)`n"
            $realTimeAwareness += "Last Modified: $($log.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'))`n"
            $realTimeAwareness += "Recent Activity:`n"
            $realTimeAwareness += "-"*70 + "`n"
            
            $lastLines = Get-Content $log.FullName -ErrorAction SilentlyContinue | Select-Object -Last 15
            if ($lastLines) {
                $realTimeAwareness += ($lastLines -join "`n")
            }
            $realTimeAwareness += "`n" + "-"*70 + "`n`n"
        }
        
        $realTimeAwareness += "="*70 + "`n"
        Write-Host "      ✓ Found $($otherLogs.Count) recent session(s)" -ForegroundColor Green
    } else {
        Write-Host "      • No other active sessions detected" -ForegroundColor Gray
    }
} else {
    Write-Host "      • Conversations folder will be created" -ForegroundColor Gray
}

# --- CREATE CONVERSATION LOG ---
if (-not (Test-Path ".\conversations")) {
    New-Item -ItemType Directory -Path ".\conversations" | Out-Null
}

$sessionID = (Get-Date).ToString("yyyyMMdd-HHmmss")
$logFileName = ".\conversations\$($sessionID)_$($Persona)_$($Agent).log.md"
$logHeader = @"
# Conversation Log: $Persona via $Agent
**Session ID:** $sessionID
**Status:** Active
**Started:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Context Loaded:
- Master AI Knowledge Nexus
- $Persona Persona Profile  
- Directory Map: $($allDocFiles.Count) files catalogued
- Essential Files (Full Content): $($essentialFiles.Count) files
- Real-Time Awareness: Active

---
"@

Set-Content -Path $logFileName -Value $logHeader

# --- ASSEMBLE COMPLETE CONTEXT ---
$fullContext = @"
============================================================
            AWAIR AI SESSION CONTEXT
============================================================
Persona: $Persona
Agent: $Agent
Session ID: $sessionID
Started: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

============================================================
    MASTER AI KNOWLEDGE NEXUS (Operating System)
============================================================

$masterNexusContent

============================================================
    PERSONA PROFILE: $Persona
============================================================

$personaProfileContent

$directoryMap

$essentialContent

$realTimeAwareness

============================================================
    INITIAL PROMPT
============================================================

$initialPrompt

============================================================
    SESSION ACTIVATION PROTOCOL
============================================================

You are now fully activated with:
1. Complete knowledge of your role and mandates
2. A directory map of all 21+ project blueprints
3. Full content of 4 essential files (vision, database, state, tech)
4. Awareness of other active AI sessions

Your first action: Acknowledge this activation, then request 'git status'
to understand the current state of the codebase.

============================================================
"@

# --- DISPLAY SESSION INFO ---
Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   CONTEXT LOADED - SESSION READY" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "`nPersona:    " -NoNewline; Write-Host $Persona -ForegroundColor Yellow
Write-Host "Agent:      " -NoNewline; Write-Host $Agent -ForegroundColor Yellow
Write-Host "Session ID: " -NoNewline; Write-Host $sessionID -ForegroundColor Gray
Write-Host "`nLog file: " -NoNewline; Write-Host $logFileName -ForegroundColor Gray
Write-Host "`nContext includes:" -ForegroundColor Cyan
Write-Host "  • Master Nexus & $Persona profile" -ForegroundColor White
Write-Host "  • Directory map of $($allDocFiles.Count) documentation files" -ForegroundColor White
Write-Host "  • Full content of $($essentialFiles.Count) essential files" -ForegroundColor White
if ($otherLogs) {
    Write-Host "  • Real-time awareness of $($otherLogs.Count) other session(s)" -ForegroundColor White
}
Write-Host "="*70 -ForegroundColor Green

# --- START AI PROCESS ---
Write-Host "`nStarting $Agent CLI process..." -ForegroundColor Yellow

$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = "powershell.exe"
$processInfo.Arguments = "-NoExit -Command `"cd '$pwd'; $aiCommand`""
$processInfo.WorkingDirectory = (Get-Location).Path
$processInfo.RedirectStandardInput = $false
$processInfo.RedirectStandardOutput = $false
$processInfo.UseShellExecute = $true
$processInfo.CreateNoWindow = $false

$aiProcess = New-Object System.Diagnostics.Process
$aiProcess.StartInfo = $processInfo

try {
    if (-not $aiProcess.Start()) {
        Write-Error "Failed to start the $Agent process."
        return
    }
}
catch {
    Write-Error "An exception occurred while starting the $Agent process."
    Write-Error $_.Exception.Message
    return
}

Write-Host "✓ $Agent CLI launched in separate window" -ForegroundColor Green

# --- COPY CONTEXT TO CLIPBOARD ---
Set-Clipboard -Value $fullContext
Write-Host "`n✓ Complete context copied to clipboard" -ForegroundColor Green

# --- INTERACTIVE CHAT LOOP ---
Write-Host "`n" + "="*70 -ForegroundColor Cyan
Write-Host "   INTERACTIVE SESSION MODE" -ForegroundColor Cyan
Write-Host "="*70 -ForegroundColor Cyan
Write-Host "`nCommands:" -ForegroundColor Yellow
Write-Host "  'paste'  - Copy context to clipboard again" -ForegroundColor Gray
Write-Host "  'log'    - Show log file location" -ForegroundColor Gray
Write-Host "  'files'  - List all available documentation files" -ForegroundColor Gray
Write-Host "  'exit'   - End session" -ForegroundColor Gray
Write-Host "`nPaste the context into $Agent window now, then return here." -ForegroundColor White
Write-Host "="*70 -ForegroundColor Cyan

# Wait for user confirmation
$null = Read-Host "`nPress Enter after pasting context into $Agent"

Write-Host "`n✓ Starting conversation loop..." -ForegroundColor Green
Write-Host "You can now interact with both this console and the $Agent window." -ForegroundColor Gray
Write-Host ""

$turnCount = 0

while ($true) {
    $turnCount++
    
    # Get user input
    Write-Host "[Turn $turnCount] " -NoNewline -ForegroundColor Cyan
    $userInput = Read-Host "[Executor R]"
    
    # Handle special commands
    if ($userInput.ToLower() -in @("exit", "quit", "bye")) {
        Write-Host "`nEnding session..." -ForegroundColor Yellow
        Add-Content -Path $logFileName -Value "`n`n--- Session Ended @ $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---`nTotal Turns: $turnCount"
        break
    }
    
    if ($userInput.ToLower() -eq "paste") {
        Set-Clipboard -Value $fullContext
        Write-Host "✓ Context copied to clipboard again" -ForegroundColor Green
        continue
    }
    
    if ($userInput.ToLower() -eq "log") {
        Write-Host "Log file: $logFileName" -ForegroundColor Cyan
        continue
    }
    
    if ($userInput.ToLower() -eq "files") {
        Write-Host "`nAvailable documentation files:" -ForegroundColor Cyan
        foreach ($file in $allDocFiles) {
            Write-Host "  • $($file.Name)" -ForegroundColor Gray
        }
        continue
    }
    
    # Log user input
    Add-Content -Path $logFileName -Value "`n--- Turn $turnCount @ $(Get-Date -Format 'HH:mm:ss') ---"
    Add-Content -Path $logFileName -Value "**[Executor R]:** $userInput"
    
    # Update real-time awareness for this turn
    $currentAwareness = ""
    if (Test-Path ".\conversations") {
        $otherCurrentLogs = Get-ChildItem -Path ".\conversations" -Filter "*.log.md" -File |
                            Where-Object { $_.Name -ne (Split-Path $logFileName -Leaf) } |
                            Sort-Object LastWriteTime -Descending |
                            Select-Object -First 2
        
        if ($otherCurrentLogs) {
            $currentAwareness = "`n--- REAL-TIME AWARENESS UPDATE ---`n"
            foreach ($log in $otherCurrentLogs) {
                $currentAwareness += "Recent activity from $($log.Name):`n"
                $recentLines = Get-Content $log.FullName -ErrorAction SilentlyContinue | Select-Object -Last 8
                if ($recentLines) {
                    $currentAwareness += ($recentLines -join "`n") + "`n"
                }
                $currentAwareness += "---`n"
            }
        }
    }
    
    # Display what to tell the AI
    Write-Host "`nTell $Agent in its window:" -ForegroundColor Yellow
    if ($currentAwareness) {
        Write-Host "  [Awareness Update Available]" -ForegroundColor Magenta
    }
    Write-Host "  $userInput" -ForegroundColor White
    Write-Host ""
    
    # Prompt for AI response
    Write-Host "After AI responds, paste their response here:" -ForegroundColor Yellow
    $aiResponse = Read-Host "[AI Response]"
    
    if (-not [string]::IsNullOrWhiteSpace($aiResponse)) {
        Add-Content -Path $logFileName -Value "**[$Persona]:** $aiResponse"
        Write-Host "✓ Response logged" -ForegroundColor Green
    }
    
    Write-Host ""
}

Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   SESSION ENDED" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "Log saved to: $logFileName" -ForegroundColor Gray
Write-Host "Total conversation turns: $turnCount" -ForegroundColor Gray
Write-Host "`nThank you, Executor R." -ForegroundColor Cyan