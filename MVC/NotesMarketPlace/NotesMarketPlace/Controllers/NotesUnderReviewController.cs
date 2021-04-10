using Ionic.Zip;
using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class NotesUnderReviewController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("NotesUnderReview")]
        public ActionResult NotesUnderReview(string search, int? page, string sortby, string Seller)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategory = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<NoteTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(Seller))   //  All Books Under Review
            {
                var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
                var filtered_status = dbobj.NoteTable.Include(x => x.ReferenceDataTable).Where(x => x.ReferenceDataTable.StatusName.Contains(search));
                var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));

                filtered = filtered_title.Union(filtered_status).Union(filtered_category);
            }
            else
            {
                if (String.IsNullOrEmpty(search))   // Search is empty + Dropdown
                {
                    var filtered_seller = dbobj.NoteTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);
                    filtered = filtered_seller;
                }
                else    // Search + Dropdown
                {
                    var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
                    var filtered_status = dbobj.NoteTable.Include(x => x.ReferenceDataTable).Where(x => x.ReferenceDataTable.StatusName.Contains(search));
                    var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));
                    var filtered_seller = dbobj.NoteTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);

                    filtered = filtered_title.Union(filtered_status).Union(filtered_category).Union(filtered_seller);
                }
            }

            var entry = filtered.Where(x => x.Status == 2 || x.Status == 3 ).Include(x => x.ReferenceDataTable).ToList().AsQueryable();

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

            /*ViewBag.Seller = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());*/
            ViewBag.Seller = new SelectList(dbobj.NoteTable.Where(x => x.Status == 2 || x.Status == 3).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(entry.ToPagedList(page ?? 1, 5));
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("DownloadForAdmin")]
        public ActionResult DownloadForAdmin(int nid)
        {
            NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            using (ZipFile zip = new ZipFile())
            {
                zip.AddDirectory(Server.MapPath("~/Members/" + noteobj.UID + "/" + nid + "/" + "Attachment"));

                MemoryStream output = new MemoryStream();
                zip.Save(output);
                return File(output.ToArray(), "Attachment/zip", noteobj.Title + ".zip");
            }
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("UpdateStatus")]
        public ActionResult UpdateStatus(int nid, int Status, string Remarks)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            if(Status == 3)     // In Review
            {
                noteobj.Status = 3;
            }
            else if (Status == 4)     // Publish
            {
                noteobj.Status = 4;
            }
            else     // Reject
            {
                noteobj.RemarksByAdmin = Remarks;
                noteobj.Status = 5;
            }

            noteobj.ActionBy = obj.UID;
            noteobj.ModifiedDate = DateTime.Now;

            dbobj.Entry(noteobj).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return RedirectToAction("NotesUnderReview");
        }
    }
}