/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the class declaration for the PhoneNumbers model
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Models
{
    public class PhoneNumber
    {
        public int Id { get; set; }
        public string hospitalName { get; set; }
        public string numberString { get; set; }
    }
}
