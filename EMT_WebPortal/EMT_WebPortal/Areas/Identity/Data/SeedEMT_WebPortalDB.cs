
using EMT_WebPortal.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Areas.Identity.Data
{
    public class SeedEMT_WebPortalDB
    {
        public static async Task Initialize(IServiceProvider services) 
        {
            UserManager<EMT_WebPortalUser> userManager = services.GetRequiredService<UserManager<EMT_WebPortalUser>>();
            RoleManager<IdentityRole> roleManager = services.GetRequiredService<RoleManager<IdentityRole>>();
            var context = services.GetRequiredService<EMT_WebPortalUserContext>();

            context.Database.EnsureCreated();

            if (roleManager.Roles.ToArray().Count() > 0) 
            {
                return;
            }

            var role1 = new IdentityRole();
            var role2 = new IdentityRole();
            var role3 = new IdentityRole();

            role1.Name = "CareGiver";
            role2.Name = "Administrator";
            role3.Name = "WebMaster";

            if (!await roleManager.RoleExistsAsync(role1.Name))
            {
                await roleManager.CreateAsync(role1);
            }
            if (!await roleManager.RoleExistsAsync(role2.Name))
            {
                await roleManager.CreateAsync(role2);
            }
            if (!await roleManager.RoleExistsAsync(role3.Name))
            {
                await roleManager.CreateAsync(role3);
            }

            context.SaveChanges();

            var user1 = new EMT_WebPortalUser { UserName = "caregiver@us.com", Email = "caregiver@us.com", EmailConfirmed = true, Name="John"};
            var user2 = new EMT_WebPortalUser { UserName = "admin@us.com", Email = "admin@us.com", EmailConfirmed = true, Name = "Jane" };
            var user3 = new EMT_WebPortalUser { UserName = "webmaster@us.com", Email = "webmaster@us.com", EmailConfirmed = true, Name = "Jim" };

            string password = "abcdefgh";
            await userManager.CreateAsync(user1, password);
            await userManager.CreateAsync(user2, password);
            await userManager.CreateAsync(user3, password);

            context.SaveChanges();

            await userManager.CreateAsync(user1, "CareGiver");
            await userManager.CreateAsync(user2, "Administrator");
            await userManager.CreateAsync(user3, "WebMaster");

            context.SaveChanges();
        }
    }
}
