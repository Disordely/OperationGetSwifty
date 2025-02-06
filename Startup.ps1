## Basic Menu
Clear-Host
write-host "USB Prod/Dev scripts selection"
write-host "------------------------------"
Write-Host "1 - [DEFAULT] Use Prod Script"
Write-Host "2 - Engineering Team only - Dev"
Write-Host "Q - quit and restart"
write-host "Note :  This is where deploy scripts run from and does not affect Windows DEV/UAT/PRD ring" 
while($selection -notin @('1','2','Q'))
    {
    $selection = Read-Host "Enter selection [1,2,Q]"
    }
switch($selection.ToLower())
    {
    1
        {
        $Global:ScriptRootURL = "ProductionURL"
        }
    2
        {
        $Global:ScriptRootURL = "https://raw.githubusercontent.com/Disordely/OperationGetSwifty/refs/heads/main/Main.ps1"
        }
    q
        {
        Write-Host "Restarting"
        start-sleep 5
        wpeutil reboot
        }
    }

Write-Host "Setting URL to [$($ScriptRootURL)]"
Invoke-RestMethod -uri "$($ScriptRootURL)\startup.ps1" | out-file $env:temp\startup.ps1 -force -encoding ascii
& $env:temp\startup.ps1
