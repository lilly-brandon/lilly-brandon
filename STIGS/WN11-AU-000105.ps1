<#
.SYNOPSIS
    This PowerShell script ensures that the system is configured to audit Policy Change – Authentication Policy Change events for successes.
    
.NOTES
    Author          : Brandon Lilly
    LinkedIn        : https://www.linkedin.com/in/brandon-lilly-92743a392/
    GitHub          : https://github.com/lilly-brandon
    Date Created    : 12-04-2025
    Last Modified   : 12-04-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000105

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000105.ps1 
#>

auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:disable
