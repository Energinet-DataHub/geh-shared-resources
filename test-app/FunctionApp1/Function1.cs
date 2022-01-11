using System;
using System.IO;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace FunctionApp1
{
    public static class Function1
    {
        [Function("Function1")]
        public static void Run([BlobTrigger("input/{name}", Connection = "privatecfm_STORAGE")] string myBlob, string name,
            FunctionContext context)
        {
            var logger = context.GetLogger("Function1");
            logger.LogInformation($"C# Blob trigger function Processed blob\n Name: {name} \n Data: {myBlob}");
        }
    }
}
