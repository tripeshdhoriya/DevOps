#SigmaStream-Support Troubleshooting Package Script
$DRIVE="C:" #app installation drivename
$SERVICE_NAME = "YellowHammer-Server" #service name.
$APPDIR="$DRIVE\SigmaStream\YellowHammer\YellowHammer-Server\YellowHammer-Server\yellowhammer\yellowhammer-base" #app directory.
$APP_LOG_DIR = "$APPDIR\logs\" #app log directory.
$APP_GC_LOG_DIR = "$DRIVE\SigmaStream\YellowHammer\YellowHammer-Server\YellowHammer-Server\yellowhammer\logs\" #Application gc log directory.
$threaddump_file="$APP_LOG_DIR\$(hostname)-$SERVICE_NAME-Threaddump-$(get-date -format 'yyyyMMdd-HHmmss').dmp"
$heapdump_file="$APP_LOG_DIR\$(hostname)-$SERVICE_NAME-heapdump-$(get-date -format 'yyyyMMdd-HHmmss').hprof"
$Tools_Directory = "$DRIVE\SigmaStream\Tools" #Tools directory for bundle extract.
$SUPPORT_BUNDLE_PATH = "$Tools_Directory\Troubleshooting\$SERVICE_NAME\"
$ZIPSOURCEPATH = "C:\Program Files\7-Zip\" #7zip path which has 7z.exe file.
$curdir=(Get-Location).Path #current directory to get back once execution is completed.
$SUPPORT_FILENAME="$(hostname)-$SERVICE_NAME-$(get-date -format 'yyyyMMdd-HHmmss').zip" #output file name

function validateinput () {
    if (-not (Get-Service -Name $SERVICE_NAME)) {
        Write-Warning "[!] Invalid service name ($SERVICE_NAME), Exiting"
        exit
    }
    #validate inputpath
    if ( -not (Test-Path "$APP_LOG_DIR") ) {
        Write-Warning "[!] Can not verify the application path ($APP_LOG_DIR), Exiting"
        exit
    }
    # Test-Path $Tools_Directory
    if ( -not (Test-Path "$Tools_Directory")) {
        Write-Warning "[!] Can not verify the tools on path ($Tools_Directory), Creating it $(Tools_Directory)"
        mkdir $Tools_Directory > $nul
        exit
    }
    if ( -not (Test-Path "$ZIPSOURCEPATH") ) {
        Write-Warning "[!] Unable to verify zip utility at ($ZIPSOURCEPATH\7z.exe) 7Zip utility must be installed to use this script, Exiting. Download 7-Zip from
        https://www.7-zip.org/a/7z1900-x64.exe"
        exit
    }
    else {
        $env:Path += ";$ZIPSOURCEPATH"
    }
    #validate and create troubleshooting directory if not exist
    if ( -not (Test-Path "$SUPPORT_BUNDLE_PATH") ) {
        Write-Warning `t"[#] Troubleshooting bundle path not found, creating it ($SUPPORT_BUNDLE_PATH)"
        mkdir $SUPPORT_BUNDLE_PATH > $null
    }
}

function verifyprocess () {
    if (((Get-Service -Name "$Service_Name").Status) -eq "Running" ) {
        Write-Output "[+] Service is running, Preparing to take dump of running process."
        $process=(netstat -aon | findstr "0.0.0.0:8443").split("    ") | Select-Object -Last 1
        #thead-dump
        Write-Output "[+] Taking Thread-dump"
        jstack -l $process > $threaddump_file
        #heapdump
        Write-Output "[+] Taking Heap-dump, this may take some time."
        jmap -dump:format=b,file=$heapdump_file $process
    }
    else {
        Write-Output "[#] Service is stopped, Unable to take heapdump/threaddump."
    }
}

function gatherbuildfiles() {
    Write-Output "[+] Collecting log files, It may take upto 2 minutes!"
    $env:Path += ";$ZIPSOURCEPATH"
    7z.exe *> $null
    if ($?) {
        Set-Location $APPDIR
        7z.exe -mx1 a -tzip $APP_LOG_DIR\gclogs.zip $APP_GC_LOG_DIR -y
        7z.exe -mx1 a -tzip $SUPPORT_BUNDLE_PATH\$SUPPORT_FILENAME $APP_LOG_DIR -y *> "$SUPPORT_BUNDLE_PATH\compress.log"
        Remove-Item $APP_LOG_DIR\*.hprof,$APP_LOG_DIR\*.dmp,$APP_LOG_DIR\gclogs.zip *> $null
        # if ($?) {
        Write-Output "`t [#] Done"
        Write-Output "[#] Application Support Bundle is available at $SUPPORT_BUNDLE_PATH\$SUPPORT_FILENAME"
        Set-Location $curdir
        # }
        # else {
            # Write-Warning "[!] Something went wrong while compressing log files."
        # }
    }
    else {
        Write-Warning "[!] Unble to use 7z.exe for compress, please verify 7z is available in environment path."
    }
}

validateinput
verifyprocess
gatherbuildfiles
# Write-Host "$SERVICE_NAME $APP_GC_LOG_DIR $APP_LOG_DIR $Tools_Directory $SUPPORT_BUNDLE_PATH"