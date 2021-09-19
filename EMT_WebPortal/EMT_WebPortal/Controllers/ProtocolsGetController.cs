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
    public class ProtocolsGetController : Controller
    {
        private readonly EMTManualContext _context;

        public ProtocolsGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public string Get()
        {
            int protocolCount = _context.Protocols.Count();
            Protocol[] allProtocols = new Protocol[protocolCount];
            int x = 0;

            foreach(Protocol p in _context.Protocols) 
            {
                allProtocols[x] = p;
                x++;
            }

            return JsonConvert.SerializeObject(allProtocols);
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int? id)
        {

            if (id == null)
            {
                return "404 ID Cannot be null" ;
            }

            Protocol p = _context.Protocols.Find(id);

            if (p == null)
            {
                return "404 No such protocol linked to this ID";
            }

            return JsonConvert.SerializeObject(p);
        }
    }
}
