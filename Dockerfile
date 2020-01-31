FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
WORKDIR /src
COPY dotnet-core-hello-world.csproj dotnet-core-hello-world.csproj
RUN dotnet restore dotnet-core-hello-world.csproj
COPY . .
WORKDIR /src
RUN dotnet build dotnet-core-hello-world.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish dotnet-core-hello-world.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "dotnet-core-hello-world.dll"]