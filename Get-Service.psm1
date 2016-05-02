function Get-Service(
    [string]$serviceName = $(throw "serviceName is required"), 
    [string]$targetServer = $(throw "targetServer is required"))
{
    $service = Get-WmiObject -Namespace "root\cimv2" -Class "Win32_Service" `
        -ComputerName $targetServer -Filter "Name='$serviceName'" -Impersonation 3    
    return $service
}
Export-ModuleMember -Function Get-Service