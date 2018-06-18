#########################################################################
#
#  Author: Jack O'Connor
#  Website: https://github.com/JackOconnor21
#  Modified By: Your name here...
#  Description: Simple script to use on a local machine or via SCCMs
#     'run script' feature to find the client version of a machine
#     in the event SCCM has not yet updated the machine records.
#  
#  Edit the $CurrClientVer variable to reflect the latest client version
#  which is what we will test against.
#
#########################################################################

$CurrClientVer = "5.00.8577.1115"
$MyClientVer = (Get-WMIObject -Namespace root\ccm -Class SMS_Client).ClientVersion

If ($MyClientVer -eq $CurrClientVer) {
    Write-Host "Up to date" -ForegroundColor Green
} Else {
    Write-Host "Out of date ($MyClientVer)" -ForegroundColor Red
}