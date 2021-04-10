using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class PublishedNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("PublishedNotes")]
        public ActionResult PublishedNotes(string search, int? page, string sortby, string Seller)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            System.Linq.IQueryable<NoteTable> filtered;     //Empty Variable for Holding Notes

            if (String.IsNullOrEmpty(search) && String.IsNullOrEmpty(Seller))   //  All Books
            {
                var filtered_title = dbobj.NoteTable.Where(x => x.Title.Contains(search) || search == null);
                var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));

                filtered = filtered_title.Union(filtered_category);
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
                    var filtered_category = dbobj.NoteTable.Include(x => x.CategoryTable).Where(x => x.CategoryTable.Name.Contains(search));
                    var filtered_seller = dbobj.NoteTable.Where(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName == Seller);

                    filtered = filtered_title.Union(filtered_category).Union(filtered_seller);
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

            //Converting entry into Published Notes Model
            var pnobj = new List<PublishedNotes>();
            foreach (var item in entry)
            {
                pnobj.Add(new PublishedNotes()
                {
                    NID = item.NID,
                    UID = item.UID,
                    Title = item.Title,
                    Category = item.CategoryTable.Name,
                    SellType = item.IsPaid == true ? "Paid" : "Free",
                    Price = item.Price,
                    Seller = item.UserTable1.FirstName + " " + item.UserTable1.LastName,
                    PublishedDate = item.ModifiedDate,
                    ApprovedBy = dbobj.UserTable.Where(x => x.UID == item.ActionBy).Select(x => x.FirstName + " " + x.LastName).FirstOrDefault(),
                    TotalDownloads = dbobj.TransectionTable.Where(x => x.NID == item.NID && x.IsDownloaded == true).Count()
                });

            }

            /*ViewBag.Seller = new SelectList(dbobj.NoteTable.Where(x => x.IsActive).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());*/
            ViewBag.Seller = new SelectList(dbobj.NoteTable.Where(x => x.IsActive && x.Status == 4).Select(x => x.UserTable1.FirstName + " " + x.UserTable1.LastName).Distinct().ToList());

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(pnobj.ToPagedList(page ?? 1, 5));
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("Unpublish")]
        public ActionResult Unpublish(int nid, string Remarks, string ReturnUrl)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();
            Context.UserTable sellerobj = dbobj.UserTable.Where(x => x.UID == noteobj.UID).FirstOrDefault();

            noteobj.Status = 6;
            noteobj.IsActive = false;
            noteobj.RemarksByAdmin = Remarks;
            
            noteobj.ActionBy = obj.UID;
            noteobj.ModifiedDate = DateTime.Now;

            dbobj.Entry(noteobj).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();
            NotifySeller(sellerobj.Email, sellerobj.FirstName, noteobj.Title, Remarks);

            return Redirect(ReturnUrl);
            /*return View();*/
        }

        [Authorize]
        public void NotifySeller(string emailID, string Seller, string Title, string Remarks)
        {
            var fromEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().SupportEmail);
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = dbobj.SystemConfigurationTable.FirstOrDefault().Password; // Replace with actual password
            string subject = "Sorry! We need to remove your notes from our portal.";

            string body = "Hello " + Seller + "," +
                "<br/><br/>We want to inform you that, your note " + Title + " has been removed from the portal." +
                "<br/>Please find our remarks as below -" +
                "<br/>"+ Remarks +
                "<br/><br/>Regards,<br/>Notes Marketplace";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromEmail.Address, fromEmailPassword)
            };

            using (var message = new MailMessage(fromEmail, toEmail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
            smtp.Send(message);
        }
    }
}