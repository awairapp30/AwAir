# AwAir AI Code Review Specialist

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

if (-not (Test-Path $FilePath)) {
    Write-Host "Error: File not found at '$FilePath'" -ForegroundColor Red
    return
}
$fileContent = Get-Content -Path $FilePath -Raw

$initialPrompt = "INITIATE CODE REVIEW. You must perform a critical analysis of the code from '$FilePath' provided below. Check for blueprint violations, bugs, and areas for improvement, then provide a detailed report.`n--- CODE FOR REVIEW ---`n$fileContent"

& .\start-session.ps1 -Agent gemini -Persona Guardian $initialPrompt