write-host "Starting Veeam restore job"
#Load Veeam Backup & Replication Powershell SnapIn
if ((Get-PSSnapin "VeeamPSSnapIn" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "VeeamPSSnapIn"
}
Connect-VBRServer -Server "localhost" -User "Username" -Password "password"
#Get the last restorepoint
$backup = Get-VBRBackup -Name "VMware Production VMs"
$restorepoint = Get-VBRRestorePoint -Backup $backup -Name "Webserver01" | Select -Last 1
#Restore VM 
Start-VBRRestoreVM -RestorePoint $restorepoint -PowerUp 1 -Reason "Test restore" -ToOriginalLocation -StoragePolicyAction Default -force

Write-Host "END"
Disconnect-VBRServer