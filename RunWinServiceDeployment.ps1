
Param(
    [string]$serviceName = $(throw "serviceName is required"),
    [string]$serviceExecutableName = $(throw "serviceExecutableName is required"),
    [string]$sourcePath = $(throw "sourcePath is required"),
    [string]$targetServer= $(throw "targetServer is required"),
    [string]$targetServerUNCpath= $(throw "targetServerUNCpath is required"),
    [string]$targetServerPhysicalPath= $(throw "targetServerPhysicalPath is required"),
    [string]$userName= $(throw "userName is required"),
    [string]$password = $(throw "password is required"),
    [string]$DeploymentDropPath = $(throw "DeploymentDropPath is required"),
	[string]$SqlConnectionString = $(throw "SqlConnectionString is required")

)

Import-Module "$DeploymentDropPath\UpdateWinServiceAppConfigFile.psm1"
Import-Module "$DeploymentDropPath\Get-Service.psm1"
Import-Module "$DeploymentDropPath\Uninstall-Service.psm1"
Import-Module "$DeploymentDropPath\Install-Service.psm1"
Import-Module "$DeploymentDropPath\Start-Service.psm1"
Import-Module "$DeploymentDropPath\Test-ServiceResult.psm1"

    $exeFullPath = $targetServerPhysicalPath+"\"+$serviceExecutableName
	$configUNCPath = $targetServerUNCpath + "\" + $serviceExecutableName + ".config"

    "Deploying Service files"
     
    Write-Output "Stopping, uninstalling service $serviceName on $targetServer"
    Uninstall-Service $serviceName $targetServer
 
    "Pausing to avoid potential temporary access denied"
    Start-Sleep -s 5 
     
    #"Deleting destination dir files"
    #Remove-Item -Recurse -Force "$targetServerUNCpath\*"
         
    Write-Output "Copying files from $sourcePath to $targetServerUNCpath"
    Copy-Item "$sourcePath\*" $targetServerUNCpath -recurse -force

	#Update Configurations
	TransformAppConfig -AppConfigPath $configUNCPath -DbconnectionString $SqlConnectionString
     
    Install-Service `
    -ServiceName $serviceName `
    -TargetServer $targetServer `
    -DisplayName $serviceName `
    -PhysicalPath $exeFullPath `
    -Username $userName `
	-password $password `
    -description "Deployment Service - OnPrimise"
         
    Start-Service $serviceName $targetServer

    "Deploying Service Completed."
