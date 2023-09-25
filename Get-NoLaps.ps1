### get-nolaps
### Powered by Krucktech
### V1.1 - 25.09.2023
###
### Get all enabled computer objects with compatible OS from AD that have contacted the AD in a specified amount of days and do not have an encrypted LAPS password set.

# set timespan in days in which the systems need to have contacted AD
$timespan = 180

$date = (date).AddDays(-$timespan)
$nolaps = Get-ADComputer -Filter {Enabled -eq "True" -and lastlogon -ge $date -and (OperatingSystem -like "Windows Server 2019*" -or OperatingSystem -like "Windows Server 2022*" -or OperatingSystem -like "Windows 1*")} -Properties mslaps-encryptedpassword,lastlogon,operatingsystem | where {$_.'mslaps-encryptedpassword' -eq $null} | select name,operatingsystem,mslaps-encryptedpassword | sort operatingsystem,name
Write-Host "Systems without LAPS: $($nolaps.count)"
$nolaps
