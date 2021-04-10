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
    [Authorize(Roles = "User")]
    public class UserProfileController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Route("UserProfile")]
        public ActionResult UserProfile()
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var isnew = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).FirstOrDefault();

            if(isnew == null)   // For new user
            {
                UserProfile upobj = new UserProfile();
                upobj.UID = obj.UID;
                upobj.FirstName = obj.FirstName;
                upobj.LastName = obj.LastName;
                upobj.Email = obj.Email;

                ViewBag.CountryCode = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
                ViewBag.CountryName = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();

                return View(upobj);
            }
            else   // For old user
            {
                UserProfileTable oldupobj = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).FirstOrDefault();
                UserProfile editupobj = new UserProfile();

                editupobj.UID = obj.UID;
                editupobj.FirstName = obj.FirstName;
                editupobj.LastName = obj.LastName;
                editupobj.Email = obj.Email;

                editupobj.DateOfBirth = oldupobj.DateOfBirth;
                editupobj.Gender = oldupobj.Gender;
                editupobj.CountryCode = oldupobj.CountryCode;
                editupobj.PhoneNumber = oldupobj.PhoneNumber;
                //editupobj.ProfilePicture = oldupobj.ProfilePicture;
                editupobj.AddressLine1 = oldupobj.AddressLine1;
                editupobj.AddressLine2 = oldupobj.AddressLine2;
                editupobj.City = oldupobj.City;
                editupobj.State = oldupobj.State;
                editupobj.ZipCode = oldupobj.ZipCode;
                editupobj.CountryID = oldupobj.CountryID;
                editupobj.University = oldupobj.University;
                editupobj.College = oldupobj.College;

                ViewBag.CountryCode = new SelectList(dbobj.CountryTable, "CountryCode", "CountryCode");
                ViewBag.CountryName = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();

                return View(editupobj);
            }
            
        }

        [HttpPost]
        [Route("UserProfile")]
        public ActionResult UserProfile(UserProfile model)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                var isnew = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).FirstOrDefault();

                if (isnew == null)   // For new user
                {
                    UserProfileTable upobj = new UserProfileTable();
                    upobj.UID = obj.UID;
                    upobj.DateOfBirth = model.DateOfBirth;
                    upobj.Gender = model.Gender;
                    upobj.CountryCode = model.CountryCode;
                    upobj.PhoneNumber = model.PhoneNumber;
                    upobj.AddressLine1 = model.AddressLine1;
                    upobj.AddressLine2 = model.AddressLine2;
                    upobj.City = model.City;
                    upobj.State = model.State;
                    upobj.ZipCode = model.ZipCode;
                    upobj.CountryID = model.CountryID;
                    upobj.University = model.University;
                    upobj.College = model.College;
                    upobj.CreatedDate = DateTime.Now;
                    upobj.CreatedBy = obj.UID;
                    upobj.IsActive = true;

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
                        upobj.ProfilePicture = Path.Combine(("Members/" + obj.UID + "/"), "DP_" + ProfilePicture);
                        dbobj.SaveChanges();
                    }
                    else
                    {
                        /*upobj.ProfilePicture = "Default/User.jpg";*/
                        upobj.ProfilePicture = dbobj.SystemConfigurationTable.Select(x => x.DefaultProfilePicture).ToString();
                        dbobj.SaveChanges();
                    }

                    dbobj.UserProfileTable.Add(upobj);
                    dbobj.SaveChanges();

                    return RedirectToAction("SearchNotes", "SearchNotes");
                }
                else   // For old user
                {
                    UserProfileTable oldupobj = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).FirstOrDefault();

                    Context.UserTable olduserobj = dbobj.UserTable.Where(x => x.UID == obj.UID).FirstOrDefault();

                    olduserobj.FirstName = model.FirstName;
                    olduserobj.LastName = model.LastName;
                    olduserobj.Email = model.Email;
                    olduserobj.ModifiedDate = DateTime.Now;
                    olduserobj.ModifiedBy = olduserobj.UID;

                    oldupobj.DateOfBirth = model.DateOfBirth;
                    oldupobj.Gender = model.Gender;
                    oldupobj.CountryCode = model.CountryCode;
                    oldupobj.PhoneNumber = model.PhoneNumber;
                    oldupobj.AddressLine1 = model.AddressLine1;
                    oldupobj.AddressLine2 = model.AddressLine2;
                    oldupobj.City = model.City;
                    oldupobj.State = model.State;
                    oldupobj.ZipCode = model.ZipCode;
                    oldupobj.CountryID = model.CountryID;
                    oldupobj.University = model.University;
                    oldupobj.College = model.College;
                    oldupobj.ModifiedDate = DateTime.Now;
                    oldupobj.ModifiedBy = obj.UID;

                    string path = Path.Combine(Server.MapPath("~/Members"), obj.UID.ToString());

                    //Saving Profile Picture
                    if (model.ProfilePicture != null && model.ProfilePicture.ContentLength > 0)
                    {
                        var OldProfilePicture = Server.MapPath(oldupobj.ProfilePicture);
                        FileInfo file = new FileInfo(OldProfilePicture);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                        var ProfilePicture = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + Path.GetExtension(model.ProfilePicture.FileName);
                        var ImageSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/") + "DP_" + ProfilePicture);
                        model.ProfilePicture.SaveAs(ImageSavePath);
                        oldupobj.ProfilePicture = Path.Combine(("Members/" + obj.UID + "/"), "DP_" + ProfilePicture);
                        dbobj.SaveChanges();
                    }

                    dbobj.Entry(olduserobj).State = System.Data.Entity.EntityState.Modified;
                    dbobj.Entry(oldupobj).State = System.Data.Entity.EntityState.Modified;
                    dbobj.SaveChanges();

                    return RedirectToAction("SearchNotes", "SearchNotes");

                }
                
            }
            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View(model);
        }
    }
}