### get-nolaps
### Powered by Krucktech
### V1.0 - 21.09.2023
###
### Get all enabled computer objects from AD that have contacted the AD in a specified amount of days and do not have an encrypted LAPS password set.

# set number of days that have to have passed since the last time the systems contacted AD
$timespan = 180

$date = (date).AddDays(-$timespan)
$nolaps=Get-ADComputer -Filter {enabled -eq "True" -and lastlogon -ge $date} -Properties mslaps-encryptedpassword,lastlogon | select name,mslaps-encryptedpassword | sort name | where {$_.'mslaps-encryptedpassword' -eq $null}
$nolaps
Write-Host "Systems without LAPS: $($nolaps.count)"
