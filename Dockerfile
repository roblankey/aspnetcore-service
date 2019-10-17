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

FROM test AS version
WORKDIR /code/src/DotNetCore30

# install dotnet 2.1 for the version tool
RUN dotnet tool install -g dotnet-version-cli && \
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
wget -q https://packages.microsoft.com/config/debian/9/prod.list && \
mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
apt-get update && \
apt-get install -y dotnet-sdk-2.1

# version the project
ARG VERSION
RUN export PATH="$PATH:/root/.dotnet/tools" && \
dotnet version -s $VERSION

FROM version AS publish
WORKDIR /code/src/DotNetCore30

# publish
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS api
WORKDIR /app
COPY --from=publish /code/src/DotNetCore30/publish ./

HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit
ENTRYPOINT ["dotnet", "DotNetCore30.dll"]
