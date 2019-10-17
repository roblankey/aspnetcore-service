FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /code

# restore
COPY *.sln .
COPY src/DotNetCore30/*.csproj ./src/DotNetCore30/
COPY tests/DotNetCore30.IntegrationTests/*.csproj ./tests/DotNetCore30.IntegrationTests/
COPY tests/DotNetCore30.UnitTests/*.csproj ./tests/DotNetCore30.UnitTests/
RUN dotnet restore

# build
COPY src/DotNetCore30/* ./src/DotNetCore30/
COPY tests/DotNetCore30.IntegrationTests/* ./tests/DotNetCore30.IntegrationTests/
COPY tests/DotNetCore30.UnitTests/* ./tests/DotNetCore30.UnitTests/
RUN dotnet build

FROM build AS test
WORKDIR /code/tests

RUN cd DotNetCore30.UnitTests && \
dotnet test && \
cd ..

RUN cd DotNetCore30.IntegrationTests && \
dotnet test && \
cd ..

FROM test AS publish
WORKDIR /code/src/DotNetCore30

# publish
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS api
WORKDIR /app
COPY --from=publish /code/src/DotNetCore30/publish ./

HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit
ENTRYPOINT ["dotnet", "DotNetCore30.dll"]
