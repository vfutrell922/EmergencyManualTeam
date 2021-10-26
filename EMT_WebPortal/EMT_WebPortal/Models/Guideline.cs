using Microsoft.AspNetCore.Mvc.TagHelpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class Guideline
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Background { get; set; }
        public string Checklist { get; set; }
        public List<Protocol> Protocols { get; set; }
    }
}
