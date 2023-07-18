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

#Replace
$resourceGroupName = "Resource_Group_name"
$serverName = "Database_name"
$SubscriptionId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

$ErrorActionPreference = "stop"

if($action -eq 'stop') {
    $restUri = 'https://management.azure.com/subscriptions/'+$SubscriptionId+'/resourceGroups/'+$resourceGroupName+'/providers/Microsoft.DBForMySQL/servers/'+$serverName+'/stop?api-version=2020-01-01-privatepreview'

    $httpClient = New-Object System.Net.Http.HttpClient

    foreach ($headerKey in $authHeader.Keys) {
        $headerValue = $authHeader[$headerKey]
        $httpClient.DefaultRequestHeaders.TryAddWithoutValidation($headerKey, $headerValue)
    }

    $request = New-Object System.Net.Http.HttpRequestMessage([System.Net.Http.HttpMethod]::Post, $restUri)

    $byteContent = [System.Text.Encoding]::UTF8.GetBytes("")

    $request.Content = New-Object System.Net.Http.StringContent("", [System.Text.Encoding]::UTF8, "application/json")
    
    $response = $httpClient.SendAsync($request).GetAwaiter().GetResult()

    try{
        Write-Output "Try stop" | timestamp

        $responseContent = $response.Content.ReadAsStringAsync().GetAwaiter().GetResult()

        Write-Output "$servername is getting stopped" | timestamp 1
    } catch {
        Write-Error -Message $_.Exception
        Write-Output $_.Exception
        throw $_.Exception   
    }
} else {
    $restUri = 'https://management.azure.com/subscriptions/'+$SubscriptionId+'/resourceGroups/'+$resourceGroupName+'/providers/Microsoft.DBForMySQL/servers/'+$serverName+'/start?api-version=2020-01-01-privatepreview'

    $httpClient = New-Object System.Net.Http.HttpClient

    foreach ($headerKey in $authHeader.Keys) {
        $headerValue = $authHeader[$headerKey]
        $httpClient.DefaultRequestHeaders.TryAddWithoutValidation($headerKey, $headerValue)
    }

    $request = New-Object System.Net.Http.HttpRequestMessage([System.Net.Http.HttpMethod]::Post, $restUri)

    $byteContent = [System.Text.Encoding]::UTF8.GetBytes("")

    $request.Content = New-Object System.Net.Http.StringContent("", [System.Text.Encoding]::UTF8, "application/json")
    
    $response = $httpClient.SendAsync($request).GetAwaiter().GetResult()

    try{
        Write-Output "Try start" | timestamp

        $responseContent = $response.Content.ReadAsStringAsync().GetAwaiter().GetResult()

        Write-Output "$servername is getting started" | timestamp 1
    } catch {
        Write-Error -Message $_.Exception
        Write-Output $_.Exception
        throw $_.Exception   
    }
}
