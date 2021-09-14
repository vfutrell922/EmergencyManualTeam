using EMT_WebPortal.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Data
{
    public class EMTManualContext : DbContext
    {
        public EMTManualContext(DbContextOptions<EMTManualContext> options) : base(options) { }

        public DbSet<Chart> Charts { get; set; }
        public DbSet<Guideline> Guidelines { get; set; }
        public DbSet<Medication> Medications { get; set; }
        public DbSet<Protocol> Protocols { get; set; }
        public DbSet<User> Users { get; set; }

 
        protected override void OnModelCreating(ModelBuilder modelBuilder) 
        {
            modelBuilder.Entity<Chart>().ToTable("Chart");
            modelBuilder.Entity<Guideline>().ToTable("Guideline");
            modelBuilder.Entity<Medication>().ToTable("Medication");
            modelBuilder.Entity<Protocol>().ToTable("Protocol");
            modelBuilder.Entity<User>().ToTable("User");
        }

 
        public DbSet<EMT_WebPortal.Models.PhoneNumber> PhoneNumber { get; set; }
    }
}
