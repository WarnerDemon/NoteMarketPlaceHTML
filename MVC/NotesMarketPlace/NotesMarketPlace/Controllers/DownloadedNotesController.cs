using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class DownloadedNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("DownloadedNotes")]
        public ActionResult DownloadedNotes(string search, int? page, string sortby, string Note, string Seller, string Buyer)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<TransectionTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(Note) && String.IsNullOrEmpty(Seller) && String.IsNullOrEmpty(Buyer))   //  All Books Under Review
            {
                //  All Downloaded Books
                filtered = dbobj.TransectionTable.Where(x => x.IsDownloaded == true).ToList().AsQueryable();
            }
            else
            {
                if (String.IsNullOrEmpty(search))   // Search is empty + Dropdown
                {
                    var filtered_Note = dbobj.TransectionTable.Where(x => x.Title == Note);
                    var filtered_Seller = dbobj.TransectionTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);
                    var filtered_Buyer = dbobj.TransectionTable.Where(x => x.UserTable.FirstName + " " + x.UserTable.LastName == Buyer);

                    filtered = filtered_Note.Union(filtered_Seller).Union(filtered_Buyer).Where(x=>x.IsDownloaded == true);
                }
                else    // Search + Dropdown
                {
                    var filtered_title = dbobj.TransectionTable.Where(x => x.Title.Contains(search) || x.Category.Contains(search) || 
                    x.UserTable.FirstName.Contains(search) || x.UserTable1.FirstName.Contains(search));
                    var filtered_Note = dbobj.TransectionTable.Where(x => x.Title == Note);
                    var filtered_Seller = dbobj.TransectionTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);
                    var filtered_Buyer = dbobj.TransectionTable.Where(x => x.UserTable.FirstName + " " + x.UserTable.LastName == Buyer);

                    filtered = filtered_title.Union(filtered_Note).Union(filtered_Seller).Union(filtered_Buyer).Where(x => x.IsDownloaded == true);
                }
            }

            switch (sortby)
            {
                case "Date":
                    filtered = filtered.OrderBy(x => x.DownloadedDate);
                    break;
                case "Title":
                    filtered = filtered.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    filtered = filtered.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    filtered = filtered.OrderBy(x => x.Category);
                    break;
                case "Category Desc":
                    filtered = filtered.OrderByDescending(x => x.Category);
                    break;
                default:
                    filtered = filtered.OrderByDescending(x => x.DownloadedDate);
                    break;
            }

            ViewBag.Note = new SelectList(dbobj.TransectionTable.Where(x => x.IsDownloaded).Select(x => x.Title).Distinct().ToList());
            ViewBag.Seller = new SelectList(dbobj.TransectionTable.Where(x => x.IsDownloaded).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());
            ViewBag.Buyer = new SelectList(dbobj.TransectionTable.Where(x => x.IsDownloaded).Select(x => x.UserTable.FirstName + " " + x.UserTable.LastName).Distinct().ToList());

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(filtered.ToPagedList(page ?? 1, 5));
        }
    }
}