function Install-Service(
    [string]$serviceName = $(throw "serviceName is required"), 
    [string]$targetServer = $(throw "targetServer is required"),
    [string]$displayName = $(throw "displayName is required"),
    [string]$physicalPath = $(throw "physicalPath is required"),
    [string]$userName = $(throw "userName is required"),
    [string]$password = "",
    [string]$startMode = "Automatic",
    [string]$description = "",
    [bool]$interactWithDesktop = $false
)
{
    # can't use installutil; only for installing services locally
    #[wmiclass]"Win32_Service" | Get-Member -memberType Method | format-list -property:*    
    #[wmiclass]"Win32_Service"::Create( ... )        
         
    # todo: cleanup this section 
    $serviceType = 16          # OwnProcess
    $serviceErrorControl = 1   # UserNotified
    $loadOrderGroup = $null
    $loadOrderGroupDepend = $null
    $dependencies = $null
    
    # description?
    $params = `
        $serviceName, `
        $displayName, `
        $physicalPath, `
        $serviceType, `
        $serviceErrorControl, `
        $startMode, `
        $interactWithDesktop, `
        $userName, `
        $password, `
        $loadOrderGroup, `
        $loadOrderGroupDepend, `
        $dependencies `
         
    $scope = new-object System.Management.ManagementScope("\\$targetServer\root\cimv2", `
        (new-object System.Management.ConnectionOptions))
    "Connecting to $targetServer"
    $scope.Connect()
    $mgt = new-object System.Management.ManagementClass($scope, `
        (new-object System.Management.ManagementPath("Win32_Service")), `
        (new-object System.Management.ObjectGetOptions))
     
    $op = "service $serviceName ($physicalPath) on $targetServer"    
    "Installing $op"
    $result = $mgt.InvokeMethod("Create", $params)    
    Test-ServiceResult -operation "Install $op" -result $result
    "Installed $op"
     
    "Setting $serviceName description to '$description'"
    Set-Service -ComputerName $targetServer -Name $serviceName -Description $description
    "Service install complete"
}
Export-ModuleMember -Function Install-Service