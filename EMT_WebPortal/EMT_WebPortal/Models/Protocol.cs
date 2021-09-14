using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace EMT_WebPortal.Models
{
    public class Protocol
    {
        public int ID { get; set; }
        [MaxLength(100, ErrorMessage = "Protocol name must be less than 30 characters"), MinLength(1, ErrorMessage = "Please enter a name")]
        public string Name { get; set; }
        [MaxLength(4)]
        public string Certification { get; set; }
        [Range(1,3)]
        public int PatientType { get; set; }
        public bool HasAssociatedMedication { get; set; }
        public List<Medication> Medications { get; set; }
        public Chart Chart { get; set; }
        public string OtherInformation { get; set; }
        public string TreatmentPlan { get; set; }

        public int GuidelineId { get; set; }
        public Guideline Guideline { get; set; }
        public bool OLMCRequired { get; set; }
    }
}
