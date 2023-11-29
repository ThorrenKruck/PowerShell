### get-nolaps
### Powered by Krucktech
### V1.31 - 13.10.2023
###
### Get all enabled computer objects with compatible OS, except DCs, from AD that do not have an encrypted LAPS password set.

$dcs = (Get-ADDomainController -Filter *).name
$nolaps = Get-ADComputer -Filter {Enabled -eq "True" -and (OperatingSystem -like "Windows Server 2019*" -or OperatingSystem -like "Windows Server 202*" -or OperatingSystem -like "Windows 1*")} -Properties mslaps-encryptedpassword,operatingsystem,lastlogondate | where {$_.'mslaps-encryptedpassword' -eq $null -and $dcs -notcontains $_.Name} | select name,operatingsystem,lastlogondate,mslaps-encryptedpassword | sort operatingsystem,name
Write-Host "Systems without LAPS: $($nolaps.count)"
$nolaps | ft -a
