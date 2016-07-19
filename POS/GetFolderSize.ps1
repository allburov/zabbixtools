# (c) DevOpsHQ, 2016
# Author: Aleksey Burov, DevOps

param (
[string] $folder,
[switch] $verbose
)


########### Define parameters ###########
# Value mapping - add this value mapping to Zabbix web-interface
$ERROR_IN_SCRIPT = -1
$FOLDER_NOT_EXIST_STATUS = -2

$returnCode = $ERROR_IN_SCRIPT


########### Print arguments and set debug ###########
if (Test-Path $folder){
    try{
        $returnCode = (Get-ChildItem -path $folder -recurse | Measure-Object -property length -sum ).sum
        #For empty folder
        if ($returnCode -eq $Null) {
            $returnCode = 0
        }
    }
    catch{
            Write-Debug "ERROR - Error when get size"
            Write-debug $_.Exception|format-list -force
            Write-Host $ERROR_IN_SCRIPT
            exit 1
    }
}
else{
    $returnCode = $FOLDER_NOT_EXIST_STATUS
     Write-Debug "Folder $folder are not exist"
}

Write-Host $returnCode

