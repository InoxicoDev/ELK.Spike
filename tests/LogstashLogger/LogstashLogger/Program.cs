using NLog;
using System;

namespace LogstashLogger
{
    class Program
    {
        private static readonly ILogger Logger = LogManager.GetCurrentClassLogger();

        static void Main(string[] args)
        {
            Logger.Info("Test message");
            Logger.Error(new Exception("Upper exception", new Exception("Inner exception")), "Exception error");

            Logger.Factory.Flush();
        }
    }
}
