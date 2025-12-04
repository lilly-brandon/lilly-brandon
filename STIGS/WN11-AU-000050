<#
.SYNOPSIS
    This PowerShell script ensures that the system is configured to audit Detailed Tracking – Process Creation events for successes.

.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000050

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000050.ps1 
#>

Write-Host "Applying Advanced Audit Policy configuration..." -ForegroundColor Cyan

# --- NOT CONFIGURED ---
# Equivalent to the box NOT checked in Local Security Policy

$notConfigured = @(
    "DPAPI Activity",
    "Plug and Play Events",
    "Process Termination",
    "RPC Events",
    "Token Right Adjusted Events"
)

foreach ($subcategory in $notConfigured) {
    Write-Host "Setting '$subcategory' to Not Configured..."
    auditpol.exe /set /subcategory:"$subcategory" /success:disable /failure:disable | Out-Null
}

# --- CONFIGURED: SUCCESS ONLY ---
# Equivalent to the box checked AND "Success" selected

Write-Host "Setting 'Process Creation' to Success only..."
auditpol.exe /set /subcategory:"Process Creation" /success:enable /failure:disable | Out-Null

Write-Host "Audit Policy configuration complete." -ForegroundColor Green
