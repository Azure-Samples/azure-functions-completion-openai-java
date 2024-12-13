#!/bin/bash

set -e

if [ ! -f "./app/local.settings.json" ]; then

    output=$(azd env get-values)

    # Initialize variables
    AZURE_OPENAI_ENDPOINT=""

    # Parse the output to get the endpoint URLs
    while IFS= read -r line; do
        if [[ $line == *"AZURE_OPENAI_ENDPOINT"* ]]; then
            AZURE_OPENAI_ENDPOINT=$(echo "$line" | cut -d '=' -f 2 | tr -d '"')
        fi
    done <<< "$output"

    cat <<EOF > ./app/local.settings.json
{
    "IsEncrypted": "false",
    "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "java",
        "AZURE_OPENAI_ENDPOINT": "$AZURE_OPENAI_ENDPOINT",
        "CHAT_MODEL_DEPLOYMENT_NAME": "completion"
    }
}
EOF

fi