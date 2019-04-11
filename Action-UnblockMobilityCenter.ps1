####################################################
#
#     Author: Jack O'Connor
#     Description: Stop Mobility Center Being Blocked On Desktop PC (for current user)
#
####################################################

# Force mobility center to work on a non-mobile device.
New-Item -Path "HKCU:\Software\Microsoft\MobilePC\MobilityCenter" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\MobilePC\MobilityCenter" -Name "RunOnDesktop" -Value 1 -Force