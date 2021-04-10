using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    [Authorize(Roles = "User")]
    public class MySoldNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();
        [Route("MySoldNotes")]
        public ActionResult MySoldNotes(string search, int? page, string sortby)
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
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            var filtered_title = dbobj.TransectionTable.Where(x => x.Title.Contains(search) || search == null);
            var filtered_category = dbobj.TransectionTable.Where(x => x.Category.Contains(search));

            var filtered = filtered_title.Union(filtered_category);

            var entry = filtered.Where(x => x.SellerID == obj.UID && x.IsAllowed == true).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    entry = entry.OrderByDescending(x => x.DownloadedDate);
                    break;
                case "Title":
                    entry = entry.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    entry = entry.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    entry = entry.OrderBy(x => x.Category);
                    break;
                case "Category Desc":
                    entry = entry.OrderByDescending(x => x.Category);
                    break;
                default:
                    entry = entry.OrderBy(x => x.DownloadedDate);
                    break;
            }

            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(entry.ToPagedList(page ?? 1, 10));
        }
    }
}