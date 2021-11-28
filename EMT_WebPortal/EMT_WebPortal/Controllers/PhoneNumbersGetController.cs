/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the controller class for the PhoneNumbers methods in the API
 */
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
    public class PhoneNumbersGetController : Controller
    {
        private readonly EMTManualContext _context;

        public PhoneNumbersGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        [HttpGet]
        public string Get()
        {
            int pnCount = _context.PhoneNumbers.Count();
            PhoneNumber[] allPhoneNumbers = new PhoneNumber[pnCount];
            int x = 0;

            foreach(PhoneNumber p in _context.PhoneNumbers) 
            {
                allPhoneNumbers[x] = p;
                x++;
            }

            return JsonConvert.SerializeObject(allPhoneNumbers);
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int? id)
        {

            if (id == null)
            {
                return "404 ID Cannot be null" ;
            }

            PhoneNumber p = _context.PhoneNumbers.Find(id);

            if (p == null)
            {
                return "404 No such PhoneNumber linked to this ID";
            }

            return JsonConvert.SerializeObject(p);
        }
    }
}
