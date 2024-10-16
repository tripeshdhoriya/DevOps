#7z is pre-requisite for this installation.
$Service_Name = "YellowHammer-Client" #service name.
$APP_PARENT_DIR = "C:\SigmaStream\YellowHammer" #Application parent directory.
$APPDIR = "$APP_PARENT_DIR\YellowHammer-WebClient\yellowhammer-webclient" #App installation path.
$App_Bundle_Name = "YellowHammer-WebClient" #folder name where app is installed.
$UPGRADE_BUNDLE_PATH = "C:\SigmaStream\yellowhammer-client.zip" #Upgrade zip filepath.
$Tools_Directory = "C:\SigmaStream\Tools\" #Tools directory for bundle extract.
$ZIPSOURCEPATH = "C:\Program Files\7-Zip\" #7zip path which has 7z.exe file.
$Backup_Directory = "$Tools_Directory\Backup\$Service_Name" #Path to store backup file.
$Backup_File_Name = "YellowHammer-Client_110.zip" #backup file name
$Old_Backup_Name = "$Backup_Directory\YellowHammer-Client_109.zip" #old backup file name to delete.
$Restore_File_Name = "$Service_Name._old.zip"
$curdir = (Get-Location).Path #current directory to get back once execution is completed.
$rollbak = $args[0]  #argument to fetch rollback input.

#TODO
#- Fix the excluding log files in backup function. - Pending.
# One option is to remove it from zip file once the backup is taken.

function validateinputs() {
    #validate service name
    # $ErrorActionPreference = 'silentlycontinue'
    # Get-Service -Name $Service_Name 
    if (-not (Get-Service -Name $Service_Name)) {
        Write-Warning "[!] Invalid service name ($Service_Name), Exiting"
        exit
    }
    #validate inputpath
    # Test-Path $APPDIR 
    if ( -not (Test-Path "$APPDIR") ) {
        Write-Warning "[!] Can not verify the application path ($APPDIR), Exiting"
        exit
    }
    # Test-Path $UPGRADE_BUNDLE_PATH
    if ( -not (Test-Path "$UPGRADE_BUNDLE_PATH")) {
        Write-Warning "[!] Can not verify the upgrade bundle on path ($UPGRADE_BUNDLE_PATH), Exiting"
        exit
    }
    #validate zip file path
    # Test-Path "$ZIPSOURCEPATH" 
    if ( -not (Test-Path "$ZIPSOURCEPATH") ) {
        Write-Warning "[!] Unable to verify zip utility at ($ZIPSOURCEPATH\7z.exe) 7Zip utility must be installed to use this script, Exiting. Download 7-Zip from
        https://www.7-zip.org/a/7z1900-x64.exe"
        exit
    }
    else {
        $env:Path += ";$ZIPSOURCEPATH"
    }
    #validate and create backup directory if not exist
    # Test-Path "$Backup_Directory" 
    if ( -not (Test-Path "$Backup_Directory") ) {
        Write-Warning `t"[#] No backup path found, creating it ($Backup_Directory)"    
        mkdir $Backup_Directory > $null
    }
    if ( -not (Test-Path "$Tools_Directory") ) {
        Write-Warning `t"[#] Can not verify Tools directory, creating it ($Tools_Directory)"    
        mkdir $Tools_Directory > $null
    }
}

function stopservice () {
    if (((Get-Service -Name "$Service_Name").Status) -eq "Running" ) {
        Write-Output "[+] Stopping service $Service_Name"
        Stop-Service "$Service_Name"
    }
    else {
        Write-Output "[#] $Service_Name is already stopped."
    }
}
function startservice () {
    if (((Get-Service -Name "$Service_Name").Status) -eq "Stopped" ) {
        Write-Output "[+] Starting service $Service_Name"
        Start-Service "$Service_Name"
    }
    else {
        Write-Output "[#] $Service_Name is already Running!."
    }
}

