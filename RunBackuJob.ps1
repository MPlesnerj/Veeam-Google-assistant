write-host "Starting Veeam Backup job"
#Load Veeam Backup & Replication Powershell SnapIn
if ((Get-PSSnapin "VeeamPSSnapIn" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "VeeamPSSnapIn"
}
Connect-VBRServer -Server "localhost" -User "Username" -Password "password"
#Start backup job
$BackupJob = Get-VBRJob -Name "VMware Production VMs"
Start-VBRJob -Job $BackupJob

Write-Host "END"
Disconnect-VBRServer