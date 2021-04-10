using NotesMarketPlace.Context;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class ManageSystemConfigurationsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin")]
        [Route("ManageSystemConfigurations")]
        public ActionResult ManageSystemConfigurations()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            SystemConfigurationTable sct = dbobj.SystemConfigurationTable.FirstOrDefault();

            Models.ManageSystemConfigurations model = new Models.ManageSystemConfigurations();
            model.SupportEmail = sct.SupportEmail;
            model.Password = sct.Password;
            model.SupportPhoneNumber = sct.SupportPhoneNumber;
            model.Email = sct.Email;
            model.Facebook = sct.Facebook;
            model.Twitter = sct.Twitter;
            model.LinkedIn = sct.LinkedIn;

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin")]
        [Route("ManageSystemConfigurations")]
        public ActionResult ManageSystemConfigurations(Models.ManageSystemConfigurations model)
        {
            if (ModelState.IsValid)
            {
                SystemConfigurationTable mscobj = dbobj.SystemConfigurationTable.FirstOrDefault();

                mscobj.SupportEmail = model.SupportEmail;
                mscobj.Password = model.Password;
                mscobj.SupportPhoneNumber = model.SupportPhoneNumber;
                mscobj.Email = model.Email;
                mscobj.Facebook = model.Facebook;
                mscobj.Twitter = model.Twitter;
                mscobj.LinkedIn = model.LinkedIn;

                var OldDefaultNoteImage = Server.MapPath(mscobj.DefaultNoteImage);
                FileInfo file = new FileInfo(OldDefaultNoteImage);
                if (file.Exists)
                {
                    file.Delete();
                }
                var DefaultNoteImageName = "Book" + Path.GetExtension(model.DefaultNoteImage.FileName);
                var DefaultNoteImageSavePath = Path.Combine(Server.MapPath("~/Default/") + DefaultNoteImageName);
                model.DefaultNoteImage.SaveAs(DefaultNoteImageSavePath);
                mscobj.DefaultNoteImage = Path.Combine(("Default/") + DefaultNoteImageName);

                var OldDefaultProfilePicture = Server.MapPath(mscobj.DefaultProfilePicture);
                FileInfo file2 = new FileInfo(OldDefaultProfilePicture);
                if (file2.Exists)
                {
                    file2.Delete();
                }
                var DefaultProfilePictureName = "User" + Path.GetExtension(model.DefaultProfilePicture.FileName);
                var DefaultProfilePictureSavePath = Path.Combine(Server.MapPath("~/Default/") + DefaultProfilePictureName);
                model.DefaultProfilePicture.SaveAs(DefaultProfilePictureSavePath);
                mscobj.DefaultProfilePicture = Path.Combine(("Default/") + DefaultProfilePictureName);

                dbobj.Entry(mscobj).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                return RedirectToAction("AdminDashboard","Admin");
            }
            return View();
        }
    }
}