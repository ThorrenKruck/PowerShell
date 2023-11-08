### HPing.ps1
### Powered by Krucktech
### V1.1 - 09.11.2023
###
### Advanced ping by hostname. If the target was initially reachable, wait until ping fails and succeeds again. If the target was initially not reachable, wait until ping succeeds. Powershell7-proof. Intended to be called in a shell with the target as the argument.

param ([string] $target)
if($target -eq ""){Write-Host "No target specified" -Foregroundcolor Red; exit}
$repeat = $true
$answer = "y"

$noConnection = $true
$counterNoConnection= 1
$counterStillConnected = 1
$initiallyConnected = $false

$running=$true
while ($running)
{
    if(Test-Connection -ComputerName $target -Count 1 -Quiet)
    {
        $ping = Test-Connection -ComputerName $target -Count 1
        $time = (Get-Date | Select-Object TimeOfDay).TimeofDay
        if($PSVersionTable.PSVersion.Major -eq 7)
        {
            Write-Host "still connected to $target with ip $($ping.Address.IPAddressToString) #$counterStillConnected at $time" -ForegroundColor Yellow
        }
        else
        {
            Write-Host "still connected to $target with ip $($ping.IPV4Address.IPAddressToString) #$counterStillConnected at $time" -ForegroundColor Yellow
        }        
        $counterStillConnected += 1
        $initiallyConnected = $true
        Start-Sleep -Seconds 1
    } 
    else 
    {
        while ($noConnection)
        {
            if(Test-Connection -ComputerName $target -Count 1 -Quiet)
            {
                $ping = Test-Connection -ComputerName $target -Count 1
                $time = (Get-Date | Select-Object TimeOfDay).TimeofDay
                if ($initiallyConnected = $true)
                {
                    if($PSVersionTable.PSVersion.Major -eq 7)
                    {
                        Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED again to $target with ip $($ping.Address.IPAddressToString) at $time" -ForegroundColor Green
                    }
                    else
                    {
                        Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED again to $target with ip $($ping.IPV4Address.IPAddressToString) at $time" -ForegroundColor Green
                    }  
                }
                else
                {
                    if($PSVersionTable.PSVersion.Major -eq 7)
                    {
                        Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED initially to $target with ip $($ping.Address.IPAddressToString) at $time" -ForegroundColor Green
                    }
                    else
                    {
                        Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED initially to $target with ip $($ping.IPV4Address.IPAddressToString) at $time" -ForegroundColor Green
                    }  
                }
                $noConnection = $false
                $running = $false
            } 
            else 
            {
                $time = (Get-Date | Select-Object TimeOfDay).TimeofDay
                Write-Host "no connection to $target #$counterNoConnection at $time" -ForegroundColor Red
                $counterNoConnection+= 1
                Start-Sleep -Seconds 1
            }
        }
    }
}
