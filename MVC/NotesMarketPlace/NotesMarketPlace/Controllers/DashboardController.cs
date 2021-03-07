using NotesMarketPlace.Context;
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
    public class DashboardController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("Dashboard")]
        public ActionResult Dashboard(string search, int? page, string sortby)
        {
            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
            var filtered_status = dbobj.NoteTable.Include(x => x.ReferenceDataTable).Where(x=>x.ReferenceDataTable.StatusName.Contains(search));
            var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));

            var filtered = filtered_title.Union(filtered_status).Union(filtered_category);

            var entry = filtered.Where(x => x.UID == obj.UID && (x.Status == 1 || x.Status == 2 || x.Status == 3)).Include(x => x.ReferenceDataTable).ToList().AsQueryable();

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

            return View(entry.ToPagedList(page ?? 1, 5));
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