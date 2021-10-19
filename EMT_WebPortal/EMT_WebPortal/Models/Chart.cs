using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Name { get; set; }
        public byte[] Photo { get; set; }
        public bool IsQuickLink { get; set; }
    }
}
