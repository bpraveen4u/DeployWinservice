Function TransformAppConfig
    {
    [CmdletBinding()]
        param(
            [string]$AppConfigPath = $(throw "AppConfigPath is required"),
            [string]$DbconnectionString  = $(throw "DbconnectionString is required"),
            [string]$StorageConnectionString = $(throw "StorageConnectionString is required"),
            [string]$BlobDownloadPath = $(throw "BlobDownloadPath is required"),
            [string]$AppInsightsInstrumentationKey  = $(throw "AppInsightsInstrumentationKey is required"),
            [string]$IsDeveloperMode  = $(throw "IsDeveloperMode is required"),
			[string]$BizTalkDBServerName  = $(throw "BizTalkDBServerName is required")
			               )
        $appConfig=[xml](Get-Content $AppConfigPath)
        #$appConfig.config
	    $appConfig.configuration.connectionStrings.ChildNodes[0].connectionString = $DbconnectionString
		$appConfig.selectSingleNode('//add[@key="StorageConnectionString"]').value = $StorageConnectionString 
		$appConfig.selectSingleNode('//add[@key="BlobDownloadPath"]').value = $BlobDownloadPath 
		$appConfig.selectSingleNode('//add[@key="ApplicationInsightsInstrumentationKey"]').value = $AppInsightsInstrumentationKey 
		$appConfig.selectSingleNode('//add[@key="IsDeveloperMode"]').value = $IsDeveloperMode 
		$appConfig.selectSingleNode('//add[@key="BizTalkDBServerName"]').value = $BizTalkDBServerName 
		$appConfig.Save($appConfigPath)
    } 
