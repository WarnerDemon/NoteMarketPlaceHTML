using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using PagedList;
using PagedList.Mvc;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    [Authorize]
    public class BuyerRequestController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [Route("BuyerRequest")]
        public ActionResult BuyerRequest(string search, int? page, string sortby)
        {
            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategort = sortby == "Category" ? "Category Desc" : "Category";

            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var filtered_title = dbobj.TransectionTable.Where(x => x.Title.Contains(search) || search == null);
            var filtered_category = dbobj.TransectionTable.Where(x => x.Category.Contains(search));

            var filtered = filtered_title.Union(filtered_category);

            //Fetching current users notes
            var entry = filtered.Where(x => x.SellerID == obj.UID && x.IsAllowed == false).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    entry = entry.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Title":
                    entry = entry.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    entry = entry.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    entry = entry.OrderBy(x => x.Category);
                    break;
                case "Category Desc":
                    entry = entry.OrderByDescending(x => x.Category);
                    break;
                default:
                    entry = entry.OrderBy(x => x.CreatedDate);
                    break;
            }

            //Converting entry into Buyer Request Model
            var brobj = new List<BuyerRequest>();
            foreach(var item in entry)
            {
                var buyer = dbobj.UserProfileTable.Where(x => x.UID == item.BuyerID).FirstOrDefault();
                brobj.Add(new BuyerRequest()
                {
                    TID = item.TID,
                    NID = item.NID,
                    Title = item.Title,
                    Category = item.Category,
                    BuyerEmail = item.UserTable.Email,
                    BuyerContact = buyer.PhoneNumber,
                    IsPaid = item.NoteTable.IsPaid,
                    Price = item.Price,
                    DownloadedDate = item.CreatedDate
                });

            }
            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(brobj.ToList().AsQueryable().ToPagedList(page ?? 1, 10));   //Stay on Page 1, Total 10 Entry
        }

        public ActionResult AllowDownload(int tid)
        {
            TransectionTable deal = dbobj.TransectionTable.Where(x => x.TID == tid).FirstOrDefault();
            deal.IsAllowed = true;

            dbobj.Entry(deal).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return RedirectToAction("BuyerRequest");
        }
    }
}