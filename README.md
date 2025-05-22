# Student-app for CloudLand 2025 workshop 🚀

This app is a part of "Shipping containers to Azure CloudLand using native tooling" workshop held at CloudLand 2025 by Christian Gläser and Jukka Loikkanen.

## Description 📚

Description of the application to be added.

## How to deploy ⚙️

Description on how to deploy to be added.

### Find relevant details:

1. Get Subscription ID and and Registry Access keys

![alt text](infrastructure-setup/Subscription.png)

![alt text](infrastructure-setup/container-registry-access-keys.png)

Please note the Username and Password it is required as environment variable AZURE_REGISTRY_PASSWORD and AZURE_REGISTRY_USERNAME

2. Create Service Principal in Azure to connect Github repo and Azure tenant
   https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?view=azure-cli-latest&tabs=bash

Relevant script (in Bash format)

```
az ad sp create-for-rbac --name student-app-sp --role contributor --scopes /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG2/providers/Microsoft.Compute/virtualMachines/myVM
```

Output is similar to this:

```
{
"clientId": "uuid-1234-5678-9101-abcdef123456",
"clientSecret": "your-client-secret",
"subscriptionId": "your-subscription-id",
"tenantId": "your-tenant-id",
"activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
"resourceManagerEndpointUrl": "https://management.azure.com/",
"activeDirectoryGraphResourceId": "https://graph.windows.net/",
"sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
"galleryEndpointUrl": "https://gallery.azure.com/",
"managementEndpointUrl": "https://management.core.windows.net/"
}
```

Please copy the output, it contains the relevant details for the AZURE_CREDENTIALS environment secret

2. Grant Service Principal permissions to Resource Group (either through script or in Azure Portal)

Environment variables secrets needed:
AZURE_CREDENTIALS - Output from Bash script, see above
AZURE_REGISTRY_PASSWORD - your-password from registry
AZURE_REGISTRY_USERNAME - your username from the registry

![GH Actions Secrets](infrastructure-setup/Github-secrets.png)

[Github Actions Variables](/student-app/settings/variables/actions)
AZURE_REGISTRY_LOGIN_SERVER - The name of the container registry being used, e.g. student-app-cr.azurecr.io
AZURE_RESOURCE_GROUP - The resource group name, e.g. learn-to-build-rg

![GH Actions Variables](infrastructure-setup/Github-environment-variables.png)
