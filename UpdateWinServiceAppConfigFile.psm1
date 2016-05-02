Function TransformAppConfig
    {
    [CmdletBinding()]
        param(
            [string]$AppConfigPath = $(throw "AppConfigPath is required"),
            [string]$DbconnectionString  = $(throw "DbconnectionString is required"),
             )
        $appConfig=[xml](Get-Content $AppConfigPath)
        #$appConfig.config
	    $appConfig.configuration.connectionStrings.ChildNodes[0].connectionString = $DbconnectionString
		#$appConfig.selectSingleNode('//add[@key="key"]').value = $value 
		 
		$appConfig.Save($appConfigPath)
    } 
