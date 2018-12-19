write-host "Starting Planned Failback and Commit"
#Load Veeam Backup & Replication Powershell SnapIn
if ((Get-PSSnapin "VeeamPSSnapIn" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "VeeamPSSnapIn"
}
Connect-VBRServer -Server "localhost" -User "Username" -Password "password"

#Find the newest restorepoint of a VM from a replication job where the type is Snapshot (replication point)
$restore_point = Get-VBRRestorePoint -Name "WebServer01" | where Type -Match "Snapshot" | Sort-Object $_.creationtime -Descending | Select -First 1
#Failback the VM to production point
Start-VBRViReplicaFailback -RestorePoint $restore_point -PowerOn -QuickRollback 
#Commit Failbackup
Start-VBRViReplicaFailback -RestorePoint $restore_point -Complete

Write-Host "END"
Disconnect-VBRServer