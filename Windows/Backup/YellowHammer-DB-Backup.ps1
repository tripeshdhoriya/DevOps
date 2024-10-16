##### Job configuration #####

$DBhost = "localhost"
$port = "5432"
# Username used for backup task
$username = "sigmastream"
$role = "sigmastream"
# Parameters for backup job
$format = "t" # t for TAR file
$DBnamesarray = @('yellowhammer')
$basedir="C:\\SigmaStream\\Tools\\Backup\\YellowHammer\\PostgreSQL\\"
$dumpFilePath = "$basedir\\dump\\"
$log_directory="$basedir\\logs\\"
$date = get-date -format yyyy-MM-dd-HH-mm
$days_to_keep_backup="-4"

##### Create file to store password into profile of account that will execute the manual tasks/scheduled tasks
# Path for password file
$AccountFile = "$basedir\Account.$username.pwd"

# Check for password file
if ((Test-Path $AccountFile) -eq "True") {
    Write-Host "[#] The file $AccountFile exist. Skipping credential request"
}
else {
    Write-Host ("[+] The value $AccountFile not found," +
        " creating credentials file.")
    # Create credential object by prompting user for data. Only the password is used. For user name use $username.
    # As per post https://stackoverflow.com/questions/13992772/how-do-i-avoid-saving-usernames-and-passwords-in-powershell-scripts
    $Credential = Get-Credential
    # Encrypt the password to disk
    $Credential.Password | ConvertFrom-SecureString | Out-File $AccountFile
}

##### Read password for DBhost login #####
# Read password from file
$SecureString = Get-Content $AccountFile | ConvertTo-SecureString

# Create credential object programmatically
$NewCred = New-Object System.Management.Automation.PSCredential("Account", $SecureString)

# Variable for postgres password in clear text
$env:PGPASSWORD = $NewCred.GetNetworkCredential().Password


##### Run backup - Don't edit below this line #####
Write-Host "[+] Verifying pg_dump.exe"
$ErrorActionPreference='silentlycontinue'
pg_dump.exe --version > $null
if ($?) {
    foreach ($DB in $DBnamesarray) {
        # $wrapFileName = $dumpFilePath + $date+($DB - ".tar")
        $wrapFileName = $dumpFilePath+$date+"-"+($DB+".tar")
        Write-Host "Wrapfilename:: $wrapFileName"
        Start-Transcript $log_directory\$date-$DB".log"
        Write-Host "[#] Running job for $DB"
        pg_dump.exe --file "$wrapFileName" --host $DBhost --port $port --username $username --verbose --role $role --format=$format --blobs $DB
        Stop-Transcript
    } 
    #remove files older than given days
    Get-ChildItem $dumpFilePath -Recurse -Force -ea 0 |
    Where-Object { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays($days_to_keep_backup) } |
    ForEach-Object {
        $_ | Remove-Item -Force
        $_.FullName | Out-File $log_directory -Append
    }
	Get-ChildItem $log_directory -Recurse -Force -ea 0 |
    Where-Object { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays($days_to_keep_backup) } |
    ForEach-Object {
        $_ | Remove-Item -Force
        $_.FullName | Out-File $log_directory -Append
    }
}
else {
    Write-Warning "[!] Unable to access pg_dump.exe, please add PostgreSQL in ENV path, EXITING."
    exit 1
}

# compress(){
# Write-Host "Compressing dump file"
# 7z.exe *> $null
# if ($?) {
#     Set-Location $APP_PARENT_DIR
#     7z.exe a -tzip $dumpFilePath\$date+($DB-".zip") $wrapFileName -y *> "$log_directory\compress.log"
#     if ($?) {
#         Write-Output "`t [#] Done"
#         Set-Location $curdir
#     }
#     else {
#         Write-Warning "[!] Something went wrong while taking the backup."
#     }
# }
# else {
#     Write-Warning "[!] Unble to use 7z.exe for backup, please verify 7z is available in environment path."
# }
# }