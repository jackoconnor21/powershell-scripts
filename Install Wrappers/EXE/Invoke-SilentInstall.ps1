#####################################################################################
#
#     Install Wrapper: [App Name]
#     Author: Jack O'Connor - C5 Alliance
#     Modified By: [Your Name]
#     Date Packaged: [Date]
#     Usage: Powershell.exe -ExecutionPolicy bypass -File Invoke-SilentInstall.ps1
#     Description: Silent Install Wrapper Template For Executables
#
#####################################################################################

###### Variables To Edit
$EXE = "" # The name of the executable (without the .exe)
$EXEArgs = "" # Any arguments you need to pass to the Executable
$DeskShortcuts = "" # An array of shortcuts to remove from the Desktop (if any) E.G. "Shortcut1", "Shortcut2" (without the .lnk)
$StartShortcuts = "" # An array of shortcuts to remove from the Start Menu (if any), without the .lnk

############################################################
#
#   No need to edit beyond this point unless multiple EXEs
#
############################################################

# Get the current working directory of the script
$WorkingDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

# Run the EXE File with required arguments
Start-Process "$WorkingDir\$EXE.exe" -ArgumentList $EXEArgs -Wait -NoNewWindow

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
