### IPing.ps1
### Powered by Krucktech
### V1.0 - 21.09.2023
###
### Advanced ping by IP. If the target was initially reachable, wait until ping fails and succeeds again. If the target was initially not reachable, wait until ping succeeds. Intended to be called in a shell with the target as the argument.

param ([string] $target)
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
        Write-Host "still connected to $target #$counterStillConnected at $time" -ForegroundColor Yellow
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
                    Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED again to $target at $time" -ForegroundColor Green
                }
                else
                {
                    Write-Host "COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNECTED initially to $target at $time" -ForegroundColor Green
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
