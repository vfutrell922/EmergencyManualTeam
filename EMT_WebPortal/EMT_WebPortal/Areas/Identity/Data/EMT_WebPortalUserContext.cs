/*
 * Author: Vincent Futrell
 * Date Last Modified: 04/26/2021
 * This file defines the user DB context
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EMT_WebPortal.Areas.Identity.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace EMT_WebPortal.Data
{
    public class EMT_WebPortalUserContext : IdentityDbContext<EMT_WebPortalUser>
    {
        public EMT_WebPortalUserContext(DbContextOptions<EMT_WebPortalUserContext> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
        }
    }
}
