param( 
    [parameter(Mandatory=$true)] 
    [string] $action
) 
 
filter timestamp {"[$(Get-Date -Format G)]: $_"} 
$startTime = Get-Date 

#Replace
$AccountId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

try {
    $AzureContext = (Connect-AzAccount -Identity -AccountId $AccountId).context
    $AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
    Write-Output "Authenticated with System-assigned managed identity" | timestamp 
} catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

$ErrorActionPreference = "stop"

#Replace
$AzureResourceGroupName = "Resource_Group_name"
$AzureFunctionAppName = "Funtion_App_name"

if($action -eq 'stop') {
    $FunctionApp = Get-AzWebApp -ResourceGroupName $AzureResourceGroupName -Name $AzureFunctionAppName
    Stop-AzWebApp -ResourceGroupName $AzureResourceGroupName -Name $FunctionApp.Name
    Write-Output "Azure FuntionApp stopped" | timestamp
} else {
    $FunctionApp = Get-AzWebApp -ResourceGroupName $AzureResourceGroupName -Name $AzureFunctionAppName
    Start-AzWebApp -ResourceGroupName $AzureResourceGroupName -Name $FunctionApp.Name
    Write-Output "Azure FuntionApp initiated" | timestamp
}
