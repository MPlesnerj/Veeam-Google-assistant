write-host "Starting Veeam Quick backup job"
#Load Veeam Backup & Replication Powershell SnapIn
if ((Get-PSSnapin "VeeamPSSnapIn" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "VeeamPSSnapIn"
}
Connect-VBRServer -Server "localhost" -User "Username" -Password "password"

#Find the server by name using a array and start a quick backup of that VM.
$vms = Find-VBRViEntity -VMsAndTemplates | Group-Object Name -AsHashTable
Start-VBRQuickBackup -VM $vms.webserver01

Write-Host "END"
Disconnect-VBRServer