﻿using System;
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
            string allMedications = "";

            foreach(Medication p in _context.Medications) 
            {
                allMedications += JsonConvert.SerializeObject(p);
            }

            return allMedications;
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int? id)
        {

            if (id == null)
            {
                return "404 ID Cannot be null" ;
            }

            Medication p = _context.Medications.Find(id);

            if (p == null)
            {
                return "404 No such Medication linked to this ID";
            }

            return JsonConvert.SerializeObject(p);
        }
    }
}