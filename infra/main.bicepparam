using './main.bicep'

param skipVnet = bool(readEnvironmentVariable('SKIP_VNET', 'true'))
param environmentName  = readEnvironmentVariable('AZURE_ENV_NAME', 'MY_ENV')
param location = readEnvironmentVariable('AZURE_LOCATION', 'eastus2')
param principalId = readEnvironmentVariable('AZURE_PRINCIPAL_ID', '')
param openAiSkuName = 'S0'
param openAiServiceName = readEnvironmentVariable('AZURE_OPENAI_SERVICE', '')
param openAiHost = readEnvironmentVariable('OPENAI_HOST', 'azure')
param chatGptDeploymentName = readEnvironmentVariable('AZURE_OPENAI_CHATGPT_DEPLOYMENT', 'completion')
param chatGptDeploymentCapacity = int(readEnvironmentVariable('AZURE_OPENAI_CHATGPT_DEPLOYMENT_CAPACITY', '0'))
param chatGptDeploymentVersion = readEnvironmentVariable('AZURE_OPENAI_CHATGPT_DEPLOYMENT_VERSION', '2024-08-06')
param chatGptModelName = readEnvironmentVariable('AZURE_OPENAI_CHATGPT_MODEL', 'gpt-4o')
param storageAccountName = readEnvironmentVariable('AZURE_STORAGE_ACCOUNT', '')
param createRoleForUser  = bool(readEnvironmentVariable('CREATE_ROLE_FOR_USER', 'true'))
