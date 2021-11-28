/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the controller class for the Protocols methods in the API
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
    public class ProtocolsGetController : Controller
    {
        private readonly EMTManualContext _context;

        public ProtocolsGetController(EMTManualContext context)
        {
            _context = context;
        }
        // GET: api/<controller>
        /// <summary>
        /// Returns an array of strings followed by an array of Protocol JSON objects. The values of the string
        /// array are the comma separated ids of the associated medications in the protocol array where (string[x] == "12,13,19" are the associated
        /// medication ids for protocols[x]
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public string Get()
        {
            int protocolCount = _context.Protocols.Count();
            Protocol[] allProtocols = new Protocol[protocolCount];
            string[] allMedications = new string[protocolCount];
            int x = 0;

            foreach (Protocol p in _context.Protocols)
            {
                allProtocols[x] = p;
                allMedications[x] = getMedicationIds(p.Id);
                x++;
            }

            string jsonProtocols = JsonConvert.SerializeObject(allProtocols);
            return JsonConvert.SerializeObject(allMedications) + jsonProtocols;
        }

        private string getMedicationIds(int pid)
        {
            string medIds = "{,";
            var query = _context.Medications_Protocols.Where(m => m.ProtocolId == pid);
            foreach (MedicationProtocol mp in query)
            {
                medIds += mp.MedicationId + ",";
            }
            medIds += "}";
            return medIds;
        }

        // GET api/<controller>/5
        /// <summary>
        /// Returns the medication whose id == id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        public string Get(int? id)
        {

            if (id == null)
            {
                return "404 ID Cannot be null";
            }

            Protocol p = _context.Protocols.Find(id);
            string medications = getMedicationIds(p.Id);

            if (p == null)
            {
                return "404 No such protocol linked to this ID";
            }

            string protocol = JsonConvert.SerializeObject(p);
            return JsonConvert.SerializeObject(medications) + protocol;
        }

        /// <summary>
        /// Returns a list of names of associated medications
        /// </summary>
        /// <returns></returns>
        [HttpGet("getmedicationnames/{id}")]
        public string getMedicationNames(int? id)
        {
            if(id == null)
            {
                return "404 Id Cannot be null";
            }

            Protocol protocol = _context.Protocols.Find(id);

            var query = from mp in _context.Medications_Protocols where (mp.Protocol.Equals(protocol)) select mp;
            List<MedicationProtocol> medications = query.ToList();
            string[] names = new string[medications.Count];

            int i = 0;
            foreach(MedicationProtocol mp in medications)
            {
                Medication medication = _context.Medications.Find(mp.MedicationId);
                if(medication != null)
                {
                    names[i] = medication.Name;
                    
                }
                else
                {
                    names[i] = "Error: This medication longer exists";
                }
                i++;
            }

            return JsonConvert.SerializeObject(names);
        }

        /// <summary>
        /// Returns a list of all unique protocol names
        /// </summary>
        /// <returns></returns>
        [HttpGet("getcardnames")]
        public string GetCardNames()
        {
            HashSet<string> names = new HashSet<string>();
            foreach(Protocol p in _context.Protocols)
            {
                names.Add(p.Name);
            }

            return JsonConvert.SerializeObject(names);
        }

    }
}
