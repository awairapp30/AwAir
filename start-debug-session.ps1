param(
    [Parameter(Mandatory=$true)] 
    [ValidateSet("gemini", "qwen", "iflow")] 
    [string]$Agent,
    
    [Parameter(Mandatory=$false)]
    [string]$ErrorMessage = "",
    
    [Parameter(ValueFromRemainingArguments=$true)] 
    [string[]]$InitialPromptArray
)

# --- DEBUGGING SESSION CONFIGURATION ---

# AI CLI commands
$aiCommands = @{
    "gemini" = "gemini"
    "qwen"   = "qwen"
    "iflow"  = "iflow"
}

$aiCommand = $aiCommands[$Agent]

# Test if command exists
try {
    $null = Get-Command $aiCommand -ErrorAction Stop
} catch {
    Write-Error "ERROR: Cannot find '$aiCommand' command. Is it installed?"
    Write-Host "Please install it using: npm install -g $aiCommand" -ForegroundColor Yellow
    return
}

# --- PREPARE DEBUGGING PROMPT ---
$initialPrompt = $InitialPromptArray -join " "

if ([string]::IsNullOrWhiteSpace($initialPrompt)) {
    if (-not [string]::IsNullOrWhiteSpace($ErrorMessage)) {
        $initialPrompt = "I encountered this error: $ErrorMessage. Help me diagnose and fix it."
    } else {
        $initialPrompt = "I need debugging assistance. First, request 'git status' and 'git diff' to see what changed."
    }
}

# --- VALIDATE PATHS ---
$masterNexusPath = ".\awair_nexus\awair-master-ai-knowledge-nexus.md"
$guardianPath = ".\awair_nexus\ai_profiles\The Smart Guardian for a Peaceful Development Workflow.md"
$docsPath = ".\awair_nexus\docs"

if (-not (Test-Path $masterNexusPath)) {
    Write-Error "ERROR: Cannot find master nexus file at: $masterNexusPath"
    return
}

if (-not (Test-Path $guardianPath)) {
    Write-Error "ERROR: Cannot find Guardian profile at: $guardianPath"
    return
}

if (-not (Test-Path $docsPath)) {
    Write-Error "ERROR: Cannot find docs folder at: $docsPath"
    return
}

Write-Host "`n" + "="*70 -ForegroundColor Red
Write-Host "   AWAIR DEBUGGING SESSION - GUARDIAN MODE" -ForegroundColor Red
Write-Host "="*70 -ForegroundColor Red

# --- LOAD CORE FILES ---
Write-Host "`n[1/4] Loading Master AI Knowledge Nexus..." -ForegroundColor Yellow
$masterNexusContent = Get-Content -Path $masterNexusPath -Raw
Write-Host "      ✓ Loaded successfully" -ForegroundColor Green

Write-Host "`n[2/4] Loading Guardian persona (Debugging Specialist)..." -ForegroundColor Yellow
$guardianContent = Get-Content -Path $guardianPath -Raw
Write-Host "      ✓ Guardian activated" -ForegroundColor Green

# --- LOAD ALL DEBUGGING PLAYBOOKS (FULL CONTENT) ---
Write-Host "`n[3/4] Loading ALL debugging playbooks (full content)..." -ForegroundColor Yellow

$debuggingFiles = @(
    "what happens when things go wrong.md",
    "The Complete AI Debugging Playbook for JavaScript, React & React Native.md",
    "Expo & React Native Debugging.md",
    "Master Debugging Playbook for Expo and React.md"
)

$debugContent = "`n" + "="*70 + "`n"
$debugContent += "COMPLETE DEBUGGING KNOWLEDGE BASE`n"
$debugContent += "="*70 + "`n"

$loadedCount = 0
foreach ($fileName in $debuggingFiles) {
    $filePath = Join-Path $docsPath $fileName
    if (Test-Path $filePath) {
        $fileContent = Get-Content -Path $filePath -Raw
        $debugContent += "`n`n" + "-"*70 + "`n"
        $debugContent += "FILE: $fileName`n"
        $debugContent += "-"*70 + "`n"
        $debugContent += $fileContent
        $debugContent += "`n" + "-"*70 + "`n"
        Write-Host "      ✓ $fileName" -ForegroundColor Green
        $loadedCount++
    } else {
        Write-Host "      ⚠ $fileName not found (skipping)" -ForegroundColor Yellow
    }
}

# --- LOAD ESSENTIAL ARCHITECTURE FILES ---
Write-Host "`n      Loading essential architecture files..." -ForegroundColor Yellow

