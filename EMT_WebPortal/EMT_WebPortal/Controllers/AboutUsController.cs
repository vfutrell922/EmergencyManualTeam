/*
 * Author: Vincent Futrell
 * Date Last Modified: 09/13/2021
 * This file contains the controller class for the AboutUs page 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace EMT_WebPortal.Controllers
{
    public class AboutUsController : Controller
    {
        public IActionResult AboutUs()
        {
            return View();
        }
    }
}