using Microsoft.AspNetCore.Authentication.Cookies;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class User
    {
        public int ID { get; set; }
        [RegularExpression("[a-zA-Z]*", ErrorMessage = "Only alphanumeric characters may be used")]
        public string Name { get; set; }
        public bool Admin { get; set; }
        [RegularExpression("[a-zA-Z0-9 ]*", ErrorMessage = "Only alphanumeric characters may be used")]
        public string Certification { get; set; }
    }
}