$architectureFiles = @(
    "database-schema.md",
    "state-and-screen-architecture.md",
    "Technology Stack.md",
    "audio-architecture.md"
)

foreach ($fileName in $architectureFiles) {
    $filePath = Join-Path $docsPath $fileName
    if (Test-Path $filePath) {
        $fileContent = Get-Content -Path $filePath -Raw
        $debugContent += "`n`n" + "-"*70 + "`n"
        $debugContent += "ARCHITECTURE: $fileName`n"
        $debugContent += "-"*70 + "`n"
        $debugContent += $fileContent
        $debugContent += "`n" + "-"*70 + "`n"
        Write-Host "      ✓ $fileName" -ForegroundColor Green
        $loadedCount++
    }
}

$debugContent += "`n" + "="*70 + "`n"

# --- LOAD JAVASCRIPT ECOSYSTEM GUIDE ---
$ecosystemFile = "Entire Expo ecosystem.md"
$ecosystemPath = Join-Path $docsPath $ecosystemFile
$ecosystemContent = ""

if (Test-Path $ecosystemPath) {
    $ecosystemContent = Get-Content -Path $ecosystemPath -Raw
    Write-Host "      ✓ $ecosystemFile" -ForegroundColor Green
    $loadedCount++
}

Write-Host "`n      Total: $loadedCount files loaded" -ForegroundColor Green

# --- GATHER REAL-TIME AWARENESS ---
Write-Host "`n[4/4] Scanning for other active sessions..." -ForegroundColor Yellow

