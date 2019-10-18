<#
.SYNOPSIS
    .
.DESCRIPTION
    Rename files
.PARAMETER pathToFolder
    Folderpath in full or relative
.PARAMETER charToReplace
    The character that needs to be replaced
.PARAMETER charToReplaceWith
    The character that is inserted instead of the charToReplace
.NOTES
    Author: Philipp Kahr
    Date:   18.10.2019
    Version: 1.0   
#>
# example: /home/benjaminbourgeois/Desktop/emil/es_13C15N_TAD2_FHsPRE/spre_fit_15Nhsqc/spectraldata
# 
[CmdletBinding()]
param (
  [Parameter(Mandatory = $true)] [string] $pathToFolder,
  [Parameter(Mandatory = $true)] [string] $charToReplace,
  [Parameter(Mandatory = $true)] [string] $charToReplaceWith
)

$childItems = Get-ChildItem -Path $pathToFolder -File
foreach($item in $childItems){
    $newName = $item.Name.Replace($charToReplace, $charToReplaceWith)
    Rename-Item -Path $item.FullName -NewName $newName
}


