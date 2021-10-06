using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace EMT_WebPortal.Controllers
{
    public class WebMasterController : Controller
    {
        [Authorize(Roles = "WebMaster")]
        public IActionResult Main() 
        {
            return View();
        }

        [Authorize(Roles = "WebMaster")]
        public IActionResult AccountManager() 
        {
            return View();
        }
    }
}
