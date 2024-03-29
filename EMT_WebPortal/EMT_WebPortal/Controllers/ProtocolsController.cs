﻿/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the controller class for the Protocols pages
 */
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
    public class ProtocolsController : Controller
    {
        private readonly EMTManualContext _context;

        public ProtocolsController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: Protocols
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Index(string search)
        {
            var protocols = from p in _context.Protocols select p;

            if (!String.IsNullOrEmpty(search))
            {
                protocols = protocols.Where(x => x.Name.Contains(search));
            }

            return View(await protocols.ToListAsync());
        }

        // GET: Protocols/Details/5
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var protocol = await _context.Protocols
                .FirstOrDefaultAsync(m => m.Id == id);
            if (protocol == null)
            {
                return NotFound();
            }

            return View(protocol);
        }

        // GET: Protocols/Create
        [Authorize(Roles = "Administrator,Director")]
        public IActionResult Create()
        {
            ViewData["GuidelineNames"] = new SelectList(_context.Guidelines, "Name", "Name");
            ViewData["MedicationsList"] = new MultiSelectList(_context.Medications, "ID", "Name");
            return View();
        }

        // POST: Protocols/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Name,Certification,PatientType,HasAssociatedMedication,OtherInformation,TreatmentPlan,Guideline,OLMCRequired")] Protocol protocol, List<int> MedicationsIdList)
        {
            if (ModelState.IsValid)
            {
                _context.Add(protocol);
                await _context.SaveChangesAsync();

                if (protocol.HasAssociatedMedication)
                {
                    foreach (int i in MedicationsIdList)
                    {
                        MedicationProtocol mp = new MedicationProtocol()
                        {
                            MedicationId = i,
                            ProtocolId = protocol.Id,
                            Protocol = protocol,
                            Medication = _context.Medications.Where(x => x.ID == i).FirstOrDefault()
                        };
                        _context.Medications_Protocols.Add(mp);
                    }
                    _context.SaveChanges();
                }
               // await _context.Database.ExecuteSqlRawAsync("SET IDENTITY_INSERT dbo.Medications_Protocols OFF;");
                return RedirectToAction(nameof(Index));
            }
            var errors = ModelState
                .Where(x => x.Value.Errors.Count > 0)
                .Select(x => new { x.Key, x.Value.Errors })
                .ToArray();
            ViewBag.MedicationsList = new MultiSelectList(_context.Medications, "ID", "Name", protocol.Medications);
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Name", "Name", protocol.Guideline);
            return View(protocol);
        }

        // GET: Protocols/Edit/5
        [Authorize(Roles = "Administrator,Director")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var protocol = await _context.Protocols.FindAsync(id);
            if (protocol == null)
            {
                return NotFound();
            }

            //Get the Id's of associated medications
            var medication_ids = _context.Medications_Protocols.Where(x => x.ProtocolId == id);
            int[] id_array = new int[medication_ids.Count()];
            int x = 0;
            foreach(MedicationProtocol mp in medication_ids)
            {
                id_array[x] = mp.MedicationId;
                x++;
            }
            ViewBag.MedicationIds = id_array;
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Name", "Name", protocol.Guideline);
            return View(protocol);
        }

        // POST: Protocols/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Name,Certification,PatientType,HasAssociatedMedication,OtherInformation,TreatmentPlan,Guideline,OLMCRequired")] Protocol protocol, List<int> MedicationsIdList)
        {
            if (id != protocol.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(protocol);
                    UpdateMedications(id, MedicationsIdList, protocol);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ProtocolExists(protocol.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Name", "Name", protocol.Guideline);
            return View(protocol);
        }


        /// <summary>
        /// Removes the old medication relations in the db and add the new
        /// </summary>
        /// <param name="id"></param>
        /// <param name="medicationIds"></param>
        /// <param name="protocol"></param>
        private void UpdateMedications(int id, List<int> medicationIds, Protocol protocol)
        {
            var old_ids = _context.Medications_Protocols.Where(x => x.ProtocolId == id);
            foreach(MedicationProtocol mp in old_ids)
            {
                _context.Medications_Protocols.Remove(mp);
            }
            _context.SaveChangesAsync().Wait();

            if (protocol.HasAssociatedMedication)
            {
                foreach (int i in medicationIds)
                {
                    MedicationProtocol mp = new MedicationProtocol();
                    mp.MedicationId = i;
                    mp.ProtocolId = id;
                    mp.Protocol = protocol;
                    mp.Medication = _context.Medications.Where(x => x.ID == i).FirstOrDefault();
                    _context.Medications_Protocols.Add(mp);
                }
                _context.SaveChangesAsync().Wait();
            }
        }

        // GET: Protocols/Delete/5
        [Authorize(Roles = "Administrator,Director")]
        public async Task<IActionResult> Delete(int id)
        {
            if (id == null)
            {
                return NotFound();
            }

            return await DeleteConfirmed(id);
        }

        // POST: Protocols/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            //Delete the Protocol
            var protocol = await _context.Protocols.FindAsync(id);
            _context.Protocols.Remove(protocol);
            await _context.SaveChangesAsync();

            //Delete links the protocol had to any medications
            var mps = _context.Medications_Protocols.Where(x => x.ProtocolId == id);
            foreach(MedicationProtocol mp in mps) 
            {
                _context.Medications_Protocols.Remove(mp);
            }
            _context.SaveChanges();
            return RedirectToAction(nameof(Index));
        }

        private bool ProtocolExists(int id)
        {
            return _context.Protocols.Any(e => e.Id == id);
        }

     
    }
}
