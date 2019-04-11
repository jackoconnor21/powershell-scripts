######################################################
#
#     Author: Jack O'Connor
#     Description: Backup or restore user data using USMT
#     Call: powershell.exe -ExecutionPolicy Bypass -File Migrate-ScanAndLoad.ps1 -ScanType "Load"
#     Args:
#          - LoadState: Either pass scan or load as this argument to backing up or restoring user data.
#
######################################################

param (
    [string]$StateType = "Scan", # Scan or load
    [string]$MigrationStore, # The path of the migration store
    [stirng]$USMTPath, # The path to your USMT folder
    [string]$LACPassword # Password for local account

)

# Scan and load state params
$ScanStateEXE = "ScanState.exe"
$LoadStateEXE = "LoadState.exe"
$ScanLoadArgs = "$MigrationStore /i:migapp.xml /i:miguser.xml"
$ScanArgs = "$ScanLoadArgs /o"
$LoadArgs = "$ScanLoadArgs /lac:$password /lae"

# Create mapped drive to USMT folder
New-PSDrive -Name "Z" -PSProvider FileSystem -Root $USMTPath
cd Z:

# Depending on the ScanType param we will save or load user state
If ($StateType -eq "Scan") {
    # Start Scan state with arguments
    Start-Process -FilePath "$ScanStateEXE" -ArgumentList $ScanArgs
} ElseIf ($StateType -eq "Load") {
    # Start Load state with arguments
    Start-Process -FilePath "$LoadStateEXE" -ArgumentList $LoadArgs
}