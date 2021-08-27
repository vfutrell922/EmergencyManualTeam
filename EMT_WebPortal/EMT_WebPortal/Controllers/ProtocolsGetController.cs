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
    public class ProtocolsGetController : Controller
    {
        private readonly EMTManualContext _context;

        public ProtocolsGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            var eMTManualContext = _context.Protocols.Include(p => p.Guideline);
            foreach line in 
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }
    }
}
