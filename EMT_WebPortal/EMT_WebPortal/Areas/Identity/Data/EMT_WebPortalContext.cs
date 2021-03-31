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
    public class EMT_WebPortalContext : IdentityDbContext<EMT_WebPortalUser>
    {
        public EMT_WebPortalContext(DbContextOptions<EMT_WebPortalContext> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // Customize the ASP.NET Identity model and override the defaults if needed.
            // For example, you can rename the ASP.NET Identity table names and more.
            // Add your customizations after calling base.OnModelCreating(builder);
        }
    }
}
