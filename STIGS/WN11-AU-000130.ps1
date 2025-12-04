<#
.SYNOPSIS
    This PowerShell script ensures that the system is configured to audit System – Other System Events successes and that audit policy subcategory settings override category settings.

.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000130

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000130.ps1 
#>

# --- Step 1: Enable "Force audit policy subcategory settings to override audit policy category settings" ---

# Registry path for the policy
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "SCENoApplyLegacyAuditPolicy"
$desiredValue = 1

Write-Host "Enabling 'Force audit policy subcategory settings to override category settings'..." -ForegroundColor Cyan
# Create or set the value
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWORD -Value $desiredValue -Force | Out-Null

Write-Host "'Force audit policy subcategory settings' enabled." -ForegroundColor Green

# --- Step 2: Configure 'System -> Other System Events' to audit Success ---

$subcategory = "Other System Events"
Write-Host "Configuring '$subcategory' to audit Success events..." -ForegroundColor Cyan

# Force Success + Failure first to avoid auditpol errors (if needed)
auditpol /set /subcategory:"$subcategory" /success:enable /failure:enable | Out-Null

# Then set Success only
auditpol /set /subcategory:"$subcategory" /success:enable /failure:disable | Out-Null

# Verify the setting
Write-Host "`nCurrent audit settings for '$subcategory':"
auditpol /get /subcategory:"$subcategory"

Write-Host "`nAudit configuration complete for WN11-AU-000130." -ForegroundColor Green

