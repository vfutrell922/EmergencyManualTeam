using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EMT_WebPortal.Data;
using EMT_WebPortal.Models;
using Microsoft.AspNetCore.Authorization;
using System.Web;

namespace EMT_WebPortal.Controllers
{
    public class Medications_ProtocolsController : Controller
    {
        public readonly EMTManualContext _context;

        public Medications_ProtocolsController(EMTManualContext context) 
        {
            _context = context;
        }

    }
}
