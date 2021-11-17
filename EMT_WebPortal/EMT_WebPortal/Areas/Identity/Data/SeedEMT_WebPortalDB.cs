/*
 * Author: Vincent Futrell
 * Date Last Modified: 06/03/2021
 * This file contains the method to seed the user database upon initial launch of the application
 */
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

            if (context.Users.Any()) 
            {
                return;
            }

            roleManager.CreateAsync(new IdentityRole("CareGiver")).Wait();
            roleManager.CreateAsync(new IdentityRole("Administrator")).Wait();
            roleManager.CreateAsync(new IdentityRole("Director")).Wait();

            var user1 = new EMT_WebPortalUser { UserName = "caregiver", Email = "caregiver@mwaprotocol.com.com", EmailConfirmed = true, };
            var user2 = new EMT_WebPortalUser { UserName = "admin", Email = "admin@mwaprotocol.com", EmailConfirmed = true};
            var user3 = new EMT_WebPortalUser { UserName = "director", Email = "director@mwaprotocol.com", EmailConfirmed = true};

            string password = "Abcdefgh!2";
            userManager.CreateAsync(user1, password).Wait();
            userManager.CreateAsync(user2, password).Wait();
            userManager.CreateAsync(user3, password).Wait();

            userManager.AddToRoleAsync(user1, "CareGiver").Wait();
            userManager.AddToRoleAsync(user2, "Administrator").Wait();
            userManager.AddToRoleAsync(user3, "Director").Wait();
        }
    }
}
