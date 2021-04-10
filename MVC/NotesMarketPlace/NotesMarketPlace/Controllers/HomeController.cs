using NotesMarketPlace.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class HomeController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();
        // GET: Home
        [Route("")]
        public ActionResult Home()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (obj != null)
            {
                if (obj.RoleID != 3)
                {
                    return RedirectToAction("AdminDashboard", "Admin");
                }
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            }
            return View();
        }
    }
}