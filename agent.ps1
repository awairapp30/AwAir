# AwAir AI Agent CLI Wrapper v5.5 - Definitive Version

# --- 1. ROBUST MANUAL ARGUMENT PARSING ---
$Agent = "gemini" # Default agent
$PromptArray = @() # Initialize an empty array for the prompt parts

if ($args.Count -gt 1 -and ($args[0] -eq '-Agent' -or $args[0] -eq '-agent')) {
    # Case: User specified an agent, e.g., .\agent.ps1 -Agent qwen "prompt"
    $Agent = $args[1]
    if ($args.Count -gt 2) {
        $PromptArray = $args[2..($args.Count - 1)]
    }
} else {
    # Case: No agent was specified, all arguments are the prompt
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
        # Modify the user's prompt to include the status output for the first turn
        $userPrompt = "Here is the output from the mandatory initial 'git status' command:`n<command_output>`n$gitStatusOutput`n</command_output>`nNow, please provide the full project status report and suggest the next steps."
        Write-Host "--- GIT STATUS CAPTURED ---"
        Write-Host $gitStatusOutput
        Write-Host "-----------------------