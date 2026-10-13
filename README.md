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
