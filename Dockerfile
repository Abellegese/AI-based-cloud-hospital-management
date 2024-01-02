# Use the official ASP.NET image as a base image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy the project files to the container
COPY ["hms.csproj", "./"]

# Restore NuGet packages
RUN dotnet restore "hms.csproj"

# Copy the remaining source code
COPY . .

# Build the application
RUN dotnet build "hms.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "hms.csproj" -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Entry point for the application
ENTRYPOINT ["dotnet", "hms.dll"]
