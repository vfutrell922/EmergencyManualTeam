/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the MedicationProtocols model
 * This class is a weak entity to track the many-to-many relationship between medications and protocols
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.Mvc;

namespace EMT_WebPortal.Models
{
    public class MedicationProtocol
    {
        [Key]
        public int Id { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MedicationId { get; set; }
        public Medication Medication { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProtocolId { get; set; }
        public Protocol Protocol { get; set; }
    }
}
