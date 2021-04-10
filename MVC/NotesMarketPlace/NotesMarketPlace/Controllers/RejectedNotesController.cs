using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class RejectedNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("RejectedNotes")]
        public ActionResult RejectedNotes(string search, int? page, string sortby, string Seller)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<NoteTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(Seller))   //  All Rejected Books
            {
                //  All Rejected Books
                filtered = dbobj.NoteTable.Where(x => x.Status == 5).ToList().AsQueryable();
            }
            else
            {
                if (String.IsNullOrEmpty(search))   // Search is empty + Dropdown
                {
                    var filtered_Seller = dbobj.NoteTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);

                    filtered = filtered_Seller.Where(x => x.Status == 5);
                }
                else    // Search + Dropdown
                {
                    var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || x.CategoryTable.Name.Contains(search) || 
                        x.UserTable1.FirstName.Contains(search) || x.UserTable1.LastName.Contains(search) || 
                        x.UserTable2.FirstName.Contains(search) || x.UserTable2.LastName.Contains(search));
                    var filtered_Seller = dbobj.NoteTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);

                    filtered = filtered_title.Union(filtered_Seller).Where(x => x.Status == 5);
                }
            }

            switch (sortby)
            {
                case "Date Desc":
                    filtered = filtered.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Title":
                    filtered = filtered.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    filtered = filtered.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    filtered = filtered.OrderBy(x => x.CategoryTable.Name);
                    break;
                case "Category Desc":
                    filtered = filtered.OrderByDescending(x => x.CategoryTable.Name);
                    break;
                default:
                    filtered = filtered.OrderBy(x => x.ModifiedDate);
                    break;
            }

            ViewBag.Seller = new SelectList(dbobj.TransectionTable.Where(x => x.IsDownloaded).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(filtered.ToPagedList(page ?? 1, 5));
        }
    }
}