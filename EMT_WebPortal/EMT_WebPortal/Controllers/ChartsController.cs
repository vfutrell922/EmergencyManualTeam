using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EMT_WebPortal.Data;
using EMT_WebPortal.Models;
using System.Web;
using Microsoft.AspNetCore.Http;
using System.IO;
using Microsoft.AspNetCore.Authorization;

namespace EMT_WebPortal.Controllers
{
    public class ChartsController : Controller
    {
        private readonly EMTManualContext _context;

        public ChartsController(EMTManualContext context)
        {
            _context = context;
        }

        // GET: Charts
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Charts.ToListAsync());
        }

        // GET: Charts/Details/5
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chart = await _context.Charts
                .FirstOrDefaultAsync(m => m.ID == id);
            if (chart == null)
            {
                return NotFound();
            }

            return View(chart);
        }

        // GET: Charts/Create
        [Authorize(Roles = "CareGiver,Administrator,Director")]
        public IActionResult Create()
        {
            PopulateProtocolsList();
            return View();
        }

        //Adds a list 
        private void PopulateProtocolsList()
        {
            var protocols = _context.Protocols.ToArray();
            HashSet<string> names = new HashSet<string>();
            foreach(Protocol p in protocols) 
            {
                names.Add(p.Name);
            }
            names.Add("None");
            SelectList sl = new SelectList(names);
            ViewBag.ProtocolNames = sl;
        }

        // POST: Charts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(string Name, IFormFile file, bool IsQuickLink, string Protocol)
        {
            Chart chart = new Chart();
            if(file != null && file.Length > 0)
            {
                using (var memoryStream = new MemoryStream()) 
                {
                    await file.CopyToAsync(memoryStream);
                    chart.Name = Name;
                    chart.IsQuickLink = IsQuickLink;
                    chart.Photo = memoryStream.ToArray();
                    chart.Protocol = Protocol;
                }

                    _context.Add(chart);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                
            }
            return View(chart);
        }

        // GET: Charts/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chart = await _context.Charts.FindAsync(id);
            if (chart == null)
            {
                return NotFound();
            }
            return View(chart);
        }

        // POST: Charts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Photo,IsQuickLink")] Chart chart)
        {
            if (id != chart.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(chart);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ChartExists(chart.ID))
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
            return View(chart);
        }

        // GET: Charts/Delete/5
        public async Task<IActionResult> Delete(int id)
        {

            var chart = await _context.Charts
                .FirstOrDefaultAsync(m => m.ID == id);
            if (chart == null)
            {
                return NotFound();
            }

            return await DeleteConfirmed(id);
        }

        // POST: Charts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chart = await _context.Charts.FindAsync(id);
            _context.Charts.Remove(chart);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ChartExists(int id)
        {
            return _context.Charts.Any(e => e.ID == id);
        }
    }
}
