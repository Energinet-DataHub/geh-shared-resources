using System;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace FunctionApp1
{
    public static class Function2
    {
        [Function("Function2")]
        public static void Run([TimerTrigger("0 */15 * * * *")] MyInfo myTimer, FunctionContext context)
        {
            var logger = context.GetLogger("Function2");
            logger.LogInformation($"C# Timer trigger function executed at: {DateTime.Now}");
            DbStuff.DoDb(logger, "Timer");

            logger.LogInformation($"Next timer schedule at: {myTimer.ScheduleStatus.Next}");
        }



    }

    public class MyInfo
    {
        public MyScheduleStatus ScheduleStatus { get; set; }

        public bool IsPastDue { get; set; }
    }

    public class MyScheduleStatus
    {
        public DateTime Last { get; set; }

        public DateTime Next { get; set; }

        public DateTime LastUpdated { get; set; }
    }
}
