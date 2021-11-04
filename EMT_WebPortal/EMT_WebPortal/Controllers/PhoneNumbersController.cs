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
    public class PhoneNumbersController : Controller
    {
        private readonly EMTManualContext _context;

        public PhoneNumbersController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: PhoneNumbers
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Index(string search)
        {
            var numbers = from n in _context.PhoneNumbers select n;

            if (!String.IsNullOrEmpty(search))
            {
                numbers = numbers.Where(x => x.hospitalName.Contains(search));
            }

            return View(await numbers.ToListAsync());
        }

        // GET: PhoneNumbers/Details/5
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var phoneNumber = await _context.PhoneNumbers
                .FirstOrDefaultAsync(m => m.Id == id);
            if (phoneNumber == null)
            {
                return NotFound();
            }

            return View(phoneNumber);
        }

        // GET: PhoneNumbers/Create
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: PhoneNumbers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,hospitalName,numberString")] PhoneNumber phoneNumber)
        {
            if (ModelState.IsValid)
            {
                _context.Add(phoneNumber);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(phoneNumber);
        }

        // GET: PhoneNumbers/Edit/5
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var phoneNumber = await _context.PhoneNumbers.FindAsync(id);
            if (phoneNumber == null)
            {
                return NotFound();
            }
            return View(phoneNumber);
        }

        // POST: PhoneNumbers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,hospitalName,numberString")] PhoneNumber phoneNumber)
        {
            if (id != phoneNumber.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(phoneNumber);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PhoneNumberExists(phoneNumber.Id))
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
            return View(phoneNumber);
        }

        // GET: PhoneNumbers/Delete/5
        public async Task<IActionResult> Delete(int id)
        {

            var phoneNumber = await _context.PhoneNumbers
                .FirstOrDefaultAsync(m => m.Id == id);
            if (phoneNumber == null)
            {
                return NotFound();
            }

            return await DeleteConfirmed(id);
        }

        // POST: PhoneNumbers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var phoneNumber = await _context.PhoneNumbers.FindAsync(id);
            _context.PhoneNumbers.Remove(phoneNumber);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PhoneNumberExists(int id)
        {
            return _context.PhoneNumbers.Any(e => e.Id == id);
        }
    }
}
