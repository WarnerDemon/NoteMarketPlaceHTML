using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    [Authorize]
    public class MyDownloadsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Authorize]
        [Route("MyDownloads")]
        public ActionResult MyDownloads(string search, int? page, string sortby)
        {
            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var filtered_title = dbobj.TransectionTable.Where(x => x.Title.Contains(search) || search == null);
            var filtered_category = dbobj.TransectionTable.Where(x => x.Category.Contains(search));

            var filtered = filtered_title.Union(filtered_category);

            var entry = filtered.Where(x => x.BuyerID == obj.UID && x.IsAllowed == true).ToList().AsQueryable();

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

        public ActionResult AddReview(int nid, int rate, string Comments)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var oldreview = dbobj.ReviewTable.Where(x => x.NID == nid && x.ReviewBy == obj.UID).FirstOrDefault();

            if(oldreview == null)   //New Review
            {
                ReviewTable review = new ReviewTable();

                review.NID = nid;
                review.ReviewBy = obj.UID;
                review.Rating = rate;
                review.Comments = Comments;
                review.CreatedDate = DateTime.Now;

                dbobj.ReviewTable.Add(review);
                dbobj.SaveChanges();

                // Adding Ratings in note table

                var book = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

                int total_reviews = dbobj.ReviewTable.Where(x => x.NID == nid).Count();
                int total_stars = dbobj.ReviewTable.Where(x => x.NID == nid).Select(x => x.Rating).Sum();

                book.TotalReviews = total_reviews;
                book.Rating = (total_stars / total_reviews) * 20;

                dbobj.Entry(book).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                // ------------------------------------------------------------

                return RedirectToAction("MyDownloads");
            }
            else   //Update Review
            {
                oldreview.Rating = rate;
                oldreview.Comments = Comments;

                dbobj.Entry(oldreview).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                // Adding Ratings in note table

                var book = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

                int total_reviews = dbobj.ReviewTable.Where(x => x.NID == nid).Count();
                int total_stars = dbobj.ReviewTable.Where(x => x.NID == nid).Select(x => x.Rating).Sum();

                book.TotalReviews = total_reviews;
                book.Rating = ((double)total_stars / total_reviews) * 20;

                dbobj.Entry(book).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                // ------------------------------------------------------------

                return RedirectToAction("MyDownloads");
            }
            
        }

        public ActionResult SpamReport(int nid,string SpamComments)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var oldspam = dbobj.SpamTable.Where(x => x.NID == nid && x.SpamBy == obj.UID).FirstOrDefault();

            var book = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            Context.UserTable sellerobj = dbobj.UserTable.Where(x => x.UID == book.UID).FirstOrDefault();

            if (oldspam == null)    //New Spam
            {
                SpamTable spam = new SpamTable();
                spam.NID = nid;
                spam.SpamBy = obj.UID;
                spam.Comments = SpamComments;
                spam.CreatedDate = DateTime.Now;

                dbobj.SpamTable.Add(spam);
                dbobj.SaveChanges();

                // Adding Ratings in note table

                int total_spams = dbobj.SpamTable.Where(x => x.NID == nid).Count();

                book.TotalSpams = total_spams;

                dbobj.Entry(book).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                // ------------------------------------------------------------

                NotifyAdmin(obj.FirstName,book.Title,sellerobj.FirstName);

                return RedirectToAction("MyDownloads");
            }
            else    //Update Old Spam
            {
                oldspam.Comments = SpamComments;

                dbobj.Entry(oldspam).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                NotifyAdmin(obj.FirstName, book.Title, sellerobj.FirstName);

                return RedirectToAction("MyDownloads");
            }
            
        }

        public void NotifyAdmin(string ReportedBy, string NoteTitle, string SellerName)
        {
            var fromEmail = new MailAddress("thehamojha@gmail.com");//Support Email Address
            var toEmail = new MailAddress("gohilyagnik3@gmail.com");
            var fromEmailPassword = "*********"; // Replace with actual password
            string subject = ReportedBy + " Reported an issue for " + NoteTitle;

            string body = "Hello Admins, " +
                "<br/><br/>We want to inform you that, "+ ReportedBy + " Reported an issue for "+
                SellerName + "’s Note with title "+ NoteTitle +". Please look at the notes and take required actions." +
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