### Get-LastLogonTimestampComputer.ps1
### Powered by Krucktech
### V1.0 - 22.09.2023
###
### Gets the last time a computer has logged on to AD. !! The value is only replicated every 9 to 14 days by default and thus may not be accurate to the day !!

while($true)
{
    $computer = Read-Host -Prompt "Computername"
    Get-ADComputer $computer -Properties LastLogonDate | select LastLogonDate
    Write-Host "------------------------------"
}
