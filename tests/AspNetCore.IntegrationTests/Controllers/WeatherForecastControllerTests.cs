using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace AspNetCore.IntegrationTests.Controllers
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
            var response = await _client.GetAsync("/weatherforecast");
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            
            var actual = TestFixture.DeserializeResponseList<WeatherForecast>(response);
            Assert.NotNull(actual);
            Assert.NotEmpty(actual);
            Assert.Equal(5, actual.Count);
        }
    }
}