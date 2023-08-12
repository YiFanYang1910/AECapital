# Use the official .NET runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Set the working directory in the container
WORKDIR /app

# Copy the published application to the container
COPY ./out .

# Expose the port that the application listens on
EXPOSE 80

# Start the application when the container starts
ENTRYPOINT ["dotnet", "AECapital.dll"]