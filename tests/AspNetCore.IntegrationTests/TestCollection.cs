using Xunit;

namespace AspNetCore.IntegrationTests
{
    [CollectionDefinition("Test Collection", DisableParallelization = true)]
    public class TestCollection : ICollectionFixture<TestFixture>
    {
    }
}