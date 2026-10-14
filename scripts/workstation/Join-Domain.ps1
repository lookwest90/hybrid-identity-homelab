<#
.SYNOPSIS
    Joins this computer to lab.ramco.internal.
.DESCRIPTION
    Prompts for a domain admin account and password, then joins the computer to the domain and restarts.
    Does nothing if the computer is already a domain member.
.NOTES
    Run on the Windows 11 client after DNS points to 172.16.156.10.
    Changes: joins the computer to the domain and reboots.
#>
#Requires -RunAsAdministrator

# Stop if already joined
$cs = Get-CimInstance Win32_ComputerSystem
if ($cs.PartOfDomain) {
    Write-Host "Already joined to $($cs.Domain). Nothing to do."
    return
}

# Confirm the DC is reachable before prompting for credentials
nltest /dsgetdc:lab.ramco.internal | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Cannot find a domain controller for lab.ramco.internal. Check DNS and the route."
    return
}

# Prompt for the domain account (for example RAMCO\Administrator)
$cred = Get-Credential -Message "Domain admin account for lab.ramco.internal"

Add-Computer -DomainName "lab.ramco.internal" -Credential $cred -Restart