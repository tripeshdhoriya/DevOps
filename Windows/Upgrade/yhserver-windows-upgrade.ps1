#7z is pre-requisite for this installation.
$Service_Name = "YellowHammer-Server" #service name.
$curdir = (Get-Location).Path #current directory to get back once execution is completed.
$APP_PARENT_DIR = "C:\SigmaStream\YellowHammer" #Application parent directory.
$APPDIR = "$APP_PARENT_DIR\YellowHammer-Server\YellowHammer-Server\" #App installation path.
$App_Bundle_Name = "YellowHammer-Server" #folder name where app is installed.
$UPGRADE_BUNDLE_PATH = "$curdir\yellowhammer-server-upgrade.zip" #Upgrade zip filepath.
$Tools_Directory = "C:\SigmaStream\Tools\" #Tools directory for bundle extract.
$ZIPSOURCEPATH = "C:\Program Files\7-Zip\" #7zip path which has 7z.exe file.
$Backup_Directory = "$Tools_Directory\Backup\$Service_Name" #Path to store backup file.
$Backup_File_Name = "YellowHammer-Server_15548.zip" #backup file name
$Old_Backup_Name = "$Backup_Directory\YellowHammer-server_15548.zip" #old backup file name to delete.
$Restore_File_Name = "$Service_Name._old.zip"
$rollbak = $args[0]  #argument to fetch rollback input.
$extract_foldername = "yellowhammer-server"
$yhbasefolder = "$APPDIR\yellowhammer\yellowhammer-base"
$ErrorActionPreference = "Stop"       

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
        # Write-Output "[+] Stopping service $Service_Name"
        Write-Progress -Activity "[+] Stopping service $Service_Name" -Status "Progress:" -PercentComplete 15
        Stop-Service "$Service_Name"
    }
    else {
        Write-Output "[#] $Service_Name is already stopped."
    }
}
function startservice () {
    if (((Get-Service -Name "$Service_Name").Status) -eq "Stopped" ) {
        Write-Progress -Activity "[+] Starting service $Service_Name" -Status "Progress:" -PercentComplete 100
        # Write-Output "[+] Starting service $Service_Name"
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
        # Write-Output ""
        Write-Progress -Activity "[+] Taking backup, It may take upto 5 minutes!" -Status "Progress:" -PercentComplete 10
        $env:Path += ";$ZIPSOURCEPATH"
        7z.exe *> $null
        if ($?) {
            Set-Location $APP_PARENT_DIR
            7z.exe a -tzip $Backup_Directory\$Backup_File_Name -ax!\logs\* $App_Bundle_Name -y *> "$Backup_Directory\$Service_Name._bakup.log"
            if ($?) {
                # Write-Output ""
                Write-Progress -Activity "`t [#] Done" -Status "Progress:" -PercentComplete 30
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
        Write-Progress -Activity "`t [#] Done" -Status "Progress:" -PercentComplete 30
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
    validateinputs
    Write-Progress -Activity "[+] Validating environment, before upgrade." -Status "Progress:" -PercentComplete 0
    7z.exe > $null #Fail safe if 7z.exe not found.
    if ($?) {
        Write-Progress -Activity "`t [#] Validation completed." -Status "Progress:" -PercentComplete 5
        # Write-Output ""
        #Check service.
        stopservice
        #Take backup
        #takebackup
        #extract the zip file
        Set-Location $Tools_Directory
        Write-Progress -Activity "[#] Extracting bundle file." -Status "Progress:" -PercentComplete 40
        7z.exe x $UPGRADE_BUNDLE_PATH -y > $null
        if ($?) {
            Set-Location $Tools_Directory\$extract_foldername
            if ($?) {
                Write-Progress -Activity "[#] Upgrading the $Service_Name." -Status "Progress:" -PercentComplete 55
                # Write-Output "[+] Upgrading the $Service_Name"
                # edit config changes
                #Set-Location $UPGRADE_BUNDLE_PATH\$extract_foldername 
                $configchange = Get-Content .\config-ext.properties
                #add-content $yhbasefolder\config-ext.properties -value `n"##"
                add-content $yhbasefolder\config-ext.properties -value $configchange
                #add-content $yhbasefolder\config-ext.properties -value `n"##"
                
                # rename old ROOT.war to ROOT-war
                $build = Get-Content $yhbasefolder\webapps\ROOT\WEB-INF\build.version
                Set-Location $yhbasefolder\webapps\
                Move-Item -Force ROOT.war ROOT-$build

                # replace new ROOT.war
                Set-Location $Tools_Directory\$extract_foldername
                Copy-Item ROOT.war $yhbasefolder\webapps\

                # Touch ROOT.war
                #$nul >> 
				(gci $yhbasefolder\webapps\ROOT.war).LastWriteTime = Get-Date

                # move old logs to old dir
                Write-Output "`t [#] moving old logs."
                Move-Item -Force $yhbasefolder\logs\*.log* $yhbasefolder\logs\old\
                Set-Location $curdir
                ##
                Write-Progress -Activity "[#] Upgrade Completed." -Status "Progress:" -PercentComplete 85
                #Start the service
                startservice
                #Start the service.
				Remove-Item -r $Tools_Directory\$extract_foldername
				
            }
            else {
                Write-Warning "[!] Failed to cd into $Tools_Directory\yellowhammer-server"
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