using Xunit;

namespace DotNetCore30.IntegrationTests
{
    [CollectionDefinition("Test Collection", DisableParallelization = true)]
    public class TestCollection : ICollectionFixture<TestFixture>
    {
    }
}