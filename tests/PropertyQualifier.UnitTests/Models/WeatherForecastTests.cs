using Xunit;

namespace PropertyQualifier.UnitTests.Models
{
    public class WeatherForecastTests
    {
        [Fact]
        public void Test_Temperature_Conversion()
        {
            var forecast = new WeatherForecast {TemperatureC = 22};
            Assert.Equal(71, forecast.TemperatureF);
        }
    }
}
