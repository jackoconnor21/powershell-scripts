#####################################################################################
#
#     Install Wrapper: [App Name]
#     Author: Jack O'Connor - C5 Alliance
#     Modified By: [Your Name]
#     Date Packaged: [Date]
#     Usage: Powershell.exe -ExecutionPolicy bypass -File Invoke-SilentInstall.ps1
#     Description: Silent Install Wrapper Template For MSIs
#
#####################################################################################

###### Variables To Edit
$MSI = "" # Without the .msi
$DeskShortcuts = "" # An array of shortcuts to remove from the Desktop (if any) E.G. "Shortcut1", "Shortcut2" (without the .lnk)
$StartShortcuts = "" # An array of shortcuts to remove from the Start Menu (if any), without the .lnk
$AdditionalMSIArgs = "ALLUSERS=1" # Any additional MSI arguments you need to use

############################################################
#
#   No need to edit beyond this point unless multiple MSIs
#
############################################################

# Get the current working directory of the script
$WorkingDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

# MSI Variables
$MSIArgs = "/qn /norestart /l*v `"$($ENV:windir)\Temp\$($MSI)_Inst.LOG`" $($AdditionalMSIArgs)"
$FullArgs = "/i " + """$($WorkingDir)\$($MSI).msi"" " + "$($MSIArgs) "

# Uncomment to test the full MSI arguments if required
# $FullArgs

# Run the MSI File with required arguments
Start-Process "msiexec.exe" -ArgumentList $FullArgs -Wait -NoNewWindow

# Delete any given desktop shortcuts
foreach ($shortcut in $DeskShortcuts) {
    Remove-Item -Path "$($ENV:PUBLIC)\Desktop\$shortcut.lnk" -ErrorAction SilentlyContinue
}

# Delete any given start menu shortcuts
foreach ($shortcut in $StartShortcuts) {
    Remove-Item -Path "$($env:ProgramData)\Microsoft\Windows\Start Menu\Programs\$shortcut.lnk" -Force -ErrorAction SilentlyContinue
}

############################################################
#
#     All Custom Post-Install Code Below This Point
#
############################################################

## END
