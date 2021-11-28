/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the Charts model
 */
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace EMT_WebPortal.Models
{
    public class Chart
    {
        public int ID { get; set; }
        [Required]
        public string Name { get; set; }
        [NotEmptyArray(ErrorMessage = "Please select a photo to upload")]
        public byte[] Photo { get; set; }
        [Required]
        public bool IsQuickLink { get; set; }
        public string Protocol { get; set; }
    }

    public class NotEmptyArray : ValidationAttribute 
    {
        public override bool IsValid(object value)
        {
            var array = value as byte[];
            if(array != null) 
            {
                return array.Length > 0;
            }
            return false;
        }
    }
}