$realTimeAwareness = ""
if (Test-Path ".\conversations") {
    $otherLogs = Get-ChildItem -Path ".\conversations" -Filter "*.log.md" -File |
                 Sort-Object LastWriteTime -Descending |
                 Select-Object -First 3
    
    if ($otherLogs) {
        $realTimeAwareness = "`n" + "="*70 + "`n"
        $realTimeAwareness += "REAL-TIME AWARENESS - OTHER SESSIONS`n"
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
    New-Item -ItemType Directory -Path ".\conversations" | Out-Null
    Write-Host "      • Created conversations folder" -ForegroundColor Gray
}

# --- CREATE DEBUG SESSION LOG ---
$sessionID = (Get-Date).ToString("yyyyMMdd-HHmmss")
$logFileName = ".\conversations\$($sessionID)_DEBUG_Guardian_$($Agent).log.md"
$logHeader = @"
# 🐛 DEBUGGING SESSION LOG
**Agent:** $Agent
**Persona:** Guardian (Debug Mode)
**Session ID:** $sessionID
**Started:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Error Context:
$(if ($ErrorMessage) { "**Error Message:** $ErrorMessage" } else { "General debugging session" })

## Loaded Debug Resources:
- Master AI Knowledge Nexus
- Guardian Persona Profile (Debug Specialist)
- Complete Debugging Playbook Suite ($loadedCount files)
- Architecture References (database, state, tech stack, audio)
- Expo Ecosystem Guide

## Debug Protocol:
1. Gather evidence (git status, error logs, reproduction steps)
2. Form hypothesis based on playbooks
3. Test hypothesis systematically
4. Document solution

---
"@

Set-Content -Path $logFileName -Value $logHeader

# --- ASSEMBLE DEBUGGING CONTEXT ---
$debuggingContext = @"
============================================================
        AWAIR DEBUGGING SESSION - GUARDIAN MODE
============================================================
Agent: $Agent
Session ID: $sessionID
Started: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Mode: DEBUGGING (Guardian Persona - Full Diagnostic Power)

============================================================
    MASTER AI KNOWLEDGE NEXUS
============================================================

$masterNexusContent

============================================================
    GUARDIAN PERSONA - DEBUGGING SPECIALIST
============================================================

$guardianContent

============================================================
    COMPLETE DEBUGGING KNOWLEDGE BASE
============================================================

$debugContent

============================================================
    EXPO ECOSYSTEM REFERENCE
============================================================

$ecosystemContent

$realTimeAwareness

============================================================
    DEBUGGING MISSION
============================================================

$initialPrompt

============================================================
    UNIVERSAL DEBUGGING WORKFLOW (MANDATORY)
============================================================

You are Guardian in FULL DEBUGGING MODE. Follow this protocol:

PHASE 1: EVIDENCE GATHERING
- Request 'git status' to see current state
- Request 'git diff' to see recent changes
- Ask for the complete error message and stack trace
- Request reproduction steps
- Identify which file(s) are involved

PHASE 2: HYPOTHESIS FORMATION
- Reference the debugging playbooks loaded above
- Check against architecture files (database, state, audio)
- Consider common patterns from "what happens when things go wrong"
- Form a testable hypothesis about the root cause

PHASE 3: SYSTEMATIC TESTING
- Propose a minimal test to verify hypothesis
- If hypothesis fails, iterate with new evidence
- Reference specific sections of playbooks as needed

PHASE 4: SOLUTION & PREVENTION
- Provide the fix with clear explanation
- Reference which blueprint/pattern it should follow
- Suggest preventive measures for the future

CRITICAL REMINDERS:
- You have ALL debugging playbooks loaded - use them!
- Challenge assumptions, even if they seem obvious
- Every fix must align with project blueprints
- Document your reasoning for future reference

============================================================
"@

# --- DISPLAY SESSION INFO ---
Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   DEBUGGING CONTEXT LOADED" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "`nAgent:      " -NoNewline; Write-Host $Agent -ForegroundColor Yellow
Write-Host "Persona:    " -NoNewline; Write-Host "Guardian (Debug Mode)" -ForegroundColor Red
Write-Host "Session ID: " -NoNewline; Write-Host $sessionID -ForegroundColor Gray
Write-Host "`nLog file: " -NoNewline; Write-Host $logFileName -ForegroundColor Gray

if ($ErrorMessage) {
    Write-Host "`n⚠ ERROR TO DEBUG:" -ForegroundColor Red
    Write-Host "  $ErrorMessage" -ForegroundColor Yellow
}

Write-Host "`nLoaded Resources:" -ForegroundColor Cyan
Write-Host "  • Master Nexus & Guardian (Debug Specialist)" -ForegroundColor White
Write-Host "  • $loadedCount debugging & architecture files" -ForegroundColor White
Write-Host "  • Complete Expo ecosystem guide" -ForegroundColor White
if ($otherLogs) {
    Write-Host "  • Real-time awareness of $($otherLogs.Count) other session(s)" -ForegroundColor White
}
Write-Host "="*70 -ForegroundColor Green

# --- START AI PROCESS ---
Write-Host "`nStarting $Agent CLI in debug mode..." -ForegroundColor Yellow

$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = "powershell.exe"
$processInfo.Arguments = "-NoExit -Command `"cd '$pwd'; Write-Host '🐛 DEBUG MODE' -ForegroundColor Red; $aiCommand`""
$processInfo.WorkingDirectory = (Get-Location).Path
$processInfo.UseShellExecute = $true

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

Write-Host "✓ $Agent CLI launched in debug mode" -ForegroundColor Green

# --- COPY CONTEXT TO CLIPBOARD ---
Set-Clipboard -Value $debuggingContext
Write-Host "`n✓ Complete debugging context copied to clipboard" -ForegroundColor Green

# --- INTERACTIVE DEBUG LOOP ---
Write-Host "`n" + "="*70 -ForegroundColor Cyan
Write-Host "   INTERACTIVE DEBUGGING SESSION" -ForegroundColor Cyan
Write-Host "="*70 -ForegroundColor Cyan
Write-Host "`nDebug Commands:" -ForegroundColor Yellow
Write-Host "  'paste'    - Copy context to clipboard again" -ForegroundColor Gray
Write-Host "  'log'      - Show log file location" -ForegroundColor Gray
Write-Host "  'stack'    - Paste a stack trace" -ForegroundColor Gray
Write-Host "  'solved'   - Mark bug as solved and end session" -ForegroundColor Gray
Write-Host "  'exit'     - End session" -ForegroundColor Gray
Write-Host "`nPaste the context into $Agent window now, then return here." -ForegroundColor White
Write-Host "="*70 -ForegroundColor Cyan

Write-Host "`n" + "!"*70 -ForegroundColor Yellow
Write-Host "   CRITICAL: YOU MUST PASTE THE CONTEXT NOW!" -ForegroundColor Yellow
Write-Host "!"*70 -ForegroundColor Yellow
Write-Host "`nIn the $Agent window that just opened:" -ForegroundColor Cyan
Write-Host "  1. Click inside the $Agent window" -ForegroundColor White
Write-Host "  2. Press Ctrl+V to paste the complete context" -ForegroundColor White
Write-Host "  3. Press Enter to send it" -ForegroundColor White
Write-Host "  4. Wait for Guardian to acknowledge (should mention playbooks)" -ForegroundColor White
Write-Host "`nThe context is already in your clipboard - just press Ctrl+V!" -ForegroundColor Green
Write-Host "!"*70 -ForegroundColor Yellow

$null = Read-Host "`nPress Enter ONLY AFTER Guardian acknowledged the context"

Write-Host "`n✓ Starting debug loop..." -ForegroundColor Green
Write-Host "Guardian is ready to debug. Start by providing git status or error details." -ForegroundColor Gray
Write-Host ""

# Verify AI received context
Write-Host "⚠ VERIFICATION CHECK:" -ForegroundColor Yellow
$verified = Read-Host "Did Guardian acknowledge the debugging playbooks? (y/n)"
if ($verified.ToLower() -ne "y") {
    Write-Host "`n⚠ WARNING: Guardian may not have proper context!" -ForegroundColor Red
    Write-Host "Type 'paste' anytime to copy context again and re-paste it." -ForegroundColor Yellow
    Write-Host ""
}

$turnCount = 0
$bugSolved = $false

while ($true) {
    $turnCount++
    
    Write-Host "[Debug Turn $turnCount] " -NoNewline -ForegroundColor Red
    $userInput = Read-Host "[Executor R]"
    
    # Handle special commands
    if ($userInput.ToLower() -in @("exit", "quit", "bye")) {
        Write-Host "`nEnding debug session..." -ForegroundColor Yellow
        Add-Content -Path $logFileName -Value "`n`n--- Debug Session Ended @ $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---`nTotal Turns: $turnCount`nStatus: $(if ($bugSolved) { 'SOLVED ✓' } else { 'INCOMPLETE' })"
        break
    }
    
    if ($userInput.ToLower() -eq "solved") {
        $bugSolved = $true
        Write-Host "`n🎉 Bug marked as SOLVED!" -ForegroundColor Green
        Add-Content -Path $logFileName -Value "`n`n--- BUG SOLVED @ $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---`nTotal Turns: $turnCount"
        
        $summary = Read-Host "`nBrief solution summary"
        if (-not [string]::IsNullOrWhiteSpace($summary)) {
            Add-Content -Path $logFileName -Value "`n**Solution:** $summary"
        }
        
        Write-Host "Debug session complete. Excellent work!" -ForegroundColor Green
        break
    }
    
    if ($userInput.ToLower() -eq "paste") {
        Set-Clipboard -Value $debuggingContext
        Write-Host "✓ Debug context copied to clipboard again" -ForegroundColor Green
        continue
    }
    
    if ($userInput.ToLower() -eq "log") {
        Write-Host "Log file: $logFileName" -ForegroundColor Cyan
        continue
    }
    
    if ($userInput.ToLower() -eq "stack") {
        Write-Host "`nPaste the complete stack trace (press Enter twice when done):" -ForegroundColor Yellow
        $stackTrace = ""
        $emptyLineCount = 0
        while ($emptyLineCount -lt 2) {
            $line = Read-Host
            if ([string]::IsNullOrWhiteSpace($line)) {
                $emptyLineCount++
            } else {
                $emptyLineCount = 0
                $stackTrace += $line + "`n"
            }
        }
        
        Add-Content -Path $logFileName -Value "`n--- STACK TRACE @ $(Get-Date -Format 'HH:mm:ss') ---`n$stackTrace`n---"
        Write-Host "✓ Stack trace logged. Tell Guardian about it." -ForegroundColor Green
        continue
    }
    
    # Log user input
    Add-Content -Path $logFileName -Value "`n--- Turn $turnCount @ $(Get-Date -Format 'HH:mm:ss') ---"
    Add-Content -Path $logFileName -Value "**[Executor R]:** $userInput"
    
    # Prompt for AI response
    Write-Host "`nAfter Guardian responds, paste response here:" -ForegroundColor Yellow
    $aiResponse = Read-Host "[Guardian]"
    
    if (-not [string]::IsNullOrWhiteSpace($aiResponse)) {
        Add-Content -Path $logFileName -Value "**[Guardian]:** $aiResponse"
        Write-Host "✓ Response logged" -ForegroundColor Green
    }
    
    Write-Host ""
}

Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   DEBUG SESSION ENDED" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "Status: " -NoNewline
if ($bugSolved) {
    Write-Host "SOLVED ✓" -ForegroundColor Green
} else {
    Write-Host "INCOMPLETE" -ForegroundColor Yellow
}
Write-Host "Log saved to: $logFileName" -ForegroundColor Gray
Write-Host "Total debug turns: $turnCount" -ForegroundColor Gray
