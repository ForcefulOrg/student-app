# Infrastructure Mapping Summary

This document maps the issue requirements to the implemented Azure infrastructure components.

## ✅ Requirements Fulfilled

### 1. Container Registry
**Requirement**: Container registry for storing Docker images
- **Implementation**: `modules/container-registry.bicep`
- **Resource**: Azure Container Registry (Basic SKU)
- **Features**: 
  - Admin user enabled for GitHub Actions
  - Unique naming: `studentappcr{5-char-suffix}` (alphanumeric only, complies with ACR naming requirements)
  - Integration with Web Apps for container deployment

### 2. Backend Web App for Containerized Application
**Requirement**: Backend Web App for containerized application
- **Implementation**: `modules/web-apps.bicep` (Backend section)
- **Resource**: Azure App Service with Linux container support
- **Features**:
  - Configured for Docker deployment from ACR
  - SQL connection string configured
  - CORS enabled for frontend communication
  - HTTPS enforced
  - Unique naming: `student-app-backend-{suffix}`

### 3. Frontend Web App for Containerized Application
**Requirement**: Frontend Web App for containerized application  
- **Implementation**: `modules/web-apps.bicep` (Frontend section)
- **Resource**: Azure App Service with Linux container support
- **Features**:
  - Configured for Docker deployment from ACR
  - Backend URL environment variable configured
  - HTTPS enforced
  - Unique naming: `student-app-frontend-{suffix}`

### 4. Azure SQL Free Tier with Database
**Requirement**: Azure SQL free tier with a database
- **Implementation**: `modules/sql-database.bicep`
- **Resource**: Azure SQL Database (Basic tier - free tier eligible)
- **Features**:
  - Basic SKU (5 DTU, 2GB storage)
  - Firewall rule for Azure services
  - Connection string automatically configured in Web Apps
  - Unique naming: `student-app-sql-{suffix}`

### 5. Storage Account for Logging
**Requirement**: Storage account for logging
- **Implementation**: `modules/storage-account.bicep`
- **Resource**: Azure Storage Account (Standard_LRS)
- **Features**:
  - Blob container for application logs
  - HTTPS required, secure access
  - Hot access tier for performance
  - Unique naming: `studentapplogs{5-char-suffix}` (complies with storage account naming requirements)

### 6. Random and Unique Numbers in Resource Names
**Requirement**: Create random and unique number to be generated into the name of each resource
- **Implementation**: `main.bicep` - `uniqueString(resourceGroup().id)`
- **Approach**: Uses Azure's built-in `uniqueString()` function
- **Result**: 5-character unique suffix based on resource group ID for all resources
- **Benefits**: Guaranteed uniqueness, reproducible for same resource group
- **Note**: All resources now use 5-character substring to comply with naming requirements and limits

### 7. GitHub Action Workflow with Manual Trigger
**Requirement**: GitHub Action workflow that can create the resources but so that it'll be triggered manually
- **Implementation**: `.github/workflows/deploy-infrastructure.yml`
- **Trigger**: `workflow_dispatch` (manual trigger only)
- **Features**:
  - Configurable environment (dev/staging/prod)
  - Configurable Azure region
  - Configurable resource group name
  - Secure parameter handling for SQL credentials
  - Comprehensive deployment summary
  - Automatic extraction of deployment outputs
  - Integration guidance for application CI/CD

## 🔍 Code Analysis Integration

The infrastructure templates are designed based on analysis of the existing application code:

### Backend Configuration
- **Connection String**: Extracted from `appsettings.json` pattern
- **Entity Framework**: SQL Server provider configured
- **Port Configuration**: Port 80 for container (from Dockerfile)
- **CORS**: Configured to allow frontend domain

### Frontend Configuration  
- **Backend URL**: Uses `REACT_APP_BACKEND_URL` environment variable (from App.tsx)
- **Build Process**: Uses Node.js 18 and Nginx (from Dockerfile)
- **Port Configuration**: Port 80 for Nginx serving

### Container Registry Integration
- **Image Names**: Matches existing deploy.yml patterns
  - `student-frontend:latest`
  - `student-backend:latest`
- **Authentication**: Admin user credentials for GitHub Actions

## 🚀 Deployment Flow

1. **Infrastructure Deployment** (Manual, one-time):
   ```
   GitHub Actions → Deploy Azure Infrastructure → Creates all resources
   ```

2. **Application Deployment** (Automatic on push):
   ```
   Code Push → Build Docker Images → Push to ACR → Deploy to Web Apps
   ```

## 📊 Resource Architecture

```
Resource Group: student-app-{env}-{suffix}-rg
├── Container Registry: studentappcr{5-char-suffix}
├── App Service Plan: student-app-plan-{5-char-suffix}
├── Backend Web App: student-app-backend-{5-char-suffix}
├── Frontend Web App: student-app-frontend-{5-char-suffix}
├── SQL Server: student-app-sql-{5-char-suffix}
├── SQL Database: student-appdb
└── Storage Account: studentapplogs{5-char-suffix}
    └── Blob Container: application-logs
```

All requirements from the issue have been successfully implemented with modern Azure best practices and integration with the existing application codebase.