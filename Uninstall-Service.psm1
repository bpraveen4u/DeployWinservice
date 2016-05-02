function Uninstall-Service(
    [string]$serviceName = $(throw "serviceName is required"), 
    [string]$targetServer = $(throw "targetServer is required"))
{
    $service = Get-Service $serviceName $targetServer
     
    if (!($service))
    { 
        Write-Warning "Failed to find service $serviceName on $targetServer. Nothing to uninstall."
        return
    }
     
    "Found service $serviceName on $targetServer; checking status"
             
    if ($service.Started)
    {
        "Stopping service $serviceName on $targetServer"
        #could also use Set-Service, net stop, SC, psservice, psexec etc.
        $result = $service.StopService()
        Test-ServiceResult -operation "Stop service $serviceName on $targetServer" -result $result
    }
     
    "Attempting to uninstall service $serviceName on $targetServer"
    $result = $service.Delete()
    Test-ServiceResult -operation "Delete service $serviceName on $targetServer" -result $result   
}

Export-ModuleMember -Function Uninstall-Service