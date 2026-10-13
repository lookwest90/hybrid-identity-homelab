# Hybrid Identity Homelab
This is a project where I am teaching myself how to use Active Directory.
Please be patient
#
VMWare.
Windows Server 25 settings.
Memory: 2GB.
Processor: 2.
Hard Disk: 60GB.
CD/DVD (SATA): Auto Detect.
Network Adapter: NAT.
USB Controller: Present.
Sound Card: Auto.
Display: Auto.
#
Windows 11 x64 settings.
Memory: 4GB.
Processor: 2.
Hard Disk: 64GB.
CD/DVD (SATA): Auto Detect.
Network Adapter: NAT.
USB Controller: Present.
Sound Card: Auto.
Display: Auto.
Trusted Platform Module: Present.

# Steps
1. New VM with Windows Server 2025
2. Set admin pass
3. Static IP - see commands for reference
4. install AD DS and promote to a new forest (lab.ramco.internal) - see commands reference
5. Create a user (Bauerj) with the "create a domain user" command - see commands reference
6. make a second VM using Windows 11 x64 (pro or enterprise because home aint it)
7. Set DNS as Server25's static IP and check with nltest
8. join the domain with Add-Computer command
9. Sign in and verify user is on domain

# Roadmap

### Phase 1: Core AD DS Deployment (Completed)
- [x] VMware virtual network configuration
- [x] Windows Server 2025 domain controller deployment (`lab.ramco.internal`)
- [x] Static IP configuration and local DNS self-resolution
- [x] Windows 11 client workstation domain join
- [x] Basic AD user account provisioning via PowerShell

### Phase 2: Core Infrastructure Services (In Progress)
- [ ] Configure local DNS forwarders and reverse lookup zones
- [ ] Deploy DHCP role on Windows Server with active scopes and reservations
- [ ] Create and enforce baseline Group Policy Objects (GPOs) for client endpoints

### Phase 3: Advanced Network & Multi-Site Architecture (Planned)
- [ ] Deploy a second Domain Controller for redundancy
- [ ] Configure Active Directory Sites and Services across multiple IP subnets
- [ ] Implement virtual firewall (pfSense/OPNsense) for network segment isolation

### Phase 4: Identity Security & Enterprise Hardening (Planned)
- [ ] Implement AD Delegation (Least Privilege administration)
- [ ] Enforce Fine-Grained Password Policies
- [ ] Centralize audit logging for failed logons and account lockouts

### Phase 5: Cloud & Hybrid Identity (Planned)
- [ ] Set up a free Entra ID tenant
- [ ] Deploy Microsoft Entra Connect to synchronize on-premises AD DS users to the cloud
- [ ] Implement Mobile OS VMs to simulate external device handling


