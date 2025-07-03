@description('Location for the web apps')
param location string

@description('Name of the App Service Plan')
param appServicePlanName string

@description('Name of the backend web app')
param backendAppName string

@description('Name of the frontend web app')
param frontendAppName string

@description('Container registry name')
param containerRegistryName string

@description('Container registry URL')
param containerRegistryUrl string

@description('SQL server name')
param sqlServerName string

@description('SQL database name')
param sqlDatabaseName string

@description('SQL administrator username')
@secure()
param sqlAdminUsername string

@description('SQL administrator password')
@secure()
param sqlAdminPassword string

@description('Environment name')
param environment string

// App Service Plan for hosting the web apps
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
  tags: {
    Environment: environment
    Application: 'student-app'
  }
}

// Backend Web App (ASP.NET Core API)
resource backendWebApp 'Microsoft.Web/sites@2023-01-01' = {
  name: backendAppName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    reserved: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerRegistryUrl}/student-backend:latest'
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${containerRegistryUrl}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistryName
        }
        {
          name: 'DOCKER_ENABLE_CI'
          value: 'true'
        }
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultConnection'
          connectionString: 'Server=tcp:${sqlServerName}${az.environment().suffixes.sqlServerHostname},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${sqlAdminUsername};Password=${sqlAdminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
          type: 'SQLAzure'
        }
      ]
      cors: {
        allowedOrigins: [
          'https://${frontendAppName}.azurewebsites.net'
        ]
        supportCredentials: false
      }
    }
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
  tags: {
    Environment: environment
    Application: 'student-app'
    Tier: 'backend'
  }
}

// Frontend Web App (React/Nginx)
resource frontendWebApp 'Microsoft.Web/sites@2023-01-01' = {
  name: frontendAppName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    reserved: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerRegistryUrl}/student-frontend:latest'
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${containerRegistryUrl}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistryName
        }
        {
          name: 'DOCKER_ENABLE_CI'
          value: 'true'
        }
        {
          name: 'REACT_APP_BACKEND_URL'
          value: 'https://${backendAppName}.azurewebsites.net'
        }
      ]
    }
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
  tags: {
    Environment: environment
    Application: 'student-app'
    Tier: 'frontend'
  }
}

output appServicePlanName string = appServicePlan.name
output backendAppName string = backendWebApp.name
output frontendAppName string = frontendWebApp.name
output backendUrl string = 'https://${backendWebApp.properties.defaultHostName}'
output frontendUrl string = 'https://${frontendWebApp.properties.defaultHostName}'