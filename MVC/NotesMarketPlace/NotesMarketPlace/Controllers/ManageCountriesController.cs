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
    public class ManageCountriesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("ManageCountries")]
        public ActionResult ManageCountries(string search, int? page, string sortby)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortCountry = sortby == "Country" ? "Country Desc" : "Country";
            ViewBag.SortAddedBy = sortby == "AddedBy" ? "AddedBy Desc" : "AddedBy";

            System.Linq.IQueryable<NotesMarketPlace.Context.CountryTable> filtered;

            if (String.IsNullOrEmpty(search))   //  All Type
            {
                //  All Type
                filtered = dbobj.CountryTable.Where(x => x.IsActive == true || x.IsActive == false).ToList().AsQueryable();
            }
            else
            {
                filtered = dbobj.CountryTable.Where(x => (x.CountryName.Contains(search) || x.CountryName.Contains(search) ||
                (x.CreatedDate.Value.Day + "-" + x.CreatedDate.Value.Month + "-" + x.CreatedDate.Value.Year).Contains(search) ||
                (x.UserTable.FirstName + " " + x.UserTable.LastName).Contains(search))).ToList().AsQueryable();
            }

            switch (sortby)
            {
                case "Date Desc":
                    filtered = filtered.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Country":
                    filtered = filtered.OrderBy(x => x.CountryName);
                    break;
                case "Country Desc":
                    filtered = filtered.OrderByDescending(x => x.CountryName);
                    break;
                case "AddedBy":
                    filtered = filtered.OrderBy(x => x.UserTable.FirstName);
                    break;
                case "AddedBy Desc":
                    filtered = filtered.OrderByDescending(x => x.UserTable.FirstName);
                    break;
                default:
                    filtered = filtered.OrderBy(x => x.CreatedDate);
                    break;
            }

            //Converting filtered entry into Manage Country Model
            var mcobj = new List<ManageCountry>();
            foreach (var item in filtered)
            {
                mcobj.Add(new ManageCountry()
                {
                    CountryID = item.CountryID,
                    CountryName = item.CountryName,
                    CountryCode = item.CountryCode,
                    CreatedDate = item.CreatedDate,
                    AddedBy = item.UserTable.FirstName + " " + item.UserTable.LastName,
                    IsActive = item.IsActive
                });

            }

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(mcobj.ToPagedList(page ?? 1, 5));
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AddCountry")]
        public ActionResult AddCountry()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AddCountry")]
        public ActionResult AddCountry(AddCountry model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                CountryTable obj = new CountryTable();
                obj.CountryName = model.CountryName;
                obj.CountryCode = model.CountryCode;
                obj.CreatedDate = DateTime.Now;
                obj.CreatedBy = admin.UID;
                obj.IsActive = true;

                dbobj.CountryTable.Add(obj);
                dbobj.SaveChanges();

                return RedirectToAction("ManageCountries");
            }
            return View();
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("EditCountry")]
        public ActionResult EditCountry(int CountryID)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            CountryTable obj = dbobj.CountryTable.Where(x => x.CountryID == CountryID).FirstOrDefault();

            AddCountry model = new AddCountry();
            model.CountryID = obj.CountryID;
            model.CountryName = obj.CountryName;
            model.CountryCode = obj.CountryCode;

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("EditCountry")]
        public ActionResult EditCountry(AddCountry model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                CountryTable obj = dbobj.CountryTable.Where(x => x.CountryID == model.CountryID).FirstOrDefault();

                obj.CountryName = model.CountryName;
                obj.CountryCode = model.CountryCode;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = admin.UID;

                dbobj.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                return RedirectToAction("ManageCountries");
            }
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("UpdateCountryStatus")]
        public ActionResult UpdateCountryStatus(int CountryID, int status)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            CountryTable obj = dbobj.CountryTable.Where(x => x.CountryID == CountryID).FirstOrDefault();

            if (status == 0)    // Deactivate Category
            {
                obj.IsActive = false;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = admin.UID;

            }
            else    // Activate Category
            {
                obj.IsActive = true;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = admin.UID;

            }

            dbobj.Entry(obj).State = System.Data.Entity.EntityState.Modified;
            dbobj.SaveChanges();

            return RedirectToAction("ManageCountries");
        }
    }
}