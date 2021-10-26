﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EMT_WebPortal.Areas.Identity.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EMT_WebPortal.Controllers
{
    public class AccountManagerController : Controller
    {
        private UserManager<EMT_WebPortalUser> userManager;
        private RoleManager<IdentityRole> roleManager;

        public AccountManagerController(UserManager<EMT_WebPortalUser> _userManager, RoleManager<IdentityRole> _roleManager)
        {
            userManager = _userManager;
            roleManager = _roleManager;
        }

        // GET: /<controller>/
        [HttpPost]
        public async Task<IActionResult> roleChange([FromBody] RoleChange roleChange)
        {
            try
            {
                var check = roleChange.userName;
                var oneTwo = roleChange.role;
                var user = await userManager.FindByNameAsync(check);
                var inRole = await userManager.IsInRoleAsync(user, oneTwo);
                var returnData = await userManager.GetRolesAsync(user);
                // Check to see if they are already in the role, add them to the new role and remove them from their previous role
                if (inRole)
                {
                    var roleChanges = await userManager.RemoveFromRoleAsync(user, oneTwo);
                }
                else
                {
                    var oldRoleGet = await userManager.GetRolesAsync(user);
                    if (oldRoleGet.Any())
                    {
                        var oldRole = oldRoleGet[0];
                        var oldRoleRemove = await userManager.RemoveFromRoleAsync(user, oldRole);
                    }
                    var newRoleAdd = await userManager.AddToRoleAsync(user, oneTwo);

                }

                return Ok(returnData);
            }
            catch
            {
                return BadRequest();
            }
        }
    }
    public class RoleChange
    {
        public string userName { get; set; }
        public string role { get; set; }
    }
}

