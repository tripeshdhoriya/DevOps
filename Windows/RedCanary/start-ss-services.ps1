$ErrorActionPreference="SilentlyContinue"
Start-Sleep 5
Start-Service -Name YellowHammer-Server
Start-Service -Name YellowHammer-Client
Start-Service -Name BlueCardinal-Server
Start-Service -Name BlueCardinal-Client
Start-Service -Name KingFisher
Start-Service -Name RockPigeon
Start-Service -Name HummingBird
Start-Service -Name RCAGENT
Start-Service -Name RCSERVER
Start-Service -Name MongoDB
Start-Service -Name Cassandra
Start-Service -Name postgresql-x64-9.6
Write-Output "[#] $(Get-Date) Starting UPS services, UPS shutdown cancle event." >> C:\SigmaStream\Tool\UPS-CancleShutdown.log