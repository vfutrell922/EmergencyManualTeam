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
        [Required]
        [MaxLength(100, ErrorMessage = "Protocol name must be less than 30 characters"), MinLength(1, ErrorMessage = "Please enter a name")]
        public string Name { get; set; }
        [Required]
        [MaxLength(4)]
        public Certifications Certification { get; set; }
        [Required]
        [Range(1,3)]
        public PatientTypes PatientType { get; set; }
        [Required]
        public bool HasAssociatedMedication { get; set; }
        public List<Medication> Medications { get; set; }
        public Chart Chart { get; set; }
        public string OtherInformation { get; set; }
        public string TreatmentPlan { get; set; }
        [Required]
        public int GuidelineId { get; set; }
        [Required]
        public Guideline Guideline { get; set; }
        [Required]
        public bool OLMCRequired { get; set; }
    }

    public enum Certifications
    {
        ALL,
        EMT,
        AEMT, 
        PARAMEDIC,
    };

    public enum PatientTypes
    {
        ALL,
        ADULT,
        PEDIATRIC
    };

    //TODO add an enum for guideline types

}
