FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /code

# restore
COPY *.sln .
COPY src/PropertyQualifier/*.csproj ./src/PropertyQualifier/
COPY tests/PropertyQualifier.UnitTests/*.csproj ./tests/PropertyQualifier.UnitTests/
RUN dotnet restore

# build
COPY src/PropertyQualifier/* ./src/PropertyQualifier/
COPY tests/PropertyQualifier.UnitTests/* ./tests/PropertyQualifier.UnitTests/
RUN dotnet build

FROM build AS test
WORKDIR /code/tests/PropertyQualifier.UnitTests

RUN dotnet test

#FROM test AS sonar
#WORKDIR /code

#RUN dotnet tool install --global dotnet-sonarscanner && \
#dotnet tool install --global coverlet.console && \
#apt-get update && \
#apt-get install -y openjdk-8-jre

#COPY run-sonar.sh .
#RUN export PATH=$PATH:/root/.dotnet/tools && \
#chmod +x run-sonar.sh && \
#./run-sonar.sh property-qualifier

FROM test AS publish
WORKDIR /code/src/PropertyQualifier

# version
# ARG VERSION
# RUN dotnet tool install -g dotnet-version-cli && \
# export PATH="$PATH:/root/.dotnet/tools" && \
# dotnet version -s -f ./PropertyQualifier.csproj $VERSION

# publish
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS api
WORKDIR /app
COPY --from=publish /app/src/PropertyQualifier/publish ./

HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit
ENTRYPOINT ["dotnet", "PropertyQualifier.dll"]
