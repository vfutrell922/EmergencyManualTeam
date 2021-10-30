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
    public class ChartToSend
    {   
        public ChartToSend(int _ID, string _Name, int[] _Photo, bool _IsQuickLink, string _Protocol) {
            ID = _ID;
            Name = _Name;
            Photo = _Photo;
            IsQuickLink = _IsQuickLink;
            Protocol = _Protocol;
        }
        public int ID { get; set; }

        [Required]
        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Name { get; set; }
        public int[] Photo { get; set; }
        public bool IsQuickLink { get; set; }
        public string Protocol { get; set; }
    }
}
