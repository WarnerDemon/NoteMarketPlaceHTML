using NotesMarketPlace.Context;
using PagedList;
using PagedList.Mvc;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class SearchNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("SearchNotes")]
        public ActionResult SearchNotes(string search, string TypeID, string CategoryID, string InstituteName, string CourseName, string CountryID, string Rating, int? page)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var upobj = dbobj.UserProfileTable.Where(a => a.UID == obj.UID).FirstOrDefault();
            if (upobj == null)
            {
                return RedirectToAction("UserProfile", "UserProfile");
            }

            System.Linq.IQueryable<NoteTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(TypeID) && String.IsNullOrEmpty(CategoryID) 
                && String.IsNullOrEmpty(InstituteName) && String.IsNullOrEmpty(CourseName) && String.IsNullOrEmpty(CountryID) && String.IsNullOrEmpty(Rating))
            {
                //  All Books
                filtered = dbobj.NoteTable.Where(x => x.Status == 4 && x.IsActive == true).ToList().AsQueryable();
            }
            else
            {
                if (String.IsNullOrEmpty(search))   // Search is empty + Dropdown
                {
                    var filtered_type = dbobj.NoteTable.Where(x => x.TypeID.ToString() == TypeID);
                    var filtered_category = dbobj.NoteTable.Where(x => x.CategoryID.ToString() == CategoryID);
                    var filtered_institute = dbobj.NoteTable.Where(x => x.InstituteName == InstituteName);
                    var filtered_course = dbobj.NoteTable.Where(x => x.CourseName == CourseName);
                    var filtered_country = dbobj.NoteTable.Where(x => x.CountryID.ToString() == CountryID);

                    var IntRating = Rating == "" ? 6 : Int32.Parse(Rating);
                    var filtered_rating = dbobj.NoteTable.Where(x => x.Rating >= IntRating*20);

                    filtered = filtered_type.Union(filtered_category).Union(filtered_institute).Union(filtered_course).Union(filtered_country).Union(filtered_rating).Where(x => x.Status == 4 && x.IsActive == true).ToList().AsQueryable();
                }
                else    // Search + Dropdown
                {
                    var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || x.TypeTable.Name.Contains(search) || x.CategoryTable.Name.Contains(search) || 
                        x.InstituteName.Contains(search) || x.CourseName.Contains(search) || x.CountryTable.CountryName.Contains(search));
                    var filtered_type = dbobj.NoteTable.Where(x => x.TypeID.ToString() == TypeID);
                    var filtered_category = dbobj.NoteTable.Where(x => x.CategoryID.ToString() == CategoryID);
                    var filtered_institute = dbobj.NoteTable.Where(x => x.InstituteName == InstituteName);
                    var filtered_course = dbobj.NoteTable.Where(x => x.CourseName == CourseName);
                    var filtered_country = dbobj.NoteTable.Where(x => x.CountryID.ToString() == CountryID);

                    var IntRating = Rating == "" ? 6 : Int32.Parse(Rating);
                    var filtered_rating = dbobj.NoteTable.Where(x => x.Rating >= IntRating * 20);

                    filtered = filtered_title.Union(filtered_type).Union(filtered_category).Union(filtered_institute).Union(filtered_course).Union(filtered_country).Union(filtered_rating).Where(x => x.Status == 4 && x.IsActive == true).ToList().AsQueryable();
                }
                
            }

            ViewBag.TotalBooks = filtered.Count();

            if (obj != null)
            {
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            }

            ViewBag.Type = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.TypeTable).Distinct().ToList(), "TypeID", "Name");
            ViewBag.Category = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.CategoryTable).Distinct().ToList(), "CategoryID", "Name");
            ViewBag.Univercity = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.InstituteName).Distinct().ToList());
            ViewBag.Course = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.CourseName).Distinct().ToList());
            ViewBag.Country = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.CountryTable).Distinct().ToList(), "CountryID", "CountryName");

            return View(filtered.ToPagedList(page ?? 1, 9));
        }
    }
}