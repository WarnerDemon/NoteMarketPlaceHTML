using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;
using System.IO;

namespace NotesMarketPlace.Controllers
{
    [Authorize]
    [Authorize(Roles = "User")]
    public class DashboardController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("Dashboard")]
        public ActionResult Dashboard(string search, string search2, int? page, int? page2, string sortby, string sortby2)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var upobj = dbobj.UserProfileTable.Where(a => a.UID == obj.UID).FirstOrDefault();
            if (upobj == null)
            {
                return RedirectToAction("UserProfile", "UserProfile");
            }

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategory = sortby == "Category" ? "Category Desc" : "Category";

            ViewBag.SortDate2 = string.IsNullOrEmpty(sortby2) ? "Date Desc" : "";
            ViewBag.SortTitle2 = sortby2 == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategory2 = sortby2 == "Category" ? "Category Desc" : "Category";

            Dashboard Dashboard = new Dashboard();

            var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
            var filtered_status = dbobj.NoteTable.Include(x => x.ReferenceDataTable).Where(x=>x.ReferenceDataTable.StatusName.Contains(search));
            var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));

            var filtered = filtered_title.Union(filtered_status).Union(filtered_category);

            var entry = filtered.Where(x => x.UID == obj.UID && (x.Status == 1 || x.Status == 2 || x.Status == 3 )).Include(x => x.ReferenceDataTable).ToList().AsQueryable();

            var filtered_title2 = dbobj.NoteTable.Where(x => x.Title.Contains(search2) || search2 == null);
            var filtered_status2 = dbobj.NoteTable.Include(x => x.ReferenceDataTable).Where(x => x.ReferenceDataTable.StatusName.Contains(search2));
            var filtered_category2 = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search2));

            var filtered2 = filtered_title2.Union(filtered_status2).Union(filtered_category2);

            var entry2 = filtered2.Where(x => x.UID == obj.UID && ( x.Status == 4)).Include(x => x.ReferenceDataTable).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    entry = entry.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Title":
                    entry = entry.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    entry = entry.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    entry = entry.OrderBy(x => x.CategoryTable.Name);
                    break;
                case "Category Desc":
                    entry = entry.OrderByDescending(x => x.CategoryTable.Name);
                    break;
                default:
                    entry = entry.OrderBy(x => x.CreatedDate);
                    break;
            }

            switch (sortby2)
            {
                case "Date Desc":
                    entry2 = entry2.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Title":
                    entry2 = entry2.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    entry2 = entry2.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    entry2 = entry2.OrderBy(x => x.CategoryTable.Name);
                    break;
                case "Category Desc":
                    entry2 = entry2.OrderByDescending(x => x.CategoryTable.Name);
                    break;
                default:
                    entry2 = entry2.OrderBy(x => x.CreatedDate);
                    break;
            }

            Dashboard.Progress = entry.ToPagedList(page ?? 1, 5);
            Dashboard.Published = entry2.ToPagedList(page2 ?? 1, 5);

            ViewBag.SoldNotes = dbobj.TransectionTable.Where(x => x.SellerID == obj.UID && x.IsAllowed == true).Count();
            if (ViewBag.SoldNotes == 0)
            {
                ViewBag.Earning = 0;
            }
            else
            {
                ViewBag.Earning = dbobj.TransectionTable.Where(x => x.SellerID == obj.UID && x.IsAllowed == true).Select(x => x.Price).Sum();
            }
            ViewBag.DownloadNotes = dbobj.TransectionTable.Where(x => x.BuyerID == obj.UID && x.IsDownloaded == true).Count();
            ViewBag.RejectedNotes = dbobj.NoteTable.Where(x => x.UID == obj.UID && x.Status == 5).Count();
            ViewBag.BuyerRequests = dbobj.TransectionTable.Where(x => x.SellerID == obj.UID && x.IsAllowed == false).Count();

            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x=>x.ProfilePicture).FirstOrDefault();
            return View(Dashboard);
        }

        public ActionResult DeleteBook(int noteid)
        {

            Context.NotesAttachmentTable attachment = dbobj.NotesAttachmentTable.Where(x => x.NID == noteid).FirstOrDefault();
            Context.NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == noteid).FirstOrDefault();

            string mappedPath = Server.MapPath("/Members/" + noteobj.UID + "/" + noteid);
            Directory.Delete(mappedPath, true);

            dbobj.NotesAttachmentTable.Remove(attachment);
            dbobj.NoteTable.Remove(noteobj);
            dbobj.SaveChanges();

            return RedirectToAction("Dashboard");
        }

    }
}