# Use the official .NET 9 SDK image as a parent image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set the working directory
WORKDIR /source

# Copy the project file and restore dependencies
COPY backend.csproj .
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet publish -c Release -o /app

# Use the official .NET runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0
ENV ASPNETCORE_URLS=http://+:80

# Set the working directory
WORKDIR /app

# Copy the build output
COPY --from=build /app .

EXPOSE 5270

# Start the application
ENTRYPOINT ["dotnet", "backend.dll"]