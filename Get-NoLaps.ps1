### get-nolaps
### Powered by Krucktech
### V1.2 - 10.10.2023
###
### Get all enabled computer objects with compatible OS from AD that do not have an encrypted LAPS password set.

$nolaps = Get-ADComputer -Filter {Enabled -eq "True" -and (OperatingSystem -like "Windows Server 2019*" -or OperatingSystem -like "Windows Server 2022*" -or OperatingSystem -like "Windows 1*")} -Properties mslaps-encryptedpassword,operatingsystem,lastlogondate | where {$_.'mslaps-encryptedpassword' -eq $null} | select name,operatingsystem,lastlogondate,mslaps-encryptedpassword | sort operatingsystem,name
Write-Host "Systems without LAPS: $($nolaps.count)"
$nolaps | ft -a
