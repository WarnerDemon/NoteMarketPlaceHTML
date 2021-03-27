using NotesMarketPlace.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class ContactUsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("ContactUs")]
        public ActionResult ContactUs()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();
            if (obj != null)
            {
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            }
            return View();
        }

        [HttpPost]
        [Route("ContactUs")]
        public ActionResult ContactUs(Models.ContactUs model)
        {
            if (ModelState.IsValid)
            {
                ContactUsTable obj = new ContactUsTable();
                obj.FullName = model.FullName;
                obj.Email = model.Email;
                obj.Subject = model.Subject;
                obj.Comments = model.Comments;

                dbobj.ContactUsTable.Add(obj);
                dbobj.SaveChanges();
                SendEmailToAdmin(obj);
            }
            ModelState.Clear();
            return RedirectToAction("ContactUs");
        }

        [NonAction]
        public void SendEmailToAdmin(ContactUsTable obj)
        {
            var fromEmail = new MailAddress("thehamojha@gmail.com"); //Email of Company
            var toEmail = new MailAddress("gohilyagnik3@gmail.com"); //Email of admin
            var fromEmailPassword = "*********"; // Replace with actual password
            string subject = obj.FullName + " - Query";

            string body = "Hello," +
                "<br/><br/>" + obj.Comments +
                "<br/><br/>Regards, " + obj.FullName;

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