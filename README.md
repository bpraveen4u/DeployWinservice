# Deploy Windows Service using powershell and update the configurations

The script used to deploy the Windows service from any computer to another computer. It will also used to update the configurations after deployment.

# Usage steps
1. Copy the files into the folder
2. Run the RunWinServiceDeployment.ps1 with powershell providing the parameters
   -serviceName: Name of the Service
   -serviceExecutableName: Name of the executable file of the service
   -sourcePath: Service source assemblies
   -targetServer: Target server name, on which service needs to be deployed.
   -targetServerUNCpath: Target server UNC path where the service source assemblies to be deployed.
   -targetServerPhysicalPath: Target server service source assemblies path
   -userName: userName on which service account
   -password: password for the servicd run account
   -DeploymentDropPath: folder path where the other powershell modules present
   -SqlConnectionString: connection string to be updated in the config file after the deployment.

