using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class SpamReportsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("SpamReports")]
        public ActionResult SpamReports(string search, int? page, string sortby)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortReportedBy = sortby == "ReportedBy" ? "ReportedBy Desc" : "ReportedBy";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategory = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<NotesMarketPlace.Context.SpamTable> filtered;

            if (String.IsNullOrEmpty(search))   //  All Spam Reports
            {
                //  All Spam Reports
                filtered = dbobj.SpamTable.ToList().AsQueryable();
            }
            else
            {
                filtered = dbobj.SpamTable.Where(x => (x.NoteTable.Title.Contains(search) || x.NoteTable.Title.Contains(search) ||
                 x.NoteTable.CategoryTable.Name.Contains(search) ||
                (x.CreatedDate.Value.Day + "-" + x.CreatedDate.Value.Month + "-" + x.CreatedDate.Value.Year).Contains(search) ||
                (x.UserTable.FirstName + " " + x.UserTable.LastName).Contains(search))).ToList().AsQueryable();
            }

            switch (sortby)
            {
                case "Date Desc":
                    filtered = filtered.OrderByDescending(x => x.CreatedDate);
                    break;
                case "ReportedBy":
                    filtered = filtered.OrderBy(x => x.UserTable.FirstName);
                    break;
                case "ReportedBy Desc":
                    filtered = filtered.OrderByDescending(x => x.UserTable.FirstName);
                    break;
                case "Title":
                    filtered = filtered.OrderBy(x => x.NoteTable.Title);
                    break;
                case "Title Desc":
                    filtered = filtered.OrderByDescending(x => x.NoteTable.Title);
                    break;
                case "Category":
                    filtered = filtered.OrderBy(x => x.NoteTable.CategoryTable.Name);
                    break;
                case "TitCategoryle Desc":
                    filtered = filtered.OrderByDescending(x => x.NoteTable.CategoryTable.Name);
                    break;
                default:
                    filtered = filtered.OrderBy(x => x.CreatedDate);
                    break;
            }

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(filtered.ToPagedList(page ?? 1, 5));
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("DeleteSpamReports")]
        public ActionResult DeleteSpamReports(int sid)
        {
            SpamTable report = dbobj.SpamTable.Where(x => x.ID == sid).FirstOrDefault();

            dbobj.SpamTable.Remove(report);
            dbobj.SaveChanges();

            return RedirectToAction("SpamReports");
        }
    }
}