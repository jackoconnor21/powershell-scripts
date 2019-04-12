######################################################
#
#     Author: Jack O'Connor
#     Description: 
#
######################################################

param (
    [string]$EXEName = "StockViewer.exe" # The executble your SDB is based on
)

$AppCompatReg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags"

Get-Item -Path "$($AppCompatReg)\Custom\$EXEName"

$SDBName = (Get-ItemProperty -Pat "$($AppCompatReg)\Custom\$ExeName" | Select-Object -Property "*.sdb").PsObject.Properties.Name

$SDB = Get-Item -Path ("$($AppCompatReg)\InstalledSDB\$SDBName").Replace(".sdb", "")

($SDB | Get-ItemProperty).DatabasePath
($SDB | Get-ItemProperty).DatabaseType
($SDB | Get-ItemProperty).DatabaseDescription
($SDB | Get-ItemProperty).DatabaseInstallTimeStamp