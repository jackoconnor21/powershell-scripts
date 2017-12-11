#########################################################################################
#
#  Author: Jack O'Connor
#  Description: Remove appx packages from the current system and from future provisioning
#
##########################################################################################

# A pre-defined list of all application package names to remove
$appXPackages = @('3DBuilder', 'BingFinance', 'BingSports', 'CommsPhone', 'ConnectivityStore', 'Getstarted', 'Messaging', 'MicrosoftOfficeHub',`
                    'Sway', 'People', 'windowscommunicationsapps', 'WindowsStore', 'Xbox', 'ZuneMusic', 'ZuneVideo', 'MicrosoftSolitaireCollection',` 
                    'SkypeApp', 'Maps', 'Phone') 

foreach ($i in $appXPackages) {
    # Remove the provisioned package if it exists to stop the app being deployed to the OS on profile creation
    Get-AppxProvisionedPackage -online | Where-Object -Property PackageName -Like -Value "*$($i)*" | Remove-AppxProvisionedPackage -Online
    
    # Remove the desired AppxPackage providing it is not a system app
    Get-AppxPackage | Where-Object {($_.Name -Like "*$($i)*") -and ($_.SignatureKind -ne 'System')} | Remove-AppXPackage
}