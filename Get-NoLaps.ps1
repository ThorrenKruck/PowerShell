### Get-NoLaps.ps1
### Powered by Krucktech
### V1.0 - 21.09.2023
###
### Get all enabled computer objects from AD that have contacted the AD in a specified amount of days and do not have an encrypted LAPS password set.

# set timespan in days in which the systems need to have contacted AD
$timespan = 180

$date = (date).AddDays(-$timespan)
$nolaps=Get-ADComputer -Filter {enabled -eq "True" -and lastlogon -ge $date} -Properties mslaps-encryptedpassword,lastlogon | select name,mslaps-encryptedpassword | sort name | where {$_.'mslaps-encryptedpassword' -eq $null}
$nolaps
Write-Host "Systems without LAPS: $($nolaps.count)"
