#####################################################################################
#
#    Author: Jack O'Connor
#    Description: Invoke an evaluation of baselines deployed to selected machines
#    Website: https://github.com/JackOconnor21
#    
#    Using SCCM 1802 'run script' - run this script on a device collection to
#    invoke an evaluation of each baseline on the machines within the collection.
#
#####################################################################################

$ConfigBaselines = Get-WmiObject -ComputerName $env:COMPUTERNAME -Namespace root\ccm\dcm -Class SMS_DesiredConfiguration
$ConfigBaselines | % { ([wmiclass]"\\$env:COMPUTERNAME\root\ccm\dcm:SMS_DesiredConfiguration").TriggerEvaluation($_.Name, $_.Version) }