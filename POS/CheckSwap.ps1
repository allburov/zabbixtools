# (c) DevOpsHQ, 2016
# Author: Aleksey Burov, DevOps

param (
[switch] $verbose
)


########### Define parameters ###########
$OK_STATUS = "OK"

$returnCode = ""


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

########### Check swap and page file ###########
try{
    $pageFiles = (Get-WmiObject Win32_PageFileUsage).Name
}
Catch {
    Write-debug $_.Exception|format-list -force
    Write-Host "Error when run Get-WmiObject Win32_PageFileUsage"
    exit 1
}

foreach ($pageFile in $pageFiles){

    $returnCode += "$pageFile exist "

}


#if page/swap file not exist, return 0
if ($returnCode -eq ""){
    $returnCode = $OK_STATUS
}

Write-Host $returnCode

