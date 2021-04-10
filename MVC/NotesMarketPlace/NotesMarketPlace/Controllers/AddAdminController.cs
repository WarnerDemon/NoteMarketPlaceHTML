using NotesMarketPlace.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace NotesMarketPlace.Controllers
{
    public class AddAdminController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin")]
        [Route("AddAdmin")]
        public ActionResult AddAdmin()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.CountryCode = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin")]
        [Route("AddAdmin")]
        public ActionResult AddAdmin(Models.AddAdmin model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                var isExist = IsEmailExist(model.Email);
                if (isExist)
                {
                    ModelState.AddModelError("Email", "Email already exist");
                    ViewBag.CountryCode = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
                    return View(model);
                }

                UserTable obj = new UserTable();
                obj.RoleID = 2;
                obj.FirstName = model.FirstName;
                obj.LastName = model.LastName;
                obj.Email = model.Email;
                string pwd = Membership.GeneratePassword(6, 2);
                obj.Password = Crypto.Hash(pwd);
                obj.IsEmailVerified = true;
                obj.CreatedDate = DateTime.Now;
                obj.CreatedBy = admin.UID;
                obj.IsActive = true;

                AdminTable adobj = new AdminTable();
                adobj.UID = obj.UID;
                adobj.CountryCode = model.CountryCode;
                adobj.PhoneNumber = model.PhoneNumber;
                adobj.CreatedDate = DateTime.Now;
                adobj.CreatedBy = admin.UID;
                adobj.IsActive = true;

                dbobj.UserTable.Add(obj);
                dbobj.AdminTable.Add(adobj);
                dbobj.SaveChanges();

                SendPasswordToAdmin(model.Email, pwd);

                return RedirectToAction("ManageAdmin", "Admin");
            }
            return View();
        }

        [NonAction]
        public void SendPasswordToAdmin(string emailID, string pwd)
        {
            var fromEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().SupportEmail);
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = dbobj.SystemConfigurationTable.FirstOrDefault().Password; // Replace with actual password
            string subject = "Note Marketplace - You are Admin now.";

            string body = "Hello," +
                "<br/><br/>We have generated a new password for you" +
                "<br/><br/>Password: " + pwd +
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