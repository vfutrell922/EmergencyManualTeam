/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the DbInitializer class
 * This class contains only a single method to create and seed a database if none exists,
 * otherwise the method will return without making any changes.
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Data
{
    public class DbInitializer
    {
        /// <summary>
        /// Creates and seeds a database if none exists
        /// </summary>
        /// <param name="context"></param>
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
