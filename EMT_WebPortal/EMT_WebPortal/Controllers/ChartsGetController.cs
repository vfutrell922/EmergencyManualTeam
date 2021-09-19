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
    public class ChartsGetController : Controller
    {
        private readonly EMTManualContext _context;

        public ChartsGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public string Get()
        {
            int chartCount = _context.Charts.Count();
            Chart[] allCharts = new Chart[chartCount];
            int x = 0;

            foreach(Chart c in _context.Charts)
            {
                allCharts[x] = c;
                x++;
            }

            return JsonConvert.SerializeObject(allCharts);
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int? id)
        {
            return "Not Implemented";
        }
    }
}
