param(
[Parameter(Mandatory=$true)]
[string]$ApplicationName,
[Parameter(Mandatory=$true)]
[string]$ApplicationUri,
[Parameter(Mandatory=$true)]
[string]$Password)

# Add AzureStack Environment and ARM Endpoint
Add-AzureRmEnvironment -Name AzureStack -ARMEndpoint https://management.local.azurestack.external

#Login with your AzureStack Account
Login-AzureRMAccount -Environment AzureStack

#Create an AD Application with Password
Write-Output "Creating AAD Application with Identifier - $ApplicationUri"
$application = New-AzureRmADApplication -DisplayName $ApplicationName `
    -IdentifierUris $ApplicationUri `
    -HomePage $ApplicationUri `
    -Password $Password

#Create a ServicePrincipal for the Application
Write-Output "Creating Service Pricnipal"
$svcprincipal = New-AzureRmADServicePrincipal -ApplicationId $application.ApplicationId

#we have to wait here
Write-Output “Waiting for SPN creation to reflect in Directory before Role assignment”
Start-Sleep 20

#Assign Contributor Role to ServicePrincipal for current subscription
Write-Output "Assigning Role Contributor"
$roleassignment = New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $application.ApplicationId.Guid

$subscription = (Get-AzureRmContext).Subscription

$result = @{
    ApplicationId = $application.ApplicationId;
    SubscriptionId = $subscription.Id;
    TenantId = $subscription.TenantId;
}

$result | Format-Table
