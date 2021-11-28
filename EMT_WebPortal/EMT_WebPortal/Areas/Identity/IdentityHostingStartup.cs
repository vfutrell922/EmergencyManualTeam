/*
 * Author: Vincent Futrell
 * Date Las Modified: 11/16/2021
 * This file contains the startup code for Identity Hosting.This is where the password policy is declared and the database context is configured.
 * In Production, the Db connection string should retrieved via AWS Secrets Manager
 * */
using System;
using System.IO;
using EMT_WebPortal.Areas.Identity.Data;
using EMT_WebPortal.Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Amazon;
using Amazon.SecretsManager;
using Amazon.SecretsManager.Model;

[assembly: HostingStartup(typeof(EMT_WebPortal.Areas.Identity.IdentityHostingStartup))]
namespace EMT_WebPortal.Areas.Identity
{
    public class IdentityHostingStartup : IHostingStartup
    {
        public void Configure(IWebHostBuilder builder)
        {

            //Tells the program how to connect to the database, use context.Configuration... when developing. Use GetUserDBConnectionString() in production to the 
            //database connections string from AWS Secrets Manager
            builder.ConfigureServices((context, services) => {
                services.AddDbContext<EMT_WebPortalUserContext>(options =>
                    options.UseSqlServer(context.Configuration.GetConnectionString("EMT_WebPortalUserContextConnection")/*GetUserDBConnectionString()*/));

                services.AddDefaultIdentity<EMT_WebPortalUser>(options => 
                {
                    options.SignIn.RequireConfirmedAccount = true;
                    options.Password.RequireDigit = true;
                    options.Password.RequireLowercase = true;
                    options.Password.RequireUppercase = true;
                    options.Password.RequireNonAlphanumeric = false;
                    options.Password.RequiredUniqueChars = 0;
                    options.Password.RequiredLength = 8;
                    })
                .AddRoles<IdentityRole>().AddEntityFrameworkStores<EMT_WebPortalUserContext>();
            });
        }

        /// <summary>
        /// Returns the decrypted connection string for the users database
        /// </summary>
        /// <returns></returns>
        public static string GetUserDBConnectionString()
        {
            string secretName = "UserDBConnectionString";
            string region = "us-east-2";
            string secret = "";

            MemoryStream memoryStream = new MemoryStream();

            IAmazonSecretsManager client = new AmazonSecretsManagerClient(RegionEndpoint.GetBySystemName(region));

            GetSecretValueRequest request = new GetSecretValueRequest();
            request.SecretId = secretName;
            request.VersionStage = "AWSCURRENT"; 

            GetSecretValueResponse response = null;

            try
            {
                response = client.GetSecretValueAsync(request).Result;
            }
            catch (DecryptionFailureException e)
            {
                throw;
            }
            catch (InternalServiceErrorException e)
            {
                throw;
            }
            catch (InvalidParameterException e)
            {
                throw;
            }
            catch (InvalidRequestException e)
            {
                throw;
            }
            catch (ResourceNotFoundException e)
            {
                throw;
            }
            catch (System.AggregateException ae)
            {
                throw;
            }

            if (response.SecretString != null)
            {
                secret = response.SecretString;
            }
            else
            {
                memoryStream = response.SecretBinary;
                StreamReader reader = new StreamReader(memoryStream);
                string decodedBinarySecret = System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(reader.ReadToEnd()));
            }

            string[] secretParts = secret.Split(':');
            int secretLength = secretParts[1].Length;
            string returnString = secretParts[1].Substring(1, secretLength - 3);
            return returnString;
        }
    }
}