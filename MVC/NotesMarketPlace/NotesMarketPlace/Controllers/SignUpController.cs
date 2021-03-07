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
    public class SignUpController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Route("SignUp")]
        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        [Route("SignUp")]
        public ActionResult SignUp(Models.UserTable model)
        {
            if (ModelState.IsValid)
            {
                var isExist = IsEmailExist(model.Email);
                if (isExist)
                {
                    ModelState.AddModelError("Email", "Email already exist");
                    return View(model);
                }

                UserTable obj = new UserTable();
                obj.RoleID = 3;
                obj.FirstName = model.FirstName;
                obj.LastName = model.LastName;
                obj.Email = model.Email;
                obj.Password = Crypto.Hash(model.Password);
                obj.IsEmailVerified = model.IsEmailVerified;
                obj.IsActive = true;
                obj.SecretCode = Guid.NewGuid();

                dbobj.UserTable.Add(obj);
                dbobj.SaveChanges();
                SendVerificationLinkEmail(model.Email, model.FirstName, obj.SecretCode.ToString());
                TempData["Success"] = "Your account has been successfully created.";

            }
            ModelState.Clear();

            return RedirectToAction("SignUp");
        }

        [Route("EmailVerification/{code}")]
        public ActionResult EmailVerification(string code)
        {
            UserTable obj = dbobj.UserTable.Where(x => x.SecretCode.ToString() == code).FirstOrDefault();
            ViewBag.name = obj.FirstName;
            return View(obj);
        }

        [Route("Verify/{code}")]
        public ActionResult Verify(string code)
        {
            UserTable obj = dbobj.UserTable.Where(x => x.SecretCode.ToString() == code).FirstOrDefault();
            obj.IsEmailVerified = true;
            dbobj.SaveChanges();
            return RedirectToAction("Login");
        }

        [NonAction]
        public void SendVerificationLinkEmail(string emailID, string username, string SecretCode)
        {
            var verifyUrl = "/EmailVerification/" + SecretCode;
            var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

            var fromEmail = new MailAddress("thehamojha@gmail.com");
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = "Replace with actual password"; // Replace with actual password
            string subject = "Note Marketplace - Email Verification";

            string body = "Hello " + username + "," +
                "<br/><br/>Thank you for signing up with us. Please click on below link to verify your email address and to do login." +
                "<br/><br/><a href='" + link + "'>" + link + "</a> " +
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

        [HttpGet]
        [Route("Login")]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Login")]
        public ActionResult Login(Models.UserLogin login, string ReturnUrl = "")
        {
            //string message = "";
            using (NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities())
            {
                var v = dbobj.UserTable.Where(a => a.Email == login.Email).FirstOrDefault();
                if (v != null)
                {
                    if (v.IsEmailVerified == true)
                    {
                        if (string.Compare(Crypto.Hash(login.Password), v.Password) == 0)
                        {
                            int timeout = login.RememberMe ? 525600 : 20; // 525600 min = 1 year
                            var ticket = new FormsAuthenticationTicket(login.Email, login.RememberMe, timeout);
                            string encrypted = FormsAuthentication.Encrypt(ticket);
                            var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypted);
                            cookie.Expires = DateTime.Now.AddMinutes(timeout);
                            cookie.HttpOnly = true;
                            Response.Cookies.Add(cookie);


                            if (Url.IsLocalUrl(ReturnUrl))
                            {
                                return Redirect(ReturnUrl);
                            }
                            else
                            {
                                //05-03-2021 Updated third parameter , new { userid = v.UID }
                                return RedirectToAction("DashBoard", "DashBoard");
                            }
                        }
                        else
                        {
                            //message = "Invalid Password";
                            ModelState.AddModelError("Password", "Invalid Password");
                            return View(login);
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("Email", "Email is not verified");
                        return View(login);
                    }
                }
                else
                {
                    //message = "Invalid Email";
                    ModelState.AddModelError("Email", "Invalid Email");
                    return View(login);
                }
            }
            //ViewBag.Message = message;
            //return View();
        }

        [Authorize]
        [Route("Logout")]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }

        [HttpGet]
        [Route("ForgotPassword")]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        [Route("ForgotPassword")]
        public ActionResult ForgotPassword(Models.ForgotPassword model)
        {
            if (ModelState.IsValid)
            {
                var isExist = IsEmailExist(model.Email);
                if (isExist == false)
                {
                    ModelState.AddModelError("Email", "Email Does not exist");
                    return View(model);
                }
                UserTable obj = dbobj.UserTable.Where(x => x.Email == model.Email).FirstOrDefault();
                string pwd = Membership.GeneratePassword(6, 2);
                obj.Password = Crypto.Hash(pwd);
                dbobj.SaveChanges();
                SendPassword(obj.Email, pwd);
                TempData["Success"] = "New password has been sent to your email";
            }
            return RedirectToAction("ForgotPassword");
        }

        [NonAction]
        public void SendPassword(string emailID, string pwd)
        {
            var fromEmail = new MailAddress("thehamojha@gmail.com");
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = "Replace with actual password"; // Replace with actual password
            string subject = "Note Marketplace - Email Verification";

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
    }
}