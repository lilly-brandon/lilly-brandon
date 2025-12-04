<#
.SYNOPSIS
    This PowerShell script ensures that Group Policy objects are reprocessed even if they have not changed. 

.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .STIG-ID-WN11-CC-000090.ps1 
#>

# Define registry path and value
$basePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
$valueName = "NoGPOListChanges"
$valueData = 0

# Check if the key exists, if not, create it
if (-not (Test-Path $basePath)) {
    Write-Host "Registry path does not exist. Creating..." -ForegroundColor Cyan
    New-Item -Path $basePath -Force | Out-Null
} else {
    Write-Host "Registry path exists." -ForegroundColor Green
}

# Set the value to 0 (DWORD)
Write-Host "Setting $valueName to $valueData..."
New-ItemProperty -Path $basePath -Name $valueName -PropertyType DWord -Value $valueData -Force | Out-Null

# Verify
Get-ItemProperty -Path $basePath | Select-Object $valueName
Write-Host "Registry configuration complete." -ForegroundColor Green
