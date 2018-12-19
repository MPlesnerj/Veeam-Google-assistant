write-host "Starting Planned failover job"
#Load Veeam Backup & Replication Powershell SnapIn
if ((Get-PSSnapin "VeeamPSSnapIn" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "VeeamPSSnapIn"
}
Connect-VBRServer -Server "localhost" -User "Username" -Password "password"

#Find the replication job
$Replica = Get-VBRReplica -Name "Replicate Webservers"

#Find the last restore point of the VM from the replication points
$DC_replica_restorepoint = Get-VBRRestorePoint -Backup $Replica -Name "WebServer01" | Sort-Object $_.creationtime -Descending | Select -First 1
Start-VBRViReplicaFailover -RestorePoint $DC_replica_restorepoint -Reason "Tsunami forecast" -Planned

Write-Host "END"
Disconnect-VBRServer