using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace FunctionApp1
{
    public static class DbStuff
    {
        public static async Task DoDb(ILogger logger, string context)
        {
            // Get the connection string from app settings and use it to create a connection.
            var str = Environment.GetEnvironmentVariable("sqldb_connection");
            await using SqlConnection conn = new SqlConnection(str);
            conn.Open();
            var text = $"INSERT INTO table1 (test) VALUES ('{DateTime.Now:F} from {context}')";

            await using SqlCommand cmd = new SqlCommand(text, conn);
            // Execute the command and log the # rows affected.
            var rows = await cmd.ExecuteNonQueryAsync();
            logger.LogInformation($"{rows} rows were updated");
        }
    }
}
