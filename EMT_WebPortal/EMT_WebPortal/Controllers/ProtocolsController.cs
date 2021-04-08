﻿using System;
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
    public class ProtocolsController : Controller
    {
        private readonly EMTManualContext _context;

        public ProtocolsController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: Protocols
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Index()
        {
            var eMTManualContext = _context.Protocols.Include(p => p.Guideline);
            return View(await eMTManualContext.ToListAsync());
        }

        // GET: Protocols/Details/5
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var protocol = await _context.Protocols
                .Include(p => p.Guideline)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (protocol == null)
            {
                return NotFound();
            }

            return View(protocol);
        }

        // GET: Protocols/Create
        [Authorize(Roles = "Administrator,WebMaster")]
        public IActionResult Create()
        {
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Id", "Id");
            return View();
        }

        // POST: Protocols/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Certification,PatientType,HasAssociatedMedication,OtherInformation,TreatmentPlan,GuidelineId")] Protocol protocol)
        {
            if (ModelState.IsValid)
            {
                _context.Add(protocol);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Id", "Id", protocol.GuidelineId);
            return View(protocol);
        }

        // GET: Protocols/Edit/5
        [Authorize(Roles = "Administrator,WebMaster")]
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
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Id", "Id", protocol.GuidelineId);
            return View(protocol);
        }

        // POST: Protocols/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Certification,PatientType,HasAssociatedMedication,OtherInformation,TreatmentPlan,GuidelineId")] Protocol protocol)
        {
            if (id != protocol.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(protocol);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ProtocolExists(protocol.ID))
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
            ViewData["GuidelineId"] = new SelectList(_context.Guidelines, "Id", "Id", protocol.GuidelineId);
            return View(protocol);
        }

        // GET: Protocols/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var protocol = await _context.Protocols
                .Include(p => p.Guideline)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (protocol == null)
            {
                return NotFound();
            }

            return View(protocol);
        }

        // POST: Protocols/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var protocol = await _context.Protocols.FindAsync(id);
            _context.Protocols.Remove(protocol);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ProtocolExists(int id)
        {
            return _context.Protocols.Any(e => e.ID == id);
        }
    }
}