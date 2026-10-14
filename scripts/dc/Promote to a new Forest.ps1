<#
.SYNOPSIS
    Promotes the server to a new forest for lab.ramco.internal.
.DESCRIPTION
    Sets the static IP, installs AD DS, and promotes the server. Prompts for the DSRM password.
.NOTES
    Assumes a fresh Windows Server 2025 install with the VMnet8 address planned as 172.16.156.10.
    Changes: IP config, DNS, AD DS role, forest creation. Server reboots.
#>
#Requires -RunAsAdministrator
$adapter = (Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1).Name
New-NetIPAddress -InterfaceAlias $adapter -IPAddress 172.16.156.10 -PrefixLength 24 -DefaultGateway 172.16.156.2

#Notes: New-NetIPAddress will fail if the address is already set
Set-DnsClientServerAddress -InterfaceAlias $adapter -ServerAddresses 172.16.156.10

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

$dsrmPw = Read-Host "DSRM password" -AsSecureString
#Notes: Promted for password input

Install-ADDSForest -DomainName "lab.ramco.internal" -DomainNetbiosName "RAMCO" -InstallDns -SafeModeAdministratorPassword $dsrmPw -Force

# Verify
nltest /dsgetdc:lab.ramco.internal
Resolve-DnsName lab.ramco.internal
Get-ADDomain | Select-Object Name, DNSRoot, NetBIOSName

