<#
.SYNOPSIS
  This scripts searches for entries that are from the "NS" type. This is needed to verify that the domain soa record
  does not contain any unknown entries.

.DESCRIPTION
  1. This script asks for an input e.g. "domain.local"
  2. Then it searches for any "NS" type record
  3. Foreach found NS record it verifies if the IPAddress contains an "unkown" entry.
  4. Output the 

.PARAMETER domainName
  Required as it searches for the domain SOA record.

.NOTES
  Version:        1.0
  Author:         Philipp Kahr
  Creation Date:  03.08.2019
  Purpose/Change: Search for unknown NS entries
  
.EXAMPLE
  Resolve-UnknownNSEntries.ps1
#>

$sScriptVersion = "1.0"

$domainName = Read-Host "Insert the domain name"

function Report-Errors(){
    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        $domainName
    )
    try{ 
        [int] $errorsFound=0
        $dnsRecord = Get-DnsServerResourceRecord -RRType NS -ZoneName $domainName 
        foreach($dnsEntry in $dnsRecord.RecordData){
            $temp = Resolve-DnsName -Name $dnsEntry.NameServer -Server 127.0.0.1 -ErrorAction SilentlyContinue -ErrorVariable domainError
            if($domainError){
                $outputString = "Error found with: " + $dnsEntry.NameServer
                echo $outputString
                $errorsFound = 1
            }
        }
        if($errorsFound -eq 0){
          echo "Could not find any unknown entries"
        }
    }catch{
      $ErrorMessage = $_.Exception.Message
      $FailedItem = $_.Exception.ItemName
      Write-Output $ErrorMessage
      Write-Output $FailedItem
    }
  }
Report-Errors -domainName $domainName