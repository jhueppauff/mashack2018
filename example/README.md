# CI / CD Build Pipeline

How to implement a CI/CD pipeline for Azure Stack app deployments

- <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-solution-pipeline>

# Tips & Tricks:

## Quickstart Templates for Azure Stack ARM Deployments

- <https://github.com/Azure/AzureStack-QuickStart-Templates>

## Useful Tools / Scripts

Read API versions of Azure Stack resource providers: 

```ps
##Login?

Add-AzureRmEnvironment -Name AzureStack -ARMEndpoint https://management.local.azurestack.external
Login-AzureRMAccount -Environment AzureStack

## Query

Get-AzureRmResourceProvider | Select ProviderNamespace -Expand ResourceTypes | Select * -Expand ApiVersions | Select ProviderNamespace, ResourceTypeName, @{Name="ApiVersion"; Expression={$_}}
```

Offical Documentation:

- <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-profiles-azure-resource-manager-versions>

Use Azure CLI instead of Powershell?

- <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-version-profiles-azurecli2>

You have existing ARM templates and want to validate them against your current AZStack?

- Cloud Capabilities / Template Validator (in AzureStack-Tools-master folder):

```ps
Import-Module .\TemplateValidator\AzureRM.TemplateValidator.psm1
Import-Module .\CloudCapabilities\AzureRM.CloudCapabilities.psm1
Get-AzureRMCloudCapability -Location local -Verbose
Test-AzureRMTemplate -TemplatePath C:\Users\Administrator\source\repos\TestDeployment\DbDeployment\azuredeploy1.json -CapabilitiesPath .\AzureCloudCapabilities.Json -Verbose
```

Further Information

- <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-considerations>