using System.Net;
using System.Text.Json;

namespace Amedia.WEBAPI.Helpers;

public class ExceptionMiddleware
{
    private readonly RequestDelegate next;
    private readonly ILogger<ExceptionMiddleware> logger;
    private readonly IHostEnvironment env;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger, IHostEnvironment env)
    {
        this.next = next;
        this.logger = logger;
        this.env = env;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await next(context);
        }
        catch (Exception ex)
        {
            var statusCode = (int)HttpStatusCode.InternalServerError;

            logger.LogError(ex, ex.Message);
            context.Response.StatusCode = statusCode;
            context.Response.ContentType = "application/json";

            var response = env.IsDevelopment()
                ? new ApiException(statusCode, ex.Message, ex.StackTrace.ToString())
                : new ApiException(statusCode);

            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };
            var json = JsonSerializer.Serialize(response, options);
            await context.Response.WriteAsync(json);
        }
    }
}