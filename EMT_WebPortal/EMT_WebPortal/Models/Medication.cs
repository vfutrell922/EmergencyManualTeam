using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class Medication
    {
        [Key]
        public int ID { get; set; }
        public string Name { get; set; }
        public string Action { get; set; }
        public string Indication { get; set; }
        public string Contradiction { get; set; }
        public string Precaution { get; set; }
        public string AdverseEffects {get; set;}
        public string AdultDosage { get; set; }
        public string ChildDosage { get; set; }
    }
}