function takebackup() {
    #supress the output message!
    if (Test-Path $Old_Backup_Name) {
        # Write-Output "`t [#] Removing old backup."
        Remove-Item -Force $Old_Backup_Name
    }
    if (-not (Test-Path $Backup_Directory\$Backup_File_Name)) {
        Write-Output "[+] Taking backup, It may take upto 5 minutes!"
        $env:Path += ";$ZIPSOURCEPATH"
        7z.exe *> $null
        if ($?) {
            Set-Location $APP_PARENT_DIR
            7z.exe a -tzip $Backup_Directory\$Backup_File_Name -ax!\logs\* $App_Bundle_Name -y *> "$Backup_Directory\$Service_Name._bakup.log"
            if ($?) {
                Write-Output "`t [#] Done"
                Set-Location $curdir
            }
            else {
                Write-Warning "[!] Something went wrong while taking the backup."
            }
        }
        else {
            Write-Warning "[!] Unble to use 7z.exe for backup, please verify 7z is available in environment path."
        }
    }
    else {
        Write-Output "`t [#] Backup File already exists"
    }
}
function rollback() {
    Write-Warning "[!] Are you sure, you want to continue? It is adviced to consult SigmaStream Support[support@sigmastream.com] before performing a rollback."
    $confirmation = Read-Host "`[#] Please type 'yes' to continue OR press type anything else to interrupt"
    if ($confirmation -eq 'yes') {
        validateinputs
        stopservice
        Write-Output "`t [+] Rollback initiated."
        #Compressing and deleting existing app directory and name it as $Restore_File_Name
        Set-Location $APP_PARENT_DIR
        7z.exe a -tzip $Backup_Directory\$Restore_File_Name -sdel $App_Bundle_Name > "$Backup_Directory\$Service_Name.pre_restore_compress.log"
        ##
        7z.exe x $Backup_Directory\$Backup_File_Name -y > "$Backup_Directory\$Service_Name.restore.log"
        if ($?) {
            Set-Location $curdir
            Write-Output "[#] Rollback completed."
            startservice
        }
        else {
            Write-Warning "[!] Something went wrong will performing the rollback. Please contact support@sigmastream.com"
        }
    }
    else {
        Write-Host "[#] Rollback aborted."
    }
}

#------------------Action Block-------------------#
if (-not ($rollbak)) {
    Write-Output "[+] Validating environment, before upgrade."
    validateinputs
    7z.exe > $null #Fail safe if 7z.exe not found.
    if ($?) {
        Write-Output "`t [#] Validation completed."
        #Check service.
        stopservice
        #Take backup
        takebackup
        #extract the zip file
        Set-Location $Tools_Directory
        7z.exe x $UPGRADE_BUNDLE_PATH -y > $null
        if ($?) {
            Set-Location $Tools_Directory\yellowhammer-client
            if ($?) {
                Write-Output "[+] Upgrading the $Service_Name"
                #replace jar file.
                Move-Item -Force $APPDIR\yh-webclient.jar $APPDIR\yh-webclient_jar
                Copy-Item yh-webclient.jar $APPDIR\
                #replace webapp folder
                Set-Location $APPDIR
                Remove-Item -r .\webapp\
                7z.exe x $Tools_Directory\yellowhammer-client\webapp.zip > $null
                #Copy i18n changes.
                Set-Location $Tools_Directory\yellowhammer-client
                Copy-Item -r -Force i18n $APPDIR
                #Applynig config changes if Applynig
                # Get-Content config.properties >> $APPDIR\config\config.properties
                Set-Location $curdir
                #Cleanup time
                Write-Output "`t [#] Removing old logs."
                Remove-Item -Force $APPDIR\logs\*.log*
                Start-Sleep 5
                Remove-Item -r $Tools_Directory\yellowhammer-client
                Write-Output "[#] Upgrade completed."
                ##
                #Start the service
                startservice
                #Start the service.
            }
            else {
                Write-Warning "[!] Failed to cd into $Tools_Directory\yellowhammer-client"
            }
        }
        else {
            Write-Warning "[!] Something went wrong while extracting the upgrade bundle file."
        }
    }
    else {
        Write-Warning "[!] Unable to verify the 7zip installation, please make sure, It's installed by running 7z.exe command (Set env variable)."
    }
}
else {
    if ($rollbak -eq "rollback") {
        Write-Output "[!] Initiating the RollBack..."
        rollback
    }
    else {
        Write-Output "[!] Unrecognized option $rollbak."
        $ScriptName = $MyInvocation.MyCommand.Name
        Write-Output "[#] USAGE: pwsh.exe $scriptName to perform the upgrade. Use argument 'rollback' to restore the previous backup. "
    }
}