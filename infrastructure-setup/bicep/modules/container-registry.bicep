@description('Location for the container registry')
param location string

@description('Name of the container registry')
param registryName string

@description('Environment name')
param environment string

@description('SKU for the container registry')
param sku string = 'Basic'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: registryName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
    publicNetworkAccess: 'Enabled'
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
  }
  tags: {
    Environment: environment
    Application: 'student-app'
  }
}

output registryName string = containerRegistry.name
output loginServer string = containerRegistry.properties.loginServer
output resourceId string = containerRegistry.id