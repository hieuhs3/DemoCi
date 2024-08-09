# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy csproj and restore dependencies
COPY ["SocialNetwork.csproj", "SocialNetwork/"]
RUN dotnet restore "SocialNetwork/SocialNetwork.csproj"

# Copy everything else and build the project
COPY . .

# Thay đổi quyền truy cập thư mục build
RUN mkdir -p /src/build && chmod -R 777 /src/build

RUN dotnet build "SocialNetwork.csproj" -c Release -o /app/build

# Stage 2: Publish the application
RUN dotnet publish "SocialNetwork.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Create the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build-env /app/publish .

# Expose the port and set the entry point
EXPOSE 80
ENTRYPOINT ["dotnet", "SocialNetwork.dll"]
