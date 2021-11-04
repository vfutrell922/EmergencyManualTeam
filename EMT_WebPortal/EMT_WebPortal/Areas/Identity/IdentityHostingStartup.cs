using System;
using EMT_WebPortal.Areas.Identity.Data;
using EMT_WebPortal.Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

[assembly: HostingStartup(typeof(EMT_WebPortal.Areas.Identity.IdentityHostingStartup))]
namespace EMT_WebPortal.Areas.Identity
{
    public class IdentityHostingStartup : IHostingStartup
    {
        public void Configure(IWebHostBuilder builder)
        {
            builder.ConfigureServices((context, services) => {
                services.AddDbContext<EMT_WebPortalUserContext>(options =>
                    options.UseSqlServer(
                        context.Configuration.GetConnectionString("EMT_WebPortalUserContextConnection")));

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
    }
}