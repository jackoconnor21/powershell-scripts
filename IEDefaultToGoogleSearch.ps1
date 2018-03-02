################################################################################################################################
#
#   NAME: IE Default To Google Search
#
#   DESCRIPTION: Sets Internet Explorer's default search provider to Google, with enabled search suggestions.
#                Once script completes, re-launch IE and accept the prompt asking to change IE default to Google.
#
#   AUTHOR: Jack O'Connor - https://github.com/jackoconnor21
#
################################################################################################################################

# Push our current location so we can revert back after the script
Push-Location

# Create a new GUID as a string and convert to uppercase
$guid = "{" + [guid]::NewGuid().toString().ToUpper() + "}"

# Work out of the HKEY CURRENT USER key
Set-Location HKCU:

# Define the search scopes reg key
$searchPath = ".\Software\Microsoft\Internet Explorer\SearchScopes"

# Create a new reg key under 'SearchScopes' with our new GUID
New-Item -Path $searchPath -Name $guid

$keyName = $searchPath + "\" + $guid

# Set the reg entries for Google Search
New-ItemProperty -Path $keyName -Name "DisplayName" -PropertyType String -Value "Google"
New-ItemProperty -Path $keyName -Name "FaviconURL" -PropertyType String -Value "https://www.google.com/favicon.ico"
New-ItemProperty -Path $keyName -Name "SuggestionsURL" -PropertyType String -Value "https://clients5.google.com/complete/search?q={searchTerms}&client=ie8&mw={ie:maxWidth}&sh={ie:sectionHeight}&rh={ie:rowHeight}&inputencoding={inputEncoding}&outputencoding={outputEncoding}"
New-ItemProperty -Path $keyName -Name "URL" -PropertyType String -Value "https://www.google.com/search?q={searchTerms}"
New-ItemProperty -Path $keyName -Name "ShowSearchSuggestions" -PropertyType DWord -Value 1

# Set the default scope of SearchScopes to our newly created Google search
New-ItemProperty -Path $searchPath -Name "DefaultScope" -PropertyType String -Value $guid -Force

# Return to our initial PS location
Pop-Location