using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
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
    public class AdminController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin")]
        [Route("ManageAdmin")]
        public ActionResult ManageAdmin(string search, int? page, string sortby)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortFirstName = sortby == "FirstName" ? "FirstName Desc" : "FirstName";
            ViewBag.SortLastName = sortby == "LastName" ? "LastName Desc" : "LastName";
            ViewBag.SortEmail = sortby == "Email" ? "Email Desc" : "Email";

            System.Linq.IQueryable<NotesMarketPlace.Context.UserTable> filtered;

            if (String.IsNullOrEmpty(search))   //  All Members
            {
                //  All Members
                filtered = dbobj.UserTable.Where(x => x.IsActive == true || x.IsActive == false).ToList().AsQueryable();
            }
            else
            {
                filtered = dbobj.UserTable.Where(x => (x.FirstName.Contains(search) || x.LastName.Contains(search) ||
                x.Email.Contains(search) || (x.CreatedDate.Value.Day + "-" + x.CreatedDate.Value.Month + "-" + x.CreatedDate.Value.Year).Contains(search))).ToList().AsQueryable();
            }

            var entry = filtered.Where(x => x.RoleID == 2).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    entry = entry.OrderByDescending(x => x.CreatedDate);
                    break;
                case "FirstName":
                    entry = entry.OrderBy(x => x.FirstName);
                    break;
                case "FirstName Desc":
                    entry = entry.OrderByDescending(x => x.FirstName);
                    break;
                case "LastName":
                    entry = entry.OrderBy(x => x.LastName);
                    break;
                case "LastName Desc":
                    entry = entry.OrderByDescending(x => x.LastName);
                    break;
                case "Email":
                    entry = entry.OrderBy(x => x.Email);
                    break;
                case "Email Desc":
                    entry = entry.OrderByDescending(x => x.Email);
                    break;
                default:
                    entry = entry.OrderBy(x => x.CreatedDate);
                    break;
            }

            //Converting entry into Manage Administrator Model
            var maobj = new List<ManageAdministrator>();
            foreach (var item in entry)
            {
                maobj.Add(new ManageAdministrator()
                {
                    UID = item.UID,
                    FirstName = item.FirstName,
                    LastName = item.LastName,
                    Email = item.Email,
                    PhoneNumber = dbobj.AdminTable.Where(x => x.UID == item.UID).Select(x => x.PhoneNumber).FirstOrDefault(),
                    CreatedDate = item.CreatedDate,
                    IsActive = item.IsActive
                });;

            }

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(maobj.ToPagedList(page ?? 1, 5));
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin")]
        [Route("EditAdmin")]
        public ActionResult EditAdmin(int uid)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.UserTable adobj = dbobj.UserTable.Where(x=>x.UID == uid).FirstOrDefault();
            AdminTable admin_profile = dbobj.AdminTable.Where(x => x.UID == uid).FirstOrDefault();

            AddAdmin model = new AddAdmin();

            model.UID = adobj.UID;
            model.FirstName = adobj.FirstName;
            model.LastName = adobj.LastName;
            model.Email = adobj.Email;
            model.CountryCode = admin_profile.CountryCode;
            model.PhoneNumber = admin_profile.PhoneNumber;

            ViewBag.CountryCodelist = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin")]
        [Route("EditAdmin")]
        public ActionResult EditAdmin(Models.AddAdmin model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable superadmin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                Context.UserTable old_adobj = dbobj.UserTable.Where(x => x.UID == model.UID).FirstOrDefault();
                if(old_adobj.Email != model.Email)
                {
                    var isExist = IsEmailExist(model.Email);
                    if (isExist)
                    {
                        ModelState.AddModelError("Email", "Email already exist");
                        ViewBag.CountryCodelist = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
                        return View(model);
                    }
                }
                
                AdminTable old_admin_profile = dbobj.AdminTable.Where(x => x.UID == model.UID).FirstOrDefault();

                old_adobj.FirstName = model.FirstName;
                old_adobj.LastName = model.LastName;
                old_adobj.Email = model.Email;
                old_adobj.ModifiedDate = DateTime.Now;
                old_adobj.ModifiedBy = superadmin.UID;

                old_admin_profile.CountryCode = model.CountryCode;
                old_admin_profile.PhoneNumber = model.PhoneNumber;
                old_admin_profile.ModifiedDate = DateTime.Now;
                old_admin_profile.ModifiedBy = superadmin.UID;

                dbobj.Entry(old_adobj).State = System.Data.Entity.EntityState.Modified;
                dbobj.Entry(old_admin_profile).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                return RedirectToAction("ManageAdmin", "Admin");
            }
            return View();
        }

        [Authorize(Roles = "Super Admin")]
        [Route("UpdateAdminStatus")]
        public ActionResult UpdateAdminStatus(int uid,int status)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable superadmin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.UserTable obj = dbobj.UserTable.Where(x => x.UID == uid).FirstOrDefault();
            AdminTable adobj = dbobj.AdminTable.Where(x => x.UID == uid).FirstOrDefault();

            if (status == 0)    // Deactivate Admin
            {
                obj.IsActive = false;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = superadmin.UID;

                adobj.IsActive = false;
                adobj.ModifiedDate = DateTime.Now;
                adobj.ModifiedBy = superadmin.UID;
            }
            else    // Activate Admin
            {
                obj.IsActive = true;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = superadmin.UID;

                adobj.IsActive = true;
                adobj.ModifiedDate = DateTime.Now;
                adobj.ModifiedBy = superadmin.UID;
            }

            dbobj.Entry(obj).State = System.Data.Entity.EntityState.Modified;
            dbobj.Entry(adobj).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return RedirectToAction("ManageAdmin");
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AdminDashboard")]
        public ActionResult AdminDashboard(string search, int? page, string sortby, string Month)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<NoteTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(Month))   //  All Books
            {
                var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
                var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));

                filtered = filtered_title.Union(filtered_category);
            }
            else
            {
                if (String.IsNullOrEmpty(search))   // Search is empty + Dropdown
                {
                    var filtered_month = dbobj.NoteTable.Where(x => x.ModifiedDate.Value.Month + "-" + x.ModifiedDate.Value.Year == Month);
                    filtered = filtered_month;
                }
                else    // Search + Dropdown
                {
                    var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
                    var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));
                    var filtered_month = dbobj.NoteTable.Where(x => x.ModifiedDate.Value.Month + "-" + x.ModifiedDate.Value.Year == Month);

                    filtered = filtered_title.Union(filtered_category).Union(filtered_month);
                }
            }

            var entry = filtered.Where(x => x.Status == 4).Include(x => x.ReferenceDataTable).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    entry = entry.OrderByDescending(x => x.ModifiedDate);
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
                    entry = entry.OrderBy(x => x.ModifiedDate);
                    break;
            }

            //Converting entry into Admin Dashboard Model
            var adobj = new List<AdminDashboard>();
            foreach (var item in entry)
            {
                DirectoryInfo info = new DirectoryInfo(Server.MapPath("~/Members/" + item.UID + "/" + item.NID + "/" + "Attachment"));
                long totalSize = info.EnumerateFiles().Sum(file => file.Length);    // Bytes
                totalSize = (long)totalSize / 1024;   // KB
                string file_size = totalSize + " KB";
                if (totalSize >= 1024)
                {
                    totalSize = (long)totalSize / 1024; // MB
                    file_size = totalSize + " MB";
                }
                adobj.Add(new AdminDashboard()
                {
                    NID = item.NID,
                    Title = item.Title,
                    Category = item.CategoryTable.Name,
                    FileSize = file_size,
                    SellType = item.IsPaid == true ? "Paid" : "Free",
                    Price = item.Price,
                    Publisher = dbobj.UserTable.Where(x=>x.UID == item.ActionBy).Select(x=>x.FirstName + " " + x.LastName).FirstOrDefault(),
                    PublishedDate = item.ModifiedDate,
                    TotalDownloads = dbobj.TransectionTable.Where(x=>x.NID == item.NID && x.IsDownloaded == true).Count()
                });

            }
            List<SelectListItem> MonthList = new List<SelectListItem>();

            for (int i=0;i<=5;i++)
            {
                var previousDate = DateTime.Now.AddMonths(-i);
                MonthList.Add(new SelectListItem()
                {
                    Text = previousDate.Date.ToString("MMMM") + " " + previousDate.Year.ToString(),
                    Value = previousDate.Month.ToString() + "-" + previousDate.Year.ToString()
                });
            }

            ViewBag.Month = MonthList;
            ViewBag.InReview = dbobj.NoteTable.Where(x => x.Status == 3).Count();
            var seven_day_before = DateTime.Now.AddDays(-7);
            ViewBag.NotesDownloaded = dbobj.TransectionTable.Where(x => x.IsDownloaded && (x.DownloadedDate >= seven_day_before)).Count();
            ViewBag.NewRegistrations = dbobj.UserTable.Where(x => x.RoleID == 3 && (x.CreatedDate >= seven_day_before)).Count();

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(adobj.ToPagedList(page ?? 1, 5));
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AdminNoteDetails")]
        public ActionResult AdminNoteDetails(int nid)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.NoteTable Note = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            // Code for Customer Review

            var reviews = dbobj.ReviewTable.Where(x => x.NID == nid);
            var ReviewsList = new List<DisplayReview>();

            foreach (var item in reviews)
            {
                var ReviewByUser = dbobj.UserProfileTable.Where(x => x.UID == item.ReviewBy).FirstOrDefault();
                ReviewsList.Add(new DisplayReview()
                {
                    ReviewID = item.ID,
                    ReviewBy = ReviewByUser.UserTable.FirstName,
                    UserImage = ReviewByUser.ProfilePicture,
                    Stars = item.Rating * 20,
                    Comment = item.Comments
                });
            }
            // ==================================================
            ViewBag.Reviews = ReviewsList;
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            ViewBag.Reviews = ReviewsList.OrderByDescending(x => x.Stars);
            return View(Note);
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("DeleteReview")]
        public ActionResult DeleteReview(int ReviewID, string ReturnUrl)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var review = dbobj.ReviewTable.Where(x => x.ID == ReviewID).FirstOrDefault();
            int nid = review.NID;

            dbobj.ReviewTable.Remove(review);
            dbobj.SaveChanges();

            var book = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            int total_reviews = dbobj.ReviewTable.Where(x => x.NID == nid).Count();

            if(total_reviews == 0)
            {
                book.TotalReviews = 0;
                book.Rating = 0;
            }
            else
            {
                int total_stars = dbobj.ReviewTable.Where(x => x.NID == nid).Select(x => x.Rating).Sum();

                book.TotalReviews = total_reviews;
                book.Rating = (total_stars / total_reviews) * 20;
            }

            dbobj.Entry(book).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return Redirect(ReturnUrl);
        }

        [NonAction]
        public bool IsEmailExist(string emailID)
        {
            using (NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities())
            {
                var v = dbobj.UserTable.Where(a => a.Email == emailID).FirstOrDefault();
                return v != null;
            }
        }

    }
}