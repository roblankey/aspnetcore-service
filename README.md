# ASP.Net Core example
> Generic project description...

## Development setup

### Dependencies

* [.NET Core SDK](https://www.microsoft.com/net/download)
* [JetBrains Rider](https://www.jetbrains.com/rider/)
* [Visual Studio](https://myaccess.rockfin.com/myaccess/dashboard.jsf)
* [Visual Studio Code](https://code.visualstudio.com/)

### Building
Since the application is .NET Core, it can easily be built, tested, and ran using the .NET Core CLI.
> `dotnet build`

### Testing
Both Unit and Integration tests are supported and expected. Tests are written using *Xunit*. Integration tests utilize *Microsoft.AspNetCore.TestHost*. Running tests is as easy as using the CLI to target which test project you would like to execute.

#### Unit
> `dotnet test .\tests\AspNetCore.UnitTests`

#### Integration
> `dotnet test .\tests\AspNetCore.IntegrationTests`

### Running
Running the application through the CLI is as simple as executing the run command. This will launch the application on the default port at http://localhost:5000
> `dotnet run`

## Contributing

### Branching
When contributing to this project, please create a corresponding bug or feature branch, with the TFS ticket number and a short description (e.g. *feature/N1-readme*). Push the branch to the remote as early and as often as desired so that tests can run appropriately.

### Pull Request
When ready to submit a pull request, please first squash your branch using
> `git rebase -i origin/master`

After the squash is complete, please simply submit a pull request to the master branch using the GitHub interface.

## Technologies
The following is a list of technologies used that you may want to familiarize yourself with.

* [ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/)
* [Swagger](https://swagger.io/)
