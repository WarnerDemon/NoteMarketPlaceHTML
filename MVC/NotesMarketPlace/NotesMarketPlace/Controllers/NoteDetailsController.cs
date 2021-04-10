using Ionic.Zip;
using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class NoteDetailsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("NoteDetails")]
        public ActionResult NoteDetails(int nid)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.NoteTable Note = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            if (obj != null)
            {
                Context.TransectionTable deal = dbobj.TransectionTable.Where(x => x.NID == nid && x.BuyerID == obj.UID).FirstOrDefault();
                ViewBag.CurrentUserID = obj.UID;
                ViewBag.CurrentUserName = obj.FirstName;
                if (deal != null) { ViewBag.IsDealAvailable = deal.IsAllowed; }

                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            }

            // Code for Customer Review

            var reviews = dbobj.ReviewTable.Where(x => x.NID == nid);
            var ReviewsList = new List<DisplayReview>();

            foreach (var item in reviews)
            {
                var ReviewByUser = dbobj.UserProfileTable.Where(x => x.UID == item.ReviewBy).FirstOrDefault();
                ReviewsList.Add(new DisplayReview()
                {
                    ReviewBy = ReviewByUser.UserTable.FirstName,
                    UserImage = ReviewByUser.ProfilePicture,
                    Stars = item.Rating*20,
                    Comment = item.Comments
                });
            }
            // ==================================================
            ViewBag.Reviews = ReviewsList.OrderByDescending(x=>x.Stars);
            return View(Note);
        }

        [Authorize(Roles = "User")]
        [Route("Download")]
        public ActionResult Download(int nid)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == nid).FirstOrDefault();

            Context.UserTable sellerobj = dbobj.UserTable.Where(x => x.UID == noteobj.UID).FirstOrDefault();

            TransectionTable deal = dbobj.TransectionTable.Where(x => x.NID == nid && x.BuyerID == obj.UID).FirstOrDefault();

            if (obj.UID == noteobj.UID)     // Users own book
            {
                using (ZipFile zip = new ZipFile())
                {
                    zip.AddDirectory(Server.MapPath("~/Members/" + noteobj.UID + "/" + nid + "/" + "Attachment"));

                    MemoryStream output = new MemoryStream();
                    zip.Save(output);
                    return File(output.ToArray(), "Attachment/zip", noteobj.Title + ".zip");
                }
            }
            else
            {
                if (deal == null)   // New Transection
                {
                    if (noteobj.IsPaid == false)    // Download Free Notes
                    {
                        TransectionTable tobj = new TransectionTable();
                        tobj.NID = nid;
                        tobj.Title = noteobj.Title;
                        tobj.Category = noteobj.CategoryTable.Name;
                        tobj.IsPaid = false;
                        tobj.Price = noteobj.Price;
                        tobj.BuyerID = obj.UID;
                        tobj.SellerID = noteobj.UID;
                        tobj.IsAllowed = true;
                        tobj.IsDownloaded = true;
                        tobj.DownloadedDate = DateTime.Now;
                        tobj.Status = noteobj.ReferenceDataTable.StatusName;
                        tobj.CreatedDate = DateTime.Now;

                        dbobj.TransectionTable.Add(tobj);
                        dbobj.SaveChanges();

                        using (ZipFile zip = new ZipFile())
                        {
                            zip.AddDirectory(Server.MapPath("~/Members/" + noteobj.UID + "/" + nid + "/" + "Attachment"));

                            MemoryStream output = new MemoryStream();
                            zip.Save(output);
                            return File(output.ToArray(), "Attachment/zip", noteobj.Title + ".zip");
                        }

                    }
                    else    // Download Paid Notes
                    {
                        TransectionTable tobj = new TransectionTable();
                        tobj.NID = nid;
                        tobj.Title = noteobj.Title;
                        tobj.Category = noteobj.CategoryTable.Name;
                        tobj.IsPaid = true;
                        tobj.Price = noteobj.Price;
                        tobj.BuyerID = obj.UID;
                        tobj.SellerID = noteobj.UID;
                        tobj.IsAllowed = false;
                        tobj.IsDownloaded = false;
                        tobj.DownloadedDate = null;
                        tobj.Status = noteobj.ReferenceDataTable.StatusName;
                        tobj.CreatedDate = DateTime.Now;

                        dbobj.TransectionTable.Add(tobj);
                        dbobj.SaveChanges();
                        NotifySeller(sellerobj.Email, obj.FirstName, sellerobj.FirstName);
                        //return RedirectToAction("NoteDetails", new { nid });
                        ViewBag.CurrentUserName = obj.FirstName;
                        return PartialView("ThanksPopup", noteobj);
                    }
                }
                else   // Old Transection Available
                {
                    if (noteobj.IsPaid == false)    // Download Free Notes
                    {
                        using (ZipFile zip = new ZipFile())
                        {
                            zip.AddDirectory(Server.MapPath("~/Members/" + noteobj.UID + "/" + nid + "/" + "Attachment"));

                            MemoryStream output = new MemoryStream();
                            zip.Save(output);
                            return File(output.ToArray(), "Attachment/zip", noteobj.Title + ".zip");
                        }

                    }
                    else    // Download Paid Notes
                    {
                        if (deal.IsAllowed)
                        {
                            deal.IsDownloaded = true;
                            deal.DownloadedDate = DateTime.Now;

                            dbobj.Entry(deal).State = System.Data.Entity.EntityState.Modified;
                            dbobj.SaveChanges();

                            using (ZipFile zip = new ZipFile())
                            {
                                zip.AddDirectory(Server.MapPath("~/Members/" + noteobj.UID + "/" + nid + "/" + "Attachment"));

                                MemoryStream output = new MemoryStream();
                                zip.Save(output);
                                return File(output.ToArray(), "Attachment/zip", noteobj.Title + ".zip");
                            }
                        }
                        else
                        {
                            return RedirectToAction("NoteDetails", nid);
                        }
                        
                    }
                }
            }
        }

        [Authorize]
        public void NotifySeller(string emailID, string Buyre, string Seller)
        {
            var fromEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().SupportEmail);
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = dbobj.SystemConfigurationTable.FirstOrDefault().Password; // Replace with actual password
            string subject = Buyre + " wants to purchase your notes";

            string body = "Hello "+ Seller + "," +
                "<br/><br/>We would like to inform you that, "+ Buyre + " wants to purchase your notes. Please see " +
                "Buyer Requests tab and allow download access to Buyer if you have received the payment from him." +
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