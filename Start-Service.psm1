function Start-Service(
    [string]$serviceName = $(throw "serviceName is required"), 
    [string]$targetServer = $(throw "targetServer is required"))
{
    "Getting service $serviceName on server $targetServer"
    $service = Get-Service $serviceName $targetServer
    if (!($service.Started))
    {
        "Starting service $serviceName on server $targetServer"
        $result = $service.StartService()
        Test-ServiceResult -operation "Starting service $serviceName on $targetServer" -result $result   
    }
}

export-modulemember -function Start-Service