﻿/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the Protocols model
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
    public class Protocol
    {
        public int Id { get; set; }
        [Required]
        [MaxLength(100, ErrorMessage = "Protocol name must be less than 30 characters"), MinLength(1, ErrorMessage = "Please enter a name")]
        public string Name { get; set; }
        [Required]
        public Certifications Certification { get; set; }
        [Required]
        public PatientTypes PatientType { get; set; }
        [Required]
        public bool HasAssociatedMedication { get; set; }
        [JsonIgnore]
        public List<MedicationProtocol> Medications { get; set; }
        public string OtherInformation { get; set; }
        public string TreatmentPlan { get; set; }
        [Required]
        public string Guideline { get; set; }
        [Required]
        public bool OLMCRequired { get; set; }
    }

  

    public enum Certifications
    {
        EMT,
        AEMT,
        PARAMEDIC,
        ALL
    };

    public enum PatientTypes
    {
        ADULT,
        PEDIATRIC,
        ALL
    };
}
