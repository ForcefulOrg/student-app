@description('Location for all resources')
param location string = resourceGroup().location

@description('Environment name (e.g., dev, staging, prod)')
param environment string = 'dev'

@description('Application name prefix')
param appName string = 'student-app'

@description('Unique suffix for resource names to ensure global uniqueness')
param uniqueSuffix string = uniqueString(resourceGroup().id)

@description('SQL Server administrator username')
@secure()
param sqlAdminUsername string

@description('SQL Server administrator password')
@secure()
param sqlAdminPassword string

// Container Registry
module containerRegistry 'modules/container-registry.bicep' = {
  name: 'containerRegistry'
  params: {
    location: location
    registryName: '${replace(appName, '-', '')}cr${substring(uniqueSuffix, 0, 5)}'
    environment: environment
  }
}

// Storage Account for logging
module storageAccount 'modules/storage-account.bicep' = {
  name: 'storageAccount'
  params: {
    location: location
    storageAccountName: '${replace(appName, '-', '')}logs${substring(uniqueSuffix, 0, 5)}'
    environment: environment
  }
}

// SQL Database
module sqlDatabase 'modules/sql-database.bicep' = {
  name: 'sqlDatabase'
  params: {
    location: location
    serverName: '${appName}-sql-${substring(uniqueSuffix, 0, 5)}'
    databaseName: '${appName}db'
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
    environment: environment
  }
}

// Web Apps
module webApps 'modules/web-apps.bicep' = {
  name: 'webApps'
  params: {
    location: location
    appServicePlanName: '${appName}-plan-${substring(uniqueSuffix, 0, 5)}'
    backendAppName: '${appName}-backend-${substring(uniqueSuffix, 0, 5)}'
    frontendAppName: '${appName}-frontend-${substring(uniqueSuffix, 0, 5)}'
    containerRegistryName: containerRegistry.outputs.registryName
    containerRegistryUrl: containerRegistry.outputs.loginServer
    sqlServerName: sqlDatabase.outputs.serverName
    sqlDatabaseName: sqlDatabase.outputs.databaseName
    sqlAdminUsername: sqlAdminUsername
    sqlAdminPassword: sqlAdminPassword
    environment: environment
  }
}

// Outputs for GitHub Actions and deployment
output containerRegistryName string = containerRegistry.outputs.registryName
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
output backendAppName string = webApps.outputs.backendAppName
output frontendAppName string = webApps.outputs.frontendAppName
output sqlServerName string = sqlDatabase.outputs.serverName
output sqlDatabaseName string = sqlDatabase.outputs.databaseName
output storageAccountName string = storageAccount.outputs.storageAccountName
output resourceGroupName string = resourceGroup().name