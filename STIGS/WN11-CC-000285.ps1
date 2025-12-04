<#
.SYNOPSIS
    This Powershell script configures the system to require secure RPC communication for Remote Desktop Session Host by setting the registry value fEncryptRPCTraffic to 1.

.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000285.ps1 
#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$ValueName = "fEncryptRPCTraffic"
$DesiredValue = 1

Write-Host "Checking registry path..." -ForegroundColor Cyan
if (-not (Test-Path $RegPath)) {
    Write-Host "Path does not exist. Creating..." -ForegroundColor Yellow
    New-Item -Path $RegPath -Force | Out-Null
}

Write-Host "Setting '$ValueName' to $DesiredValue..." -ForegroundColor Cyan
New-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -PropertyType DWORD -Force | Out-Null

Write-Host "Final value:" -ForegroundColor Green
Get-ItemProperty -Path $RegPath | Select-Object $ValueName

Write-Host "`nDone. Remote Desktop Session Host is now configured to require secure RPC communications." -ForegroundColor Green


