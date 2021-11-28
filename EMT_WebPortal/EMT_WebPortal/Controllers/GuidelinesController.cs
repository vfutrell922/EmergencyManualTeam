/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/27/2021
 * This file contains the controller class for the Guidelines pages
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
    public class GuidelinesController : Controller
    {
        private readonly EMTManualContext _context;

        public GuidelinesController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: Guidelines
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Index(string search)
        {
            var guidelines = from c in _context.Guidelines select c;

            if (!String.IsNullOrEmpty(search))
            {
                guidelines = guidelines.Where(x => x.Name.Contains(search));
            }

            return View(await guidelines.ToListAsync());
        }

        // GET: Guidelines/Details/5
        [Authorize(Roles = "CareGiver,Administrator,WebMaster")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var guideline = await _context.Guidelines
                .FirstOrDefaultAsync(m => m.Id == id);
            if (guideline == null)
            {
                return NotFound();
            }

            return View(guideline);
        }

        // GET: Guidelines/Create
        [Authorize(Roles = "Administrator,WebMaster")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Guidelines/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Create([Bind("Id,Name,Background,Checklist")] Guideline guideline)
        {
            if (ModelState.IsValid)
            {
                _context.Add(guideline);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(guideline);
        }

        // GET: Guidelines/Edit/5
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var guideline = await _context.Guidelines.FindAsync(id);
            if (guideline == null)
            {
                return NotFound();
            }
            return View(guideline);
        }

        // POST: Guidelines/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Name,Background,Checklist")] Guideline guideline)
        {
            if (id != guideline.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(guideline);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!GuidelineExists(guideline.Id))
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
            return View(guideline);
        }

        // GET: Guidelines/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        public async Task<IActionResult> Delete(int id)
        {

            var guideline = await _context.Guidelines
                .FirstOrDefaultAsync(m => m.Id == id);
            if (guideline == null)
            {
                return NotFound();
            }

            return await DeleteConfirmed(id);
        }

        // POST: Guidelines/Delete/5
        [Authorize(Roles = "Administrator,WebMaster")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var guideline = await _context.Guidelines.FindAsync(id);
            _context.Guidelines.Remove(guideline);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool GuidelineExists(int id)
        {
            return _context.Guidelines.Any(e => e.Id == id);
        }
    }
}
