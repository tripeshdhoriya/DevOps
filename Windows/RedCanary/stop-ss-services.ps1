$ErrorActionPreference="SilentlyContinue"
Start-Sleep 5
Stop-Service -Name YellowHammer-Server
Stop-Service -Name YellowHammer-Client
Stop-Service -Name BlueCardinal-Server
Stop-Service -Name BlueCardinal-Client
Stop-Service -Name KingFisher
Stop-Service -Name RockPigeon
Stop-Service -Name HummingBird
Stop-Service -Name RCAGENT
Stop-Service -Name RCSERVER
Stop-Service -Name MongoDB
Stop-Service -Name Cassandra
Stop-Service -Name postgresql-x64-9.6
Write-Output "[!] $(Get-Date) Stopping SigmaStream Services due to low UPS battery level. " >> C:\SigmaStream\Tool\UPS-Shutdown.log