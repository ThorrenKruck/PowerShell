### Get-EmptyADGroups.ps1
### Powered by Krucktech
### V1.0 - 22.09.2023
###
### Gets all AD groups without any members.

$count0 = 0
$count1 = 0
$countMany = 0

Write-Host "fetching groups..."
$allgroups = Get-ADGroup -Filter * | sort name
Write-Host "checking groups for members..."
foreach($group in $allgroups)
{
    $members = Get-ADGroupMember $group
    if($members -eq $null)
    {
        Write-Host "$($group.Name) has no members" -ForegroundColor Red
        $count0++
    }
    else
    {
        if ($members.count -gt 1)
        {
            Write-Host "$($group.Name) has $($members.count) members" -ForegroundColor Green
            $countMany++
        }
        else
        {
            Write-Host "$($group.Name) has 1 member" -ForegroundColor Yellow
            $count1++
        }
    }
}
Write-Host ""
Write-Host "Total Groups in AD:        $($allGroups.count)"
Write-Host "Groups with 0 members:     $count0" -ForegroundColor Red
Write-Host "Groups with 1 member:      $count1" -ForegroundColor Yellow
Write-Host "Groups more than 1 member: $countMany" -ForegroundColor Green
