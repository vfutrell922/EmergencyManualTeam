/*
 * Author: Vincent Futrell
 * Date Last Modified: 10/05/2021
 * This file defines the message sender options class which consists of the SendGrid API Key
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Areas.Identity.Services
{
    public class AuthMessageSenderOptions
    {
        public string SendGridKey { get; set; }
    }
}
