using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class Log
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RunNum { get; set; }
        [RegularExpression("[a-zA-Z0-9 ]*", ErrorMessage = "Only alphanumeric characters may be used")]
        public string Provider { get; set; }
        public int UnitNum { get; set; }
        [RegularExpression("[a-zA-Z0-9 ]*", ErrorMessage = "Only alphanumeric characters may be used")]
        public string TeamLead { get; set; }
        [RegularExpression("[a-zA-Z0-9 ]*", ErrorMessage = "Only alphanumeric characters may be used")]
        public string SpecialCases { get; set; }
    }
}
