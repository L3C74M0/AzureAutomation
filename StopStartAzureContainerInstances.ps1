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

$ErrorActionPreference = "stop"

#Replace
$ResourceGroupName = "Resource_Group_name"
$ContainerGroupName = "Container_Instances_name"
$SubscriptionId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

if($action -eq 'stop') {
    Stop-AzContainerGroup `
        -ResourceGroupName $ResourceGroupName `
        -Name $ContainerGroupName `
        -SubscriptionId $SubscriptionId
    
    Write-Output "Azure Container Instances stopped" | timestamp
} else {
    Start-AzContainerGroup `
        -ResourceGroupName $ResourceGroupName `
        -Name $ContainerGroupName `
        -SubscriptionId $SubscriptionId

    Write-Output "Azure Container Instances initiated" | timestamp
} 
