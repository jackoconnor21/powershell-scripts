####################################################
#
#     Author: Jack O'Connor
#     Description: Turn on and configure windows update and p2p
#
####################################################

# Turn on the windows update service
Set-Service wuauserv -StartupType Manual

# Set Branch Readiness to Semi Annual (10 for targeted)
Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "BranchReadiness" -Value 20

# Set Delivery Optimization Download Mode to Local and Internet Only
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "DownloadMode" -Value 3