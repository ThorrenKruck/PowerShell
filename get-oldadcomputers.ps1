### get-oldadcomputers.ps1
### Powered by Krucktech
### V1.0 - 21.09.2023
### 
### Get all AD computer objects that have not contacted AD in a specified amount of days.

# set number of days that have to have passed since the last time the systems contacted AD
$timeframe = 180

$date = (date).AddDays(-$timeframe)
$oldsystems=Get-ADComputer -Filter {lastlogontimestamp -le $date -and Enabled -eq "True"} -properties lastlogontimestamp,enabled | select name,lastlogontimestamp,enabled | sort lastlogontimestamp
$output = foreach ($system in $oldsystems)
{
    $object = New-Object -TypeName psobject
    $object | Add-Member -MemberType NoteProperty -name "name" -Value $system.name
    $object | Add-Member -MemberType NoteProperty -Name "lastlogontimestamp" -Value ([datetime]::FromFileTime($system.lastlogontimestamp))
    $object | Add-Member -MemberType NoteProperty -Name "enabled" -Value $system.enabled
    $object
}
Write-Host "Systems that did not contact AD in the last $timeframe days: $($oldsystems.count)"
$output | ft -a
