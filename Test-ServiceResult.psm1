function Test-ServiceResult(
    [string]$operation = $(throw "operation is required"), 
    [object]$result = $(throw "result is required"), 
    [switch]$continueOnError = $false)
{
    $retVal = -1
    if ($result.GetType().Name -eq "UInt32") { $retVal = $result } else {$retVal = $result.ReturnValue}
         
    if ($retVal -eq 0) {return}
     
    $errorcode = 'Success,Not Supported,Access Denied,Dependent Services Running,Invalid Service Control'
    $errorcode += ',Service Cannot Accept Control, Service Not Active, Service Request Timeout'
    $errorcode += ',Unknown Failure, Path Not Found, Service Already Running, Service Database Locked'
    $errorcode += ',Service Dependency Deleted, Service Dependency Failure, Service Disabled'
    $errorcode += ',Service Logon Failure, Service Marked for Deletion, Service No Thread'
    $errorcode += ',Status Circular Dependency, Status Duplicate Name, Status Invalid Name'
    $errorcode += ',Status Invalid Parameter, Status Invalid Service Account, Status Service Exists'
    $errorcode += ',Service Already Paused'
    $desc = $errorcode.Split(',')[$retVal]
     
    $msg = ("{0} failed with code {1}:{2}" -f $operation, $retVal, $desc)
     
    if (!$continueOnError) { Write-Error $msg } else { Write-Warning $msg }        
}
Export-ModuleMember -Function Test-ServiceResult