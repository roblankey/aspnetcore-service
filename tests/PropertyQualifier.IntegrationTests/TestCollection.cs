using Xunit;

namespace PropertyQualifier.IntegrationTests
{
    [CollectionDefinition("Test Collection", DisableParallelization = true)]
    public class TestCollection : ICollectionFixture<TestFixture>
    {
    }
}