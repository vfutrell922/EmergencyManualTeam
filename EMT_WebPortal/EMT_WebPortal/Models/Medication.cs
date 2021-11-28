/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the Medications model
 */
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Newtonsoft.Json;


namespace EMT_WebPortal.Models
{
    public class Medication
    {
        [Key]
        public int ID { get; set; }
        [Required]
        
        public string Name { get; set; }
        [Required]
        
        public string Action { get; set; }
        [Required]
        
        public string Indication { get; set; }
        [Required]
        
        public string Contraindication { get; set; }
        [Required]
        
        public string Precaution { get; set; }
        [Required]
        
        public string AdverseEffects { get; set; }
        
        public string AdultDosage { get; set; }
     
        public string ChildDosage { get; set; }
        [JsonIgnore]
        public virtual ICollection<MedicationProtocol> Protocols {get; set;}
    }
}


