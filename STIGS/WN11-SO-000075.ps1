<#
.SYNOPSIS
    This PowerShell script ensures that the required legal notice is configured to display before console logon.
.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000075

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-SO-000075.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "LegalNoticeText"

# Define the legal notice text
$legalNoticeText = @"
You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.

-At any time, the USG may inspect and seize data stored on this IS.

-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.

-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.
"@

# Check if the registry path exists, create it if missing
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating..." -ForegroundColor Cyan
    New-Item -Path $regPath -Force | Out-Null
} else {
    Write-Host "Registry path exists." -ForegroundColor Green
}

# Set the legal notice text
Write-Host "Setting LegalNoticeText..."
New-ItemProperty -Path $regPath -Name $valueName -PropertyType String -Value $legalNoticeText -Force | Out-Null

# Verify the setting
$currentValue = Get-ItemProperty -Path $regPath | Select-Object -ExpandProperty $valueName
Write-Host "`nCurrent LegalNoticeText value:"
Write-Host $currentValue

Write-Host "`nLegal notice configuration complete." -ForegroundColor Green


