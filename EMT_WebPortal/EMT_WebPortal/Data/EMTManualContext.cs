/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the EMTManualContext class
 * This class builds the database using the model classes
 */
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
        public DbSet<PhoneNumber> PhoneNumbers { get; set; }
        public DbSet<MedicationProtocol> Medications_Protocols { get; set; }

 
        protected override void OnModelCreating(ModelBuilder modelBuilder) 
        {

            //This code explicitly tells EntityFramework how to map the weak attribute keys in the MedicationProtocol class
            modelBuilder.Entity<MedicationProtocol>().HasKey(mp => new { mp.MedicationId, mp.ProtocolId });

            modelBuilder.Entity<MedicationProtocol>()
                .HasOne(t => t.Protocol)
                .WithMany(t => t.Medications)
                .HasForeignKey(t => t.ProtocolId);

            modelBuilder.Entity<MedicationProtocol>()
                .HasOne(t => t.Medication)
                .WithMany(t => t.Protocols)
                .HasForeignKey(t => t.MedicationId);
        }
    }
}
