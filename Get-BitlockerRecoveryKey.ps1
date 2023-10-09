### Get-BitlockerRecoveryKey.ps1
### Powered by Krucktech
### V1.0 - 09.10.2023
###
### Requirements:
### Run as admin
###
### Asks for a volume letter and gets the Bitlocker recovery key for that volume.

$driveLetter = Read-Host -Prompt "drive letter"
(Get-BitLockerVolume -MountPoint $driveLetter).keyprotector.recoverypassword
