<#
.SYNOPSIS
    Adding Organizational Units
.DESCRIPTION
    Creating OUs and adding user to the OUs
.NOTES
    User is prompted for input of OU name. Replaces $OUName with user input to create OU. If OU already exists, error will be thrown and stop.
	If nothing is typed in and ENTER is hit, cmdlet fails.
#>

$OUName = Read-Host "OU name"
New-ADOrganizationalUnit -Name $OUName -Path "DC=lab,DC=ramco,DC=internal"
Write-Host "Created $OUName"