using System;
using System.Net.Http;
using Microsoft.AspNetCore.Hosting;
using Newtonsoft.Json.Linq;
using Microsoft.AspNetCore.TestHost;

namespace PropertyQualifier.UnitTests
{
    public class TestFixture : IDisposable
    {
        public readonly TestServer Server;
        public readonly HttpClient Client;

        public TestFixture()
        {
            Environment.SetEnvironmentVariable("ASPNETCORE_ENVIRONMENT", "Test");
            Server = new TestServer(new WebHostBuilder()
                .UseStartup<TestStartup>()
                .UseEnvironment("Test"));
            Client = Server.CreateClient();
        }

        public void Dispose()
        {
            Client.Dispose();
            Server.Dispose();
        }

        public static T DeserializeResponse<T>(HttpResponseMessage response)
        {
            var json = response.Content.ReadAsStringAsync().Result;
            return JObject.Parse(json)["data"].ToObject<T>();
        }

        public T GetService<T>()
        {
            return (T)Server.Host.Services.GetService(typeof(T));
        }
    }
}
