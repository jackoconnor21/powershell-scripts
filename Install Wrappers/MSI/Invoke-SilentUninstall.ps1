##########################################################
#
#     Uninstall Wrapper: [App Name]
#     Author: Jack O'Connor - C5 Alliance
#     Modified By: [Your Name]
#     Date Packaged: [Date]
#     Usage: Powershell.exe -ExecutionPolicy bypass -File Invoke-SilentUninstall.ps1
#     Description: Silent Uninstall Wrapper Template For MSIs
#
##########################################################

## Variables To Edit
$appName = "[App Name]" # The name of the app
$productKey = "" # The product key of the corresponding MSI
$DeskShortcuts = "" # An array of shortcuts to remove from the Desktop (if any) E.G. "Shortcut1", "Shortcut2" (without the .lnk)
$StartShortcuts = "" # An array of shortcuts to remove from the Start Menu (if any), without the .lnk

############################################################
#
#   No need to edit beyond this point unless multiple MSIs
#
############################################################

# Get the current working directory
$WorkingDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

# Create the MSI uninstall arguments with logging
$MSIArgs = "/qn /norestart /l*v `"$($ENV:windir)\Temp\$($appName.Replace(" ", `"`"))_Uninst.log`""
$FullArgs = "/x `"" + $productKey + "`" $($MSIArgs)"

# Run the msiexec process and uninstall the given MSI file
Start-Process "msiexec.exe" -ArgumentList $FullArgs -Wait -NoNewWindow

# Delete any given desktop shortcuts that the uninstall does not remove
foreach ($shortcut in $DeskShortcuts) {
    Remove-Item -Path "$($ENV:PUBLIC)\Desktop\$shortcut.lnk" -ErrorAction SilentlyContinue
}

# Delete any given start menu shortcuts that the uninstall does not remove
foreach ($shortcut in $StartShortcuts) {
    Remove-Item -Path "$($env:ProgramData)\Microsoft\Windows\Start Menu\Programs\$shortcut.lnk" -Force -ErrorAction SilentlyContinue
}

############################################################
#
#     All Custom Post-Uninstall Code Below This Point
#
############################################################



## END