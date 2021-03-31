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
                services.AddDbContext<EMT_WebPortalContext>(options =>
                    options.UseSqlServer(
                        context.Configuration.GetConnectionString("EMT_WebPortalContextConnection")));

                services.AddDefaultIdentity<EMT_WebPortalUser>(options => options.SignIn.RequireConfirmedAccount = true)
                    .AddEntityFrameworkStores<EMT_WebPortalContext>();

                services.Configure<IdentityOptions>(options =>
                {
                    options.Password.RequireDigit = true;
                    options.Password.RequireLowercase = true;
                    options.Password.RequireNonAlphanumeric = true;
                    options.Password.RequireUppercase = true;
                    options.Password.RequiredLength = 8;

                    options.User.RequireUniqueEmail = true;
                });
            });
        }
    }
}