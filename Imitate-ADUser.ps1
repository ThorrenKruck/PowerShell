### Imitate-ADUser.ps1
### Powered by Krucktech
### V1.0 - 10.11.2023
###
### Requirements:
### Run as domain admin
###
### Asks for a source user and a target user. Removes all group memberships of the target user, replaces them with those of the source user and moves the target user to the OU of the source user.

Write-Host "USE WITH CAUTION! This will replace all groups the target user is a member of and move the target user to the OU of the source user!" -ForegroundColor Yellow

# Get source user
$confirm = "n"
do
{
    $sourceName = Read-Host -Prompt "User to imitate"
    try
    {
        $sourceUser = Get-ADUser $sourceName -Properties canonicalname,memberof
        Write-Host "Imitating user $($sourceUser.canonicalName) "
        $confirm = Read-Host -Prompt "Confirm (Y/n)"
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
    {
        Write-Host "User not found" -ForegroundColor Red
    }
}
until ($confirm -eq "y" -or $confirm -eq "Y" -or $confirm -eq "")

# Get target user
$confirm = "n"
do
{
    $targetName = Read-Host -Prompt "Target user"
    try
    {
        $targetUser = Get-ADUser $targetName -Properties canonicalname,memberof
        Write-Host "Target user $($targetUser.canonicalName) "
        $confirm = Read-Host -Prompt "Confirm (Y/n)"
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
    {
        Write-Host "User not found" -ForegroundColor Red
    }
}
until ($confirm -eq "y" -or $confirm -eq "Y" -or $confirm -eq "")

# Remove target user from all groups
Remove-ADPrincipalGroupMembership $targetUser -MemberOf $targetUser.MemberOf -Confirm:$false

# Add target user to all groups the source user is a member of
$groups = $sourceUser.memberof
foreach ($group in $groups)
{
    Add-ADGroupMember $group -Members $targetUser
}

# Move target user to source user's OU
$ou = ($sourceUser | Select @{n='OU';e={$_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)'}}).ou
Move-ADObject $targetUser -TargetPath $ou