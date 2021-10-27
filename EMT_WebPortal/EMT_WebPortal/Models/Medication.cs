using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;


namespace EMT_WebPortal.Models
{
    public class Medication
    {
        [Key]
        public int ID { get; set; }
        [Required]
        //       [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Name { get; set; }
        [Required]
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Action { get; set; }
        [Required]
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Indication { get; set; }
        [Required]
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Contraindication { get; set; }
        [Required]
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string Precaution { get; set; }
        [Required]
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string AdverseEffects { get; set; }
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string AdultDosage { get; set; }
        //        [RegularExpression("^[\\s\\d\\w\"/,@$:;+().=#%*-]*", ErrorMessage = "Only standard characters allowed")]
        public string ChildDosage { get; set; }
        public virtual ICollection<Protocol> Protocols {get; set;}
    }
}


