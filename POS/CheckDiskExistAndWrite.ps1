# (c) DevOpsHQ, 2016
# Author: Aleksey Burov, DevOps

param (
[string] $disk,
[switch] $verbose
)

# Value mapping - add this value mapping to Zabbix web-interface
$DISK_ERROR_IN_SCRIPT = 1000
$DISK_NOT_EXIST = 1001
$DISK_WRITE_FILE_ERROR = 1002
$DISK_CHANGE_FILE_ERROR = 1003
$DISK_DELETE_FILE_ERROR = 1004
$DISK_INCORRECT_PARAMETERS = 1005
$OK_STATUS = 0

$TEMP_FILE_NAME = "Zabbix_CheckDiskExitsAndWrite.tmp"

$returnCode = $OK_STATUS


########### Print arguments and set debug ###########
if ($verbose) {
        $DebugPreference = "Continue"
        Write-Debug "INFO - run script with parameter: "

        foreach ($param in $PsBoundParameters.Keys){
            $param = $param+": " +$PsBoundParameters[$param]
            Write-Debug $param
        }
    }
    else{
        $DebugPreference = "SilentlyContinue"
}

########### Check parameter ###########
if ($disk.Length -ne 1){
    Write-Debug "ERROR - disk=$disk more 1 symbol"
    Write-Host $DISK_INCORRECT_PARAMETERS
    exit 1
}

########### Check disk exist ###########
$diskExist = (Get-WmiObject Win32_logicaldisk).DeviceId -contains "${disk}:"
if (-not $diskExist){
    Write-Debug "ERROR - disk ${disk}:\ not exist"
    Write-Host $DISK_NOT_EXIST
    exit 1
}

########### Check permit ###########

#Check delete permit
try{
    if (Test-path "${disk}:\$TEMP_FILE_NAME")
    {
        Remove-Item "${disk}:\$TEMP_FILE_NAME" -Force
    }
}catch{
    Write-Debug "ERROR - Error when DELETE file"
    Write-debug $_.Exception|format-list -force
    Write-Host $DISK_DELETE_FILE_ERROR
    exit 1
}

#Check write permit
try{
    (Get-date).ToString() + ": Test from Zabbix" | out-file -FilePath "${disk}:\$TEMP_FILE_NAME"
}catch{
    Write-Debug "ERROR - Error when WRITE file"
    Write-debug $_.Exception|format-list -force
    Write-Host $DISK_WRITE_FILE_ERROR
    exit 1
}

#Check change permit
try{
    (Get-date).ToString() + ": Test from Zabbix" | out-file -FilePath  "${disk}:\$TEMP_FILE_NAME" -Append
}catch{
    Write-Debug "ERROR - Error when CHANGE file"
    Write-debug $_.Exception|format-list -force
    Write-Host $DISK_CHANGE_FILE_ERROR
    exit 1
}

Write-Host $returnCode

