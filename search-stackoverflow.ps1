param(
    [Parameter(Mandatory=$true)] 
    [ValidateSet("gemini", "qwen", "iflow")] 
    [string]$Agent,
    
    [Parameter(Mandatory=$false)]
    [string]$Query = "",
    
    [Parameter(Mandatory=$false)]
    [string]$ErrorMessage = "",
    
    [Parameter(ValueFromRemainingArguments=$true)] 
    [string[]]$AdditionalContext
)

# --- STACKOVERFLOW SEARCH CONFIGURATION ---

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

# --- BUILD SEARCH QUERY ---
$searchQuery = ""
$contextInfo = $AdditionalContext -join " "

if (-not [string]::IsNullOrWhiteSpace($Query)) {
    $searchQuery = $Query
} elseif (-not [string]::IsNullOrWhiteSpace($ErrorMessage)) {
    $searchQuery = $ErrorMessage
} else {
    Write-Host "No query provided. Please enter your search:" -ForegroundColor Yellow
    $searchQuery = Read-Host "Search"
}

# Add AwAir tech stack context
$techStackContext = "React Native, Expo, Firebase, JavaScript"

Write-Host "`n" + "="*70 -ForegroundColor Cyan
Write-Host "   STACK OVERFLOW SEARCH SESSION" -ForegroundColor Cyan
Write-Host "="*70 -ForegroundColor Cyan
Write-Host "`nAgent:      " -NoNewline; Write-Host $Agent -ForegroundColor Yellow
Write-Host "Query:      " -NoNewline; Write-Host $searchQuery -ForegroundColor White
if ($contextInfo) {
    Write-Host "Context:    " -NoNewline; Write-Host $contextInfo -ForegroundColor Gray
}
Write-Host "Tech Stack: " -NoNewline; Write-Host $techStackContext -ForegroundColor Gray
Write-Host "="*70 -ForegroundColor Cyan

# --- CREATE LOG ---
if (-not (Test-Path ".\conversations")) {
    New-Item -ItemType Directory -Path ".\conversations" | Out-Null
}

$sessionID = (Get-Date).ToString("yyyyMMdd-HHmmss")
$logFileName = ".\conversations\$($sessionID)_STACKOVERFLOW_$($Agent).log.md"
$logHeader = @"
# 🔍 Stack Overflow Search Session
**Agent:** $Agent
**Session ID:** $sessionID
**Started:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Search Query:
$searchQuery

## Additional Context:
$contextInfo

## Tech Stack:
$techStackContext

---
"@

Set-Content -Path $logFileName -Value $logHeader

# --- BUILD SEARCH PROMPT ---
$searchPrompt = @"
============================================================
        STACK OVERFLOW SEARCH MISSION
============================================================

You are a specialized search assistant helping with AwAir development.

YOUR TECH STACK CONTEXT:
- Frontend: React Native with Expo (SDK 51+)
- Backend: Firebase (Firestore, Auth, Storage)
- State Management: React Context API
- Audio: Expo AV, react-native-sound
- Language: JavaScript (ES6+)
- Platform: iOS and Android

SEARCH QUERY:
$searchQuery

$(if ($contextInfo) { "ADDITIONAL CONTEXT:`n$contextInfo`n" } else { "" })

YOUR MISSION:
1. Search Stack Overflow for solutions related to this query
2. Focus on answers that are:
   - Recent (prefer 2023-2025)
   - Highly upvoted
   - Specifically for React Native/Expo/Firebase
   - Complete with code examples

3. For each solution found, provide:
   - Brief summary of the problem
   - The accepted/highest-voted solution approach
   - Code snippet if available
   - Why this solution works for our tech stack
   - Any caveats or version-specific issues

4. Prioritize solutions that:
   - Work with Expo (not just bare React Native)
   - Don't require ejecting from Expo
   - Are compatible with Firebase v9+ modular syntax
   - Follow React Native best practices

5. If multiple solutions exist, rank them by:
   - Relevance to our exact tech stack
   - Recency
   - Completeness
   - Community validation (upvotes)

SEARCH STRATEGY:
- Start with exact error message if provided
- Broaden to general concept if no exact matches
- Include "react native expo" in searches
- Filter for solutions that work with managed workflow

OUTPUT FORMAT:
For each solution, provide:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SOLUTION #X: [Brief Title]
Source: [Stack Overflow link]
Votes: [Number] | Year: [Year]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Problem Summary:
[What issue this solves]

Solution Approach:
[How it works]

Code Example:
\`\`\`javascript
[Actual code if available]
\`\`\`

Why This Works for AwAir:
[Relevance to our stack]

Caveats:
[Any warnings or limitations]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Begin your search now!
============================================================
"@

# --- DISPLAY SEARCH INFO ---
Write-Host "`n📋 Search Configuration:" -ForegroundColor Cyan
Write-Host "  • Query: $searchQuery" -ForegroundColor White
Write-Host "  • Focus: React Native + Expo + Firebase solutions" -ForegroundColor White
Write-Host "  • Filters: Recent, high votes, Expo-compatible" -ForegroundColor White
Write-Host "`nLog file: " -NoNewline; Write-Host $logFileName -ForegroundColor Gray

# --- START AI PROCESS ---
Write-Host "`nStarting $Agent CLI for web search..." -ForegroundColor Yellow

$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = "powershell.exe"
$processInfo.Arguments = "-NoExit -Command `"cd '$pwd'; Write-Host '🔍 STACKOVERFLOW SEARCH MODE' -ForegroundColor Cyan; $aiCommand`""
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

Write-Host "✓ $Agent CLI launched in search mode" -ForegroundColor Green

# --- COPY SEARCH PROMPT TO CLIPBOARD ---
Set-Clipboard -Value $searchPrompt
Write-Host "`n✓ Search prompt copied to clipboard" -ForegroundColor Green

