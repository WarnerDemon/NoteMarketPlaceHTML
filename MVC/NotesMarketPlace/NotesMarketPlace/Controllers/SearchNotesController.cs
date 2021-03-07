using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class SearchNotesController : Controller
    {
        [Route("SearchNotes")]
        public ActionResult SearchNotes()
        {
            return View();
        }
    }
}