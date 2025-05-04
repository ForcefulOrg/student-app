# backend API

This is an ASP.NET Core API project named "backend" that provides weather forecast data.

## Project Structure

- **Controllers**
  - `WeatherForecastController.cs`: Handles HTTP requests related to weather forecasts.
- **Models**

  - `WeatherForecast.cs`: Defines the properties of a weather forecast.

- **Properties**

  - `launchSettings.json`: Contains settings for launching the application.

- **Configuration Files**

  - `appsettings.Development.json`: Configuration settings for the development environment.
  - `appsettings.json`: General configuration settings for the application.

- **Project Files**
  - `backend.csproj`: Project file defining dependencies and build settings.
  - `Program.cs`: Entry point of the application.
  - `Startup.cs`: Configures services and the application's request pipeline.

## Getting Started

1. Clone the repository:

   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:

   ```
   cd backend
   ```

3. Restore the dependencies:

   ```
   dotnet restore
   ```

4. Run the application:

   ```
   dotnet run
   ```

5. Access the API at `http://localhost:5270` and the OpenAPI documentation at `http://localhost:5270/swagger`.

## API Endpoints

- `GET /weatherforecast`: Retrieves weather forecast data.

## Contributing

Feel free to submit issues or pull requests for improvements or bug fixes.
