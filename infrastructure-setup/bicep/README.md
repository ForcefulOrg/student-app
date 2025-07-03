# Azure Infrastructure Setup

This directory contains Bicep templates and GitHub Actions workflows for deploying the Student App infrastructure to Azure.

## 📋 Infrastructure Components

The infrastructure includes the following Azure resources:

- **Container Registry**: Stores Docker images for frontend and backend
- **App Service Plan**: Basic tier hosting plan for web applications
- **Backend Web App**: Containerized ASP.NET Core API
- **Frontend Web App**: Containerized React application
- **SQL Database**: Basic tier Azure SQL Database for data storage
- **Storage Account**: For application logging and file storage

## 🚀 Deployment

### Prerequisites

1. **Azure Subscription** with appropriate permissions
2. **Service Principal** configured for GitHub Actions
3. **GitHub Secrets** configured:
   - `AZURE_CREDENTIALS`: Service principal credentials (JSON format)
   - `SQL_ADMIN_PASSWORD`: Password for SQL Server admin user

### Manual Infrastructure Deployment

The infrastructure can be deployed manually using the GitHub Actions workflow:

1. Go to **Actions** tab in your GitHub repository
2. Select **Deploy Azure Infrastructure** workflow
3. Click **Run workflow**
4. Configure deployment parameters:
   - **Environment**: dev, staging, or prod
   - **Location**: Azure region (e.g., East US)
   - **Resource Group Name**: Optional, auto-generated if empty
   - **SQL Admin Username**: Database administrator username

### Deployment Outputs

After successful deployment, the workflow provides:

- **Resource names** for all created components
- **GitHub Actions variables** to update in your repository
- **Application URLs** for frontend and backend
- **Container registry credentials** for CI/CD

## 📁 File Structure

```
infrastructure-setup/bicep/
├── main.bicep                    # Main orchestration template
├── parameters.json               # Default parameters file
└── modules/
    ├── container-registry.bicep  # Container registry configuration
    ├── sql-database.bicep        # SQL Server and database
    ├── storage-account.bicep     # Storage account for logging
    └── web-apps.bicep           # App Service Plan and Web Apps
```

## 🔧 Configuration

### Resource Naming

All resources are named with a unique suffix to ensure global uniqueness:
- Pattern: `{appName}-{component}-{uniqueSuffix}`
- Example: `student-app-backend-abc123`

### Environment Variables

The infrastructure automatically configures:

**Backend Web App:**
- `DefaultConnection`: SQL Database connection string
- `ASPNETCORE_ENVIRONMENT`: Set to Production
- Container registry settings for Docker deployment

**Frontend Web App:**
- `REACT_APP_BACKEND_URL`: Backend API endpoint
- Container registry settings for Docker deployment

### Security Configuration

- **HTTPS Only**: All web applications enforce HTTPS
- **SQL Firewall**: Configured to allow Azure services
- **Container Registry**: Admin user enabled for GitHub Actions
- **Storage Account**: Private blob access, HTTPS required

## 🔄 Integration with Application Deployment

After infrastructure deployment:

1. Update GitHub repository variables:
   - `AZURE_REGISTRY_LOGIN_SERVER`
   - `AZURE_RESOURCE_GROUP`

2. Update GitHub repository secrets:
   - `AZURE_REGISTRY_USERNAME`
   - `AZURE_REGISTRY_PASSWORD`

3. The existing `deploy.yml` workflow will use these values for application deployment

## 💡 Tips

- Use different environments (dev/staging/prod) for different branches
- Resource group names are auto-generated with unique suffixes
- All resources are tagged with environment and application information
- SQL Database uses Basic tier (free tier eligible)
- Container registry uses Basic SKU for cost optimization

## 🛠️ Troubleshooting

### Common Issues

1. **Resource name conflicts**: The unique suffix should prevent this, but if it occurs, try deploying to a different resource group
2. **SQL password complexity**: Ensure the `SQL_ADMIN_PASSWORD` secret meets Azure's complexity requirements
3. **Service principal permissions**: Ensure the service principal has Contributor access to the subscription or resource group

### Validation

To validate templates locally:

```bash
# Install Azure CLI and Bicep
az bicep install

# Validate main template
az deployment group validate \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters @parameters.json
```