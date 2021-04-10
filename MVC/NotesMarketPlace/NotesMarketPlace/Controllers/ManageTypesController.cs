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
    public class ManageTypesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("ManageTypes")]
        public ActionResult ManageTypes(string search, int? page, string sortby)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.SortDate = string.IsNullOrEmpty(sortby) ? "Date Desc" : "";
            ViewBag.SortType = sortby == "Type" ? "Type Desc" : "Type";
            ViewBag.SortDescription = sortby == "Description" ? "Description Desc" : "Description";
            ViewBag.SortAddedBy = sortby == "AddedBy" ? "AddedBy Desc" : "AddedBy";

            System.Linq.IQueryable<NotesMarketPlace.Context.TypeTable> filtered;

            if (String.IsNullOrEmpty(search))   //  All Type
            {
                //  All Type
                filtered = dbobj.TypeTable.Where(x => x.IsActive == true || x.IsActive == false).ToList().AsQueryable();
            }
            else
            {
                filtered = dbobj.TypeTable.Where(x => (x.Name.Contains(search) || x.Description.Contains(search) ||
                (x.CreatedDate.Value.Day + "-" + x.CreatedDate.Value.Month + "-" + x.CreatedDate.Value.Year).Contains(search) ||
                (x.UserTable.FirstName + " " + x.UserTable.LastName).Contains(search))).ToList().AsQueryable();
            }

            switch (sortby)
            {
                case "Date Desc":
                    filtered = filtered.OrderByDescending(x => x.CreatedDate);
                    break;
                case "Type":
                    filtered = filtered.OrderBy(x => x.Name);
                    break;
                case "Type Desc":
                    filtered = filtered.OrderByDescending(x => x.Name);
                    break;
                case "Description":
                    filtered = filtered.OrderBy(x => x.Description);
                    break;
                case "Description Desc":
                    filtered = filtered.OrderByDescending(x => x.Description);
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

            //Converting filtered entry into Manage Type Model
            var mtobj = new List<ManageType>();
            foreach (var item in filtered)
            {
                mtobj.Add(new ManageType()
                {
                    TypeID = item.TypeID,
                    TypeName = item.Name,
                    Description = item.Description,
                    CreatedDate = item.CreatedDate,
                    AddedBy = item.UserTable.FirstName + " " + item.UserTable.LastName,
                    IsActive = item.IsActive
                });

            }

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(mtobj.ToPagedList(page ?? 1, 5));
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AddType")]
        public ActionResult AddType()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("AddType")]
        public ActionResult AddType(AddType model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                TypeTable obj = new TypeTable();
                obj.Name = model.TypeName;
                obj.Description = model.Description;
                obj.CreatedDate = DateTime.Now;
                obj.CreatedBy = admin.UID;
                obj.IsActive = true;

                dbobj.TypeTable.Add(obj);
                dbobj.SaveChanges();

                return RedirectToAction("ManageTypes");
            }
            return View();
        }

        [HttpGet]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("EditType")]
        public ActionResult EditType(int TypeID)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            TypeTable obj = dbobj.TypeTable.Where(x => x.TypeID == TypeID).FirstOrDefault();

            AddType model = new AddType();
            model.TypeID = obj.TypeID;
            model.TypeName = obj.Name;
            model.Description = obj.Description;

            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Super Admin,Admin")]
        [Route("EditType")]
        public ActionResult EditType(AddType model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                TypeTable obj = dbobj.TypeTable.Where(x => x.TypeID == model.TypeID).FirstOrDefault();

                obj.Name = model.TypeName;
                obj.Description = model.Description;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = admin.UID;

                dbobj.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                dbobj.SaveChanges();

                return RedirectToAction("ManageTypes");
            }
            ViewBag.ProfilePicture = dbobj.AdminTable.Where(x => x.UID == admin.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [Authorize(Roles = "Super Admin,Admin")]
        [Route("UpdateTypeStatus")]
        public ActionResult UpdateTypeStatus(int TypeID, int status)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable admin = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            TypeTable obj = dbobj.TypeTable.Where(x => x.TypeID == TypeID).FirstOrDefault();

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

            return RedirectToAction("ManageTypes");
        }
    }
}