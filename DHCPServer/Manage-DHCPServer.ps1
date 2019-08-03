<#
.SYNOPSIS
  This script takes the inserted hostname and searches for the dhcp config. It can import and export that config.

.DESCRIPTION
  Export
  1. This script asks for a hostname
  2. It will create a folder structure like "C:/temp/dhcp/hostname/"
  3. It will put the export as an xml inside that folder
  Import
  1. This script asks for a hostname
  2. It will automatically search for a config file in the same directory as the export
  3. It will create a popup asking for confirmation.

.PARAMETER hostname
  Required as it connects to the DHCP server.

.NOTES
  Version:        1.0
  Author:         Philipp Kahr
  Creation Date:  03.08.2019
  Purpose/Change: Search for unknown NS entries
  
.EXAMPLE
  Manage-DHCPServer.ps1
#>

$sScriptVersion = "1.0"

Import-module dhcpserver

$hostname = Read-Host "Enter the host"
$importOrExport = Read-Host "Do you want to import or export, answer with 'import' or 'export'"
$pathForConfigFolder = "C:\temp\dhcp\" + $hostname
$pathForConfigFile = $pathForConfigFolder + "\" + $hostname + "_config.xml"
$pathForBackupFile = $pathForConfigFolder + "\" + $hostname + "_backup.xml"


if($importOrExport.Equals("export")){
    echo "Going to export the configuration from $hostname"

    New-Item -ItemType directory -Path $pathForConfigFolder -Force

    Export-DhcpServer -ComputerName $hostname -Leases -File $pathForConfigFile -Force
}
if($importOrExport.Equals("import")){

    echo "Going to IMPORT the configuration from $hostname"

    Import-DhcpServer -ComputerName $hostname -Leases -File $pathForConfigFile -BackupPath $pathForBackupFile
}