# --- INSTRUCTIONS ---
Write-Host "`n" + "!"*70 -ForegroundColor Yellow
Write-Host "   PASTE THE SEARCH PROMPT NOW!" -ForegroundColor Yellow
Write-Host "!"*70 -ForegroundColor Yellow
Write-Host "`nIn the $Agent window that just opened:" -ForegroundColor Cyan
Write-Host "  1. Click inside the $Agent window" -ForegroundColor White
Write-Host "  2. Press Ctrl+V to paste the search prompt" -ForegroundColor White
Write-Host "  3. Press Enter to start the search" -ForegroundColor White
Write-Host "  4. Wait for AI to search Stack Overflow and provide results" -ForegroundColor White
Write-Host "`n$Agent will use web search to find Stack Overflow solutions!" -ForegroundColor Green
Write-Host "!"*70 -ForegroundColor Yellow

$null = Read-Host "`nPress Enter after pasting the search prompt"

# --- INTERACTIVE SEARCH SESSION ---
Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   SEARCH SESSION ACTIVE" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "`nCommands:" -ForegroundColor Yellow
Write-Host "  'refine [new query]'  - Search with refined query" -ForegroundColor Gray
Write-Host "  'related'             - Find related problems" -ForegroundColor Gray
Write-Host "  'paste'               - Copy original prompt again" -ForegroundColor Gray
Write-Host "  'save'                - Save results and exit" -ForegroundColor Gray
Write-Host "  'exit'                - End session" -ForegroundColor Gray
Write-Host ""

$searchCount = 0

while ($true) {
    $searchCount++
    
    Write-Host "[Search #$searchCount] " -NoNewline -ForegroundColor Cyan
    $userInput = Read-Host "[Executor R]"
    
    # Handle commands
    if ($userInput.ToLower() -in @("exit", "quit", "bye")) {
        Write-Host "`nEnding search session..." -ForegroundColor Yellow
        Add-Content -Path $logFileName -Value "`n`n--- Search Session Ended @ $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ---`nTotal Searches: $searchCount"
        break
    }
    
    if ($userInput.ToLower() -eq "save") {
        Write-Host "`nPaste the AI's final results here (press Enter twice when done):" -ForegroundColor Yellow
        $results = ""
        $emptyLineCount = 0
        while ($emptyLineCount -lt 2) {
            $line = Read-Host
            if ([string]::IsNullOrWhiteSpace($line)) {
                $emptyLineCount++
            } else {
                $emptyLineCount = 0
                $results += $line + "`n"
            }
        }
        
        if (-not [string]::IsNullOrWhiteSpace($results)) {
            Add-Content -Path $logFileName -Value "`n`n--- SEARCH RESULTS ---`n$results`n--- END RESULTS ---"
            Write-Host "✓ Results saved to log file" -ForegroundColor Green
        }
        
        Write-Host "Search session complete!" -ForegroundColor Green
        break
    }
    
    if ($userInput.ToLower() -eq "paste") {
        Set-Clipboard -Value $searchPrompt
        Write-Host "✓ Original search prompt copied to clipboard" -ForegroundColor Green
        continue
    }
    
    if ($userInput.ToLower() -eq "related") {
        $relatedPrompt = @"
Based on the previous search, find related Stack Overflow questions about:
- Similar errors or issues
- Alternative approaches to the same problem
- Common pitfalls in this area
- Best practices for this use case

Focus on our tech stack: React Native + Expo + Firebase
"@
        Set-Clipboard -Value $relatedPrompt
        Write-Host "✓ Related search prompt copied to clipboard - paste it in $Agent" -ForegroundColor Green
        Add-Content -Path $logFileName -Value "`n--- Related Search Request @ $(Get-Date -Format 'HH:mm:ss') ---"
        continue
    }
    
    if ($userInput.ToLower().StartsWith("refine ")) {
        $refinedQuery = $userInput.Substring(7).Trim()
        $refinedPrompt = @"
NEW SEARCH QUERY: $refinedQuery

Use the same search strategy as before:
- Focus on React Native + Expo + Firebase
- Prefer recent, highly-voted answers
- Provide code examples
- Explain relevance to our tech stack

Begin refined search now!
"@
        Set-Clipboard -Value $refinedPrompt
        Write-Host "✓ Refined search prompt copied to clipboard - paste it in $Agent" -ForegroundColor Green
        Add-Content -Path $logFileName -Value "`n--- Refined Search: $refinedQuery @ $(Get-Date -Format 'HH:mm:ss') ---"
        continue
    }
    
    # Log user input
    Add-Content -Path $logFileName -Value "`n--- Interaction @ $(Get-Date -Format 'HH:mm:ss') ---"
    Add-Content -Path $logFileName -Value "**[Executor R]:** $userInput"
    
    # Prompt for AI response
    Write-Host "After AI responds, paste brief summary here (or 'skip'):" -ForegroundColor Yellow
    $aiResponse = Read-Host "[Response Summary]"
    
    if ($aiResponse.ToLower() -ne "skip" -and -not [string]::IsNullOrWhiteSpace($aiResponse)) {
        Add-Content -Path $logFileName -Value "**[AI Summary]:** $aiResponse"
        Write-Host "✓ Logged" -ForegroundColor Green
    }
    
    Write-Host ""
}

Write-Host "`n" + "="*70 -ForegroundColor Green
Write-Host "   SEARCH SESSION ENDED" -ForegroundColor Green
Write-Host "="*70 -ForegroundColor Green
Write-Host "Log saved to: $logFileName" -ForegroundColor Gray
Write-Host "Total searches performed: $searchCount" -ForegroundColor Gray
Write-Host "`nResults are available in the log file." -ForegroundColor Cyan
