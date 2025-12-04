<#
.SYNOPSIS
    This PowerShell script ensures that printing over HTTP is prevented.
    
.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000110.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableHTTPPrinting"
$valueData = 1

# Check if the key exists, create it if missing
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating..." -ForegroundColor Cyan
    New-Item -Path $regPath -Force | Out-Null
} else {
    Write-Host "Registry path exists." -ForegroundColor Green
}

# Set the value to 1 (DWORD) to disable HTTP printing
Write-Host "Setting $valueName to $valueData..."
New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $valueData -Force | Out-Null

# Verify the setting
$currentValue = Get-ItemProperty -Path $regPath | Select-Object -ExpandProperty $valueName
Write-Host "`nCurrent value of $valueName is $currentValue"

Write-Host "`nPrinting over HTTP registry configuration complete." -ForegroundColor Green


