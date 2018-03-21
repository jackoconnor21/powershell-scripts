##############################################################################
#
#   Author: Jack O'Connor
#   Description: Change your computers current power configuration.
#   Website: https://github.com/jackoconnor21
#
#   SWITCHES: -Power
#   OPTIONS: 'High', 'Balanced', 'Saver'
#   COMPAT: x64, x86
#
##############################################################################

Param(
  [string]$power
)

# Define our power configurations.
$types = @{
    "high" = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    "balanced" = "381b4222-f694-41f0-9685-ff5bb260df2e"
    "saver" = "a1841308-3541-4fab-bc81-f71556f20b4a"
}

# Check whether or not a switch was passed to the script. Without one we can't select a power setting.
if (!$PSBoundParameters.ContainsKey("power")) {
    Write-Host "Please pass the power option you wish to use. E.G. ""Change-PowerConfig.ps1 -Power high"""; EXIT
}

# Ensure the argument passed to our Power switch exists in the array. (so it has a valid associated GUID)
if (!$types.ContainsKey($power)) {
    Write-Host "This power configuration does not exist. Please use 'high', 'balanced' or 'saver'"; EXIT
}

Write-Host "Power plan selected: $power"

# The majority of the time our system will b 64-bit so system32 will be our default folder
$powerDir = "\system32\"

# If Processor architecture is 32-bit however, we will change the folder to SysWOW64
$proc_arch = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x86)’

if ($proc_arch) {
    $powerDir = "\SysWOW64\"
    Write-Host "Setting SysWOW64 (32-bit) as the working directory to run powercfg.exe"
}

# Get the windows directory
$Windir = Get-ChildItem ENV:windir

# Concatenate the command to run the power config executable from the correct location with the correct power type.
$cmd = $Windir.Value + $powerDir + "powercfg.exe /setactive " + $types[$power]

# Execute
iex $cmd

Write-Host "Power configuration successfully set to $power performance" -ForegroundColor green