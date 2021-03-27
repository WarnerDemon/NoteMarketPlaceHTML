using NotesMarketPlace.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class FAQController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();
        [Route("FAQ")]
        public ActionResult FAQ()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();
            if (obj != null)
            {
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            }
            return View();
        }
    }
}