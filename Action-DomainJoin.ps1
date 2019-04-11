######################################################
#
#     Author: Jack O'Connor
#     Description: Join a computer to a specific domain
#     Call: powershell.exe -ExecutionPolicy Bypass -File Action-DomainJoin.ps1 -DomainName "Somedomain" -UserName "someUser"
#
######################################################

param (
    [Parameter(Mandatory=$True)][String]$DomainName,
    [string]$UserName = "Administrator"
)

Add-Computer -DomainName $DomainName -Credential $DomainName\$UserName -Force -Restart