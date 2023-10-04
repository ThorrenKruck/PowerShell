### Get-EmptyADGroups.ps1
### Powered by Krucktech
### V1.1 - 04.10.2023
###
### Gets all AD groups without any members.

$count0 = 0
$count1 = 0
$countMany = 0
$countError = 0

Write-Host "fetching groups..."
$allgroups = Get-ADGroup -Filter * | sort name
Write-Host "checking groups for members..."
foreach($group in $allgroups)
{
    $members = $null
    try
    {
        $members = Get-ADGroupMember $group
    }
    catch
    {
        Write-Host "Error with group $($group.Name)" -ForegroundColor Magenta
        $countError++
        continue
    }
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
Write-Host "Total Groups in AD:             $($allGroups.count)"
Write-Host "Groups with 0 members:          $count0" -ForegroundColor Red
Write-Host "Groups with 1 member:           $count1" -ForegroundColor Yellow
Write-Host "Groups with more than 1 member: $countMany" -ForegroundColor Green
Write-Host "Groups with error:              $countError" -ForegroundColor Magenta
