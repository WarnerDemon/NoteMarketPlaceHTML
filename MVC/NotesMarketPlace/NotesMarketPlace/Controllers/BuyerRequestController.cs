using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using PagedList;
using PagedList.Mvc;
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
    [Authorize(Roles = "User")]
    public class BuyerRequestController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("BuyerRequest")]
        public ActionResult BuyerRequest(string search, int? page, string sortby)
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

            //Fetching current users notes
            var entry = filtered.Where(x => x.SellerID == obj.UID && x.IsAllowed == false).ToList().AsQueryable();

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
                    entry = entry.OrderBy(x => x.Category);
                    break;
                case "Category Desc":
                    entry = entry.OrderByDescending(x => x.Category);
                    break;
                default:
                    entry = entry.OrderBy(x => x.CreatedDate);
                    break;
            }

            //Converting entry into Buyer Request Model
            var brobj = new List<BuyerRequest>();
            foreach(var item in entry)
            {
                var buyer = dbobj.UserProfileTable.Where(x => x.UID == item.BuyerID).FirstOrDefault();
                brobj.Add(new BuyerRequest()
                {
                    TID = item.TID,
                    NID = item.NID,
                    Title = item.Title,
                    Category = item.Category,
                    BuyerEmail = item.UserTable.Email,
                    BuyerContact = buyer.PhoneNumber,
                    IsPaid = item.NoteTable.IsPaid,
                    Price = item.Price,
                    DownloadedDate = item.CreatedDate
                });

            }
            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(brobj.ToList().AsQueryable().ToPagedList(page ?? 1, 10));   //Stay on Page 1, Total 10 Entry
        }

        public ActionResult AllowDownload(int tid)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            TransectionTable deal = dbobj.TransectionTable.Where(x => x.TID == tid).FirstOrDefault();
            deal.IsAllowed = true;

            dbobj.Entry(deal).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();
            NotifyBuyer(deal.UserTable.Email, deal.UserTable.FirstName, obj.FirstName);

            return RedirectToAction("BuyerRequest");
        }

        [Authorize]
        public void NotifyBuyer(string emailID, string Buyre, string Seller)
        {
            var fromEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().SupportEmail);
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = dbobj.SystemConfigurationTable.FirstOrDefault().Password; // Replace with actual password
            string subject = Seller + " Allows you to download a note";

            string body = "Hello " + Buyre + "," +
                "<br/><br/>We would like to inform you that, " + Seller + " Allows you to download a note." +
                "Please login and see My Download tabs to download particular note." +
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