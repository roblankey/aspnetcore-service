using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace PropertyQualifier.UnitTests.Controllers
{
    [Collection("Test Collection")]
    public class WeatherForecastControllerTests
    {
        private readonly HttpClient _client;
        
        public WeatherForecastControllerTests(TestFixture fixture)
        {
            _client = fixture.Client;
        }

        [Fact]
        public async Task Can_Get_WeatherForecast()
        {
            var response = await _client.GetAsync("/health");
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            
            var actual = TestFixture.DeserializeResponse<string>(response);
            Assert.NotNull(actual);
        }
    }
}