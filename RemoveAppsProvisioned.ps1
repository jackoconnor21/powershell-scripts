# A pre-defined list of all application package names to remove
$appXPackages = @('3DBuilder', 'BingFinance', 'BingSports', 'CommsPhone', 'ConnectivityStore', 'Getstarted', 'Messaging', 'MicrosoftOfficeHub',`
                    'Sway', 'People', 'windowscommunicationsapps', 'WindowsStore', 'Xbox', 'ZuneMusic', 'ZuneVideo', 'MicrosoftSolitaireCollection',` 
                    'SkypeApp', 'Maps', 'Phone') 

foreach ($i in $appXPackages) {
    # Remove the provisioned package if it exists to stop the app being deployed to the OS on profile creation
    Get-AppxProvisionedPackage -online | Where-Object -Property PackageName -Like -Value ("*"+$i+"*") | Remove-AppxProvisionedPackage -Online
    
    # If the package already exists in the current profile then remove it from the OS
    if (Get-AppxPackage -online | Where-Object -Property PackageName -Like -Value ("*"+$i+"*")) {
         Get-AppxPackage -online | Where-Object -Property PackageName -Like -Value ("*"+$i+"*") | Remove-AppXPackage -Online
    }
}