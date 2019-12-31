using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace AspNetCore.HealthChecks
{
    public class BasicHealthCheck : IHealthCheck
    {
        public Task<HealthCheckResult> CheckHealthAsync(
            HealthCheckContext context, 
            CancellationToken cancellationToken = new CancellationToken())
        {
            const bool healthCheckResultHealthy = true;
//            const bool healthCheckResultHealthy = false;

            return Task.FromResult(healthCheckResultHealthy ? 
                HealthCheckResult.Healthy("A healthy result.") : 
                HealthCheckResult.Unhealthy("An unhealthy result."));
        }
    }
}
