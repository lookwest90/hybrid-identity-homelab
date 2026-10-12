# Hybrid Identity Homelab
# ============================================================
# Windows Server AD DS Lab Reference
# Domain: lab.ramco.internal   NetBIOS: LAB
# ============================================================

# ---------- DC (winserver25) ----------

# Check current IP configuration
ipconfig /all

# Set static IP on DC (run on DC)
Set-NetIPInterface -InterfaceAlias "Ethernet0" -Dhcp Disabled
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 192.168.127.129 -PrefixLength 24 -DefaultGateway 192.168.127.2

# Point DC DNS at itself
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 192.168.127.129

# Remove a leased address before re-adding static (only if New-NetIPAddress reports a conflict)
Remove-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 192.168.127.129

# Verify DNS zone and self-resolution
Get-DnsServerZone
Resolve-DnsName lab.ramco.internal

# Install AD DS and promote (new forest), run on DC
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "lab.ramco.internal" -DomainNetbiosName "LAB" -InstallDns

# Create a domain user
# Note: <password> is prompted; do not type it in plain text
New-ADUser -Name "Jack Bauer" -GivenName "Jack" -Surname "Bauer" -SamAccountName "BauerJ" -UserPrincipalName "BauerJ@lab.ramco.internal" -AccountPassword (Read-Host -AsSecureString "Password") -Enabled $true

# Find a user by display name
Get-ADUser -Filter {Name -like "*Bauer*"} -Properties SamAccountName, UserPrincipalName, Enabled, LockedOut | Select-Object Name, SamAccountName, UserPrincipalName, Enabled, LockedOut

# Verify a specific user by logon name
# Note: <samaccountname> is a placeholder, e.g. BauerJ
Get-ADUser -Identity <samaccountname> -Properties Enabled, LockedOut, DistinguishedName

# Enable or unlock an account
# Note: <samaccountname> is a placeholder
Enable-ADAccount -Identity <samaccountname>
Unlock-ADAccount -Identity <samaccountname>

# List AD computer objects (after workstation join)
Get-ADComputer -Filter * | Select-Object Name

# Check a computer object
# Note: <hostname> is a placeholder, e.g. WIN-35PF0F89GKC
Get-ADComputer -Identity <hostname> -Properties DNSHostName, Enabled | Select-Object Name, DNSHostName, Enabled

# Check deleted objects (requires AD Recycle Bin for restore)
Get-ADObject -SearchBase "CN=Deleted Objects,DC=lab,DC=ramco,DC=internal" -IncludeDeletedObjects -Filter {Name -like "*Bauer*"} -Properties lastKnownParent

# Add a user to Domain Admins (only if full domain control is needed)
Add-ADGroupMember -Identity "Domain Admins" -Members <samaccountname>
# Note: <samaccountname> is a placeholder

# Check DC locator and DNS resolution
nltest /dsgetdc:lab.ramco.internal
nslookup lab.ramco.internal 192.168.127.129
dcdiag /test:dns

# Open ICMP echo (run on the machine that must answer ping)
New-NetFirewallRule -DisplayName "Allow ICMPv4 echo in" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow

# Set network profile to Private
Set-NetConnectionProfile -InterfaceAlias "Ethernet0" -NetworkCategory Private

# ---------- Workstation (Win11) ----------

# Point workstation DNS at the DC
# Note: adjust the interface alias if it differs (e.g. "Ethernet")
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.127.129

# Join the domain (prompts for DC Administrator password; do not put it on the command line)
Add-Computer -DomainName "lab.ramco.internal" -Credential LAB\Administrator -Restart

# Confirm domain session
whoami
whoami /groups

# Enable the built-in Administrator (run on a session that can elevate)
net user Administrator /active:yes

# Set the built-in Administrator password (prompts)
net user Administrator *

# List local accounts
Get-LocalUser

# Remove a local account
# Note: "Jack Bauer" is an example; use the exact name from Get-LocalUser
Remove-LocalUser -Name "Jack Bauer"

# Remove a leftover profile folder (confirm the folder name first)
# Note: "Jack Bauer" is an example; copy any needed files first
Remove-Item "C:\Users\Jack Bauer" -Recurse -Force

# Disable the built-in Administrator when no longer needed
net user Administrator /active:no

# ---------- Licensing (evaluation builds) ----------

# Check remaining rearm count
slmgr /dlv

# Reset the evaluation period (reboot afterward)
slmgr /rearm
