using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Data
{
    public class DbInitializer
    {
        public static void Initialize(EMTManualContext context) 
        {
            context.Database.EnsureCreated();

            //Seed the database if no protocols exits
            if (!context.Protocols.Any()) 
            {
                Protocol_Seeding.SeedDatabase(context);
            }
        }
    }
}
