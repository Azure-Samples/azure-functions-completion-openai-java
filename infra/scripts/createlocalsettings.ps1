$ErrorActionPreference = "Stop"

if (-not (Test-Path ".\app\local.settings.json")) {

    $output = azd env get-values

    # Parse the output to get the endpoint values
    foreach ($line in $output) {
        if ($line -match "AZURE_OPENAI_ENDPOINT"){
            $AZURE_OPENAI_ENDPOINT = ($line -split "=")[1] -replace '"',''
        }
    }

    @{
        "IsEncrypted" = "false";
        "Values" = @{
            "AzureWebJobsStorage" = "UseDevelopmentStorage=true";
            "FUNCTIONS_WORKER_RUNTIME" = "java";
            "AZURE_OPENAI_ENDPOINT" = "$AZURE_OPENAI_ENDPOINT";
            "CHAT_MODEL_DEPLOYMENT_NAME" = "completion";
        }
    } | ConvertTo-Json | Out-File -FilePath ".\app\local.settings.json" -Encoding ascii
}