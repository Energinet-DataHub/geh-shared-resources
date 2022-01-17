using System;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace FunctionApp1
{
    public static class Function4
    {
        [Function("Function4")]
        public static void Run([ServiceBusTrigger("testq", Connection = "sbconstring")] string myQueueItem, FunctionContext context)
        {
            var logger = context.GetLogger("Function4");
            logger.LogInformation($"C# ServiceBus queue trigger function processed message: {myQueueItem}");
        }
    }
}
