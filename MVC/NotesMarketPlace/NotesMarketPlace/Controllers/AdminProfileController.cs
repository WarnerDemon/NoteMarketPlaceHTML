using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class AdminProfileController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AdminProfile")]
        public ActionResult AdminProfile()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var apobj = dbobj.AdminTable.Where(x => x.UID == obj.UID).FirstOrDefault();

            AdminProfile myprofile = new AdminProfile();
            myprofile.FirstName = obj.FirstName;
            myprofile.LastName = obj.LastName;
            myprofile.Email = obj.Email;
            myprofile.SecondaryEmail = apobj.SecondaryEmail;
            myprofile.CountryCode = apobj.CountryCode;
            myprofile.PhoneNumber = apobj.PhoneNumber;

            ViewBag.CountryCodelist = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(myprofile);
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AdminProfile")]
        public ActionResult AdminProfile(Models.AdminProfile model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var apobj = dbobj.AdminTable.Where(x => x.UID == obj.UID).FirstOrDefault();

            obj.FirstName = model.FirstName;
            obj.LastName = model.LastName;
            obj.Email = model.Email;
            apobj.SecondaryEmail = model.SecondaryEmail;
            apobj.CountryCode = model.CountryCode;
            apobj.PhoneNumber = model.PhoneNumber;

            string path = Path.Combine(Server.MapPath("~/Members"), obj.UID.ToString());

            //Checking for directory

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            //Saving Profile Picture
            if (model.ProfilePicture != null && model.ProfilePicture.ContentLength > 0)
            {
                var ProfilePicture = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + Path.GetExtension(model.ProfilePicture.FileName);
                var ImageSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/") + "DP_" + ProfilePicture);
                model.ProfilePicture.SaveAs(ImageSavePath);
                apobj.ProfilePicture = Path.Combine(("Members/" + obj.UID + "/"), "DP_" + ProfilePicture);
            }
            else
            {
                apobj.ProfilePicture = dbobj.SystemConfigurationTable.FirstOrDefault().DefaultProfilePicture;
            }

            dbobj.Entry(obj).State = System.Data.Entity.EntityState.Modified;
            dbobj.Entry(apobj).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return RedirectToAction("AdminDashboard", "Admin");
        }
    }
}