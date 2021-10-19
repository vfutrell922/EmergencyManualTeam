using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace EMT_WebPortal.Models
{
    public class PhoneNumber
    {
        public int Id { get; set; }
        [Required]
        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string hospitalName { get; set; }
        public string numberString { get; set; }
    }
}
