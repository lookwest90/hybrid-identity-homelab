<#
.SYNOPSIS
    Verify and add users.
.DESCRIPTION
    Sets a password for user, $pw will store output as secure string and not clear text. Creates AD User, SamAccount name, Prinicpal Name and password policy
.NOTES
    Create user, set password and policy
#>
param(
    [Parameter(Mandatory)] [string]$Name,
    [Parameter(Mandatory)] [string]$SamAccountName,
    [Parameter(Mandatory)] [string]$OU
)
$pw = Read-Host "Password for $Name" -AsSecureString
New-ADUser -Name $Name -SamAccountName $SamAccountName -UserPrincipalName "$SamAccountName@lab.ramco.internal" -Path "OU=$OU,DC=lab,DC=ramco,DC=internal" -AccountPassword $pw -Enabled $true -PasswordNeverExpires $true
Get-ADUser $SamAccountName | Select-Object Name, Enabled, SamAccountName