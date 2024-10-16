$ErrorActionPreference = 'silentlycontinue'
$host.ui.RawUI.WindowTitle = “Checking HMI Status”
for ($i = 0; $i -lt 11 ; $i++) {
    Invoke-WebRequest -URI http://localhost/visualizer/ -UseBasicParsing > $null
    if ($?) {
		Write-Output "[#] HMI is available"
		start-process "cmd.exe" "/c .\kiosk.bat"
        exit
    }
    else {
        Write-Output "Waiting for HMI(Timeout=10): $i"
        Start-Sleep 5
    }
}