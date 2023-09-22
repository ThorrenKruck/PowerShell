### Get-LastLogonTimestampUser.ps1
### Powered by Krucktech
### V1.0 - 22.09.2023
###
### Gets the last time a user has logged on to AD. !! The value is only replicated every 9 to 14 days by default and thus may not be accurate to the day !!

while($true)
{
    $user = Read-Host -Prompt "Username"
    Get-ADUser -Identity $user -Properties "LastLogonDate" | select "LastLogonDate"
    Write-Host "------------------------------"
}
