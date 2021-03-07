using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class NoteDetailsController : Controller
    {
        [Route("NoteDetails")]
        public ActionResult NoteDetails()
        {
            return View();
        }
    }
}