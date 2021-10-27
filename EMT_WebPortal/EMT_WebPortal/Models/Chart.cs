using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class Chart
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public byte[] Photo { get; set; }
        public bool IsQuickLink { get; set; }
        public string Protocol { get; set; }
    }
}
