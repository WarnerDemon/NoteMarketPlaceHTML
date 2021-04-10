using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    public class MemberDetailsController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("MemberDetails")]
        public ActionResult MemberDetails(int uid, int? page, string sortby)
        {
            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortTitle = sortby == "Title" ? "Title Desc" : "Title";
            ViewBag.SortCategory = sortby == "Category" ? "Category Desc" : "Category";
            ViewBag.SortStatus = sortby == "Status" ? "Status Desc" : "Status";
            ViewBag.SortDateAdded = sortby == "DateAdded" ? "DateAdded Desc" : "DateAdded";

            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            Context.UserTable user = dbobj.UserTable.Where(x => x.UID == uid).FirstOrDefault();
            Context.UserProfileTable user_profile = dbobj.UserProfileTable.Where(x => x.UID == uid).FirstOrDefault();

            MemberDetails Member = new MemberDetails();

            MemberProfile member_profile = new MemberProfile();

            member_profile.UID = user.UID;
            member_profile.FirstName = user.FirstName;
            member_profile.LastName = user.LastName;
            member_profile.Email = user.Email;
            member_profile.ProfilePicture = user_profile.ProfilePicture;
            member_profile.DateOfBirth = user_profile.DateOfBirth;
            member_profile.PhoneNumber = user_profile.PhoneNumber;
            member_profile.University = user_profile.University;
            member_profile.AddressLine1 = user_profile.AddressLine1;
            member_profile.AddressLine2 = user_profile.AddressLine2;
            member_profile.City = user_profile.City;
            member_profile.State = user_profile.State;
            member_profile.Country = user_profile.CountryTable.CountryName;
            member_profile.ZipCode = user_profile.ZipCode;

            var notes = dbobj.NoteTable.Where(x => x.UID == uid && x.Status != 1).ToList().AsQueryable();

            switch (sortby)
            {
                case "Date Desc":
                    notes = notes.OrderByDescending(x => x.ModifiedDate);
                    break;
                case "Title":
                    notes = notes.OrderBy(x => x.Title);
                    break;
                case "Title Desc":
                    notes = notes.OrderByDescending(x => x.Title);
                    break;
                case "Category":
                    notes = notes.OrderBy(x => x.CategoryTable.Name);
                    break;
                case "Category Desc":
                    notes = notes.OrderByDescending(x => x.CategoryTable.Name);
                    break;
                case "Status":
                    notes = notes.OrderBy(x => x.ReferenceDataTable.StatusName);
                    break;
                case "Status Desc":
                    notes = notes.OrderByDescending(x => x.ReferenceDataTable.StatusName);
                    break;
                case "DateAdded":
                    notes = notes.OrderBy(x => x.CreatedDate);
                    break;
                case "DateAdded Desc":
                    notes = notes.OrderByDescending(x => x.CreatedDate);
                    break;
                default:
                    notes = notes.OrderBy(x => x.ModifiedDate);
                    break;
            }

            var member_notes = new List<MemberNotes>();
            foreach (var item in notes)
            {
                double Earning;
                int sold = dbobj.TransectionTable.Where(x => x.NID == item.NID && x.SellerID == uid && x.IsAllowed == true).Count();
                if (sold == 0)
                {
                    Earning = 0;
                }
                else
                {
                    Earning = dbobj.TransectionTable.Where(x => x.NID == item.NID && x.SellerID == uid && x.IsAllowed == true).Select(x => x.Price).Sum();
                }
                member_notes.Add(new MemberNotes()
                {
                    NID = item.NID,
                    UID = item.UID,
                    Title = item.Title,
                    Category = item.CategoryTable.Name,
                    Status = item.ReferenceDataTable.StatusName,
                    TotalDownloads = dbobj.TransectionTable.Where(x=>x.NID == item.NID && x.SellerID == uid && x.IsDownloaded == true).Count(),
                    Earnings = Earning,
                    CreatedDate = item.CreatedDate,
                    PublishedDate = item.ModifiedDate
                });

            }

            Member.MemberProfile = member_profile;
            Member.MemberNotes = member_notes.ToPagedList(page ?? 1, 5);

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(Member);
        }
    }
}