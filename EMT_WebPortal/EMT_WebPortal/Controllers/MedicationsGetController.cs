using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using EMT_WebPortal.Models;
using EMT_WebPortal.Data;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EMT_WebPortal.Controllers
{
    [Route("api/[controller]")]
    public class MedicationsGetController : Controller
    {
        private readonly EMTManualContext _context;

        public MedicationsGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public string Get()
        {
            Medication[] allMedications = new Medication[_context.Medications.Count()];
            int x = 0;

            foreach (Medication p in _context.Medications)
            {
                allMedications[x] = p;
                x++;
            }

            return JsonConvert.SerializeObject(allMedications);
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int? id)
        {

            if (id == null)
            {
                return "404 ID Cannot be null";
            }

            Medication p = _context.Medications.Find(id);

            if (p == null)
            {
                return "404 No such Medication linked to this ID";
            }

            return JsonConvert.SerializeObject(p);
        }

        /// <summary>
        /// Returns a list of medications. If alphabetize is true, the list will be in alphabetical order.
        /// If the optional search string is provided, all medications whose name contain the string will
        /// be returned.
        /// </summary>
        /// <param name="alphabetize"></param>
        /// <param name="search_string"></param>
        /// <returns></returns>
        [HttpGet("getmultiselect/{alphabetize}/{search_string?}")]
        public string GetMultiselect(string alphabetize, string search_string = null)
        {
            string return_values;
            

            if (search_string != null)
            {
                var query = from m in _context.Medications where m.Name.Contains(search_string) select m;
                Medication[] allMedications = new Medication[query.Count()];
                if (alphabetize == "true")
                {
                    query = query.OrderBy(x => x.Name);
                }

                int x = 0;
                foreach(Medication m in query) 
                {
                    allMedications[x] = m;
                    x++;
                }

                return_values = JsonConvert.SerializeObject(allMedications);
            }

            else
            {
                var query = from m in _context.Medications select m;
                Medication[] allMedications = new Medication[query.Count()];

                if (alphabetize == "true")
                {
                    query = query.OrderBy(x => x.Name);
                }

                int x = 0;

                foreach (Medication m in query)
                {
                    allMedications[x] = m;
                    x++;
                }

                return_values = JsonConvert.SerializeObject(allMedications);
            }

            return return_values;
        }
    }
}
