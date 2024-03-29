﻿/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the controller class for the Medications pages
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

namespace EMT_WebPortal.Controllers
{
    public class MedicationsController : Controller
    {
        private readonly EMTManualContext _context;

        public MedicationsController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: Medications
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Index(string search)
        {
            var medications = from m in _context.Medications select m;

            if (!String.IsNullOrEmpty(search)) 
            {
                medications = medications.Where(x => x.Name.Contains(search));
            }

            return View(await medications.ToListAsync());
        }

        // GET: Medications/Details/5
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var medication = await _context.Medications
                .FirstOrDefaultAsync(m => m.ID == id);
            if (medication == null)
            {
                return NotFound();
            }

            return View(medication);
        }

        // GET: Medications/Create
        [Authorize(Roles = "Administrator,WebMaster")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Medications/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Action,Indication,Contraindication,Precaution,AdverseEffects,AdultDosage,ChildDosage")] Medication medication)
        {
            if (ModelState.IsValid)
            {
                _context.Add(medication);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(medication);
        }

        // GET: Medications/Edit/5
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var medication = await _context.Medications.FindAsync(id);
            if (medication == null)
            {
                return NotFound();
            }
            return View(medication);
        }

        // POST: Medications/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Action,Indication,Contraindication,Precaution,AdverseEffects,AdultDosage,ChildDosage")] Medication medication)
        {
            if (id != medication.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(medication);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MedicationExists(medication.ID))
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
            return View(medication);
        }

        // GET: Medications/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Delete(int id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var medication = await _context.Medications
                .FirstOrDefaultAsync(m => m.ID == id);
            if (medication == null)
            {
                return NotFound();
            }

            return await DeleteConfirmed(id);
        }

        // POST: Medications/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var medication = await _context.Medications.FindAsync(id);
            _context.Medications.Remove(medication);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MedicationExists(int id)
        {
            return _context.Medications.Any(e => e.ID == id);
        }
    }
}
