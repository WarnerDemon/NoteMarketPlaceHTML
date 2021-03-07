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
    [Authorize]
    public class AddNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Route("AddNotes")]
        public ActionResult AddNotes(int? id)
        {
            if (id != null)
            {
                Context.NoteTable noteobj = dbobj.NoteTable.Where(x => x.NID == id).FirstOrDefault();
                AddNotes editobj = new AddNotes();
                editobj.NID = noteobj.NID;
                editobj.Title = noteobj.Title;
                editobj.CategoryID = noteobj.CategoryID;
                editobj.TypeID = noteobj.TypeID;
                editobj.NumberOfPages = noteobj.NumberOfPages;
                editobj.Description = noteobj.Description;
                editobj.CountryID = noteobj.CountryID;
                editobj.InstituteName = noteobj.InstituteName;
                editobj.IsPaid = noteobj.IsPaid;
                editobj.CourseName = noteobj.CourseName;
                editobj.CourseCode = noteobj.CourseCode;
                editobj.Professor = noteobj.Professor;
                editobj.Price = noteobj.Price;

                ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
                ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
                ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
                return View(editobj);
            }

            ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
            ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
            ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
            return View();
        }

        [HttpPost]
        [Route("AddNotes")]
        public ActionResult AddNotes(Models.AddNotes model, string submitButton)
        {
            if (ModelState.IsValid)
            {
                if((model.IsPaid == true) && (model.PreviewAttachment == null))
                {
                    ModelState.AddModelError("PreviewAttachment", "PreviewAttachment Required");
                    ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
                    ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
                    ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
                    return View(model);
                }

                var emailid = User.Identity.Name.ToString();
                Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();
                string path = Path.Combine(Server.MapPath("~/Members"), obj.UID.ToString());

                //Checking for directory

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                //Saving into database

                NoteTable noteobj = new NoteTable();
                noteobj.NID = model.NID;
                noteobj.UID = obj.UID;
                noteobj.Title = model.Title;
                noteobj.CategoryID = model.CategoryID;
                noteobj.TypeID = model.TypeID;
                noteobj.NumberOfPages = model.NumberOfPages;
                noteobj.Description = model.Description;
                noteobj.CountryID = model.CountryID;
                noteobj.InstituteName = model.InstituteName;
                noteobj.CourseName = model.CourseName;
                noteobj.CourseCode = model.CourseCode;
                noteobj.Professor = model.Professor;
                noteobj.IsPaid = model.IsPaid;
                noteobj.Price = model.Price;
                if(submitButton == "1")
                {
                    noteobj.Status = 1;
                }
                else
                {
                    noteobj.Status = 2;
                }
                noteobj.ActionBy = 3;
                noteobj.CreatedDate = DateTime.Now;
                noteobj.IsActive = true;

                if(model.NID == 0)
                {
                    dbobj.NoteTable.Add(noteobj);
                    dbobj.SaveChanges();
                }
                else
                {
                    dbobj.Entry(noteobj).State = System.Data.Entity.EntityState.Modified;
                    dbobj.SaveChanges();
                }

                //Acquiring NoteID

                var NoteID = noteobj.NID;
                string finalpath = Path.Combine(Server.MapPath("~/Members/" + obj.UID), NoteID.ToString());

                if (!Directory.Exists(finalpath))
                {
                    Directory.CreateDirectory(finalpath);
                }

                if (model.DisplayPicture!=null && model.DisplayPicture.ContentLength>0)
                {
                    //var displayimagename = Path.GetFileName(model.DisplayPicture.FileName);
                    var displayimagename = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + Path.GetExtension(model.DisplayPicture.FileName);
                    var ImageSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/") + "DP_" + displayimagename);
                    model.DisplayPicture.SaveAs(ImageSavePath);
                    noteobj.DisplayPicture = Path.Combine(("~/Members/" + obj.UID + "/" + noteobj.NID + "/"), displayimagename);
                    dbobj.SaveChanges();
                }
                else
                {
                    noteobj.DisplayPicture = "C:/Users/gohil/source/repos/NotesMarketPlace/NotesMarketPlace/Default/UserProfileImage.jpg";
                    dbobj.SaveChanges();
                }

                if (model.PreviewAttachment!=null && model.PreviewAttachment.ContentLength > 0)
                {
                    var notespreviewname = Path.GetFileName(model.PreviewAttachment.FileName);
                    var PreviewSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/") + "Preview_" + DateTime.Now.ToString().Replace(':','-').Replace(' ','_') + "_" + notespreviewname);
                    model.PreviewAttachment.SaveAs(PreviewSavePath);
                    noteobj.PreviewAttachment = Path.Combine(("~/Members/" + obj.UID + "/" + noteobj.NID + "/"), notespreviewname);
                    dbobj.SaveChanges();
                }

                NotesAttachmentTable natobj = new NotesAttachmentTable();
                natobj.NID = NoteID;
                natobj.IsActive = true;
                natobj.CreatedBy = obj.UID;
                natobj.CreatedDate = DateTime.Now;
                
                string AttachmentPath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID ), "Attachment" );

                if (!Directory.Exists(AttachmentPath))
                {
                    Directory.CreateDirectory(AttachmentPath);
                }

                int counter = 1;
                var uploadfilepath = "";
                var uploadfilename = "";

                foreach (HttpPostedFileBase file in model.File)
                {
                    //Checking file is available to save.  
                    if (file != null)
                    {
                        var InputFileName = Path.GetFileName(file.FileName);
                        var ServerSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/Attachment/") +"Attachment_"+ counter + "_" + DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + "_" + InputFileName);
                        counter++;
                        //Save file to server folder
                        file.SaveAs(ServerSavePath);
                        uploadfilepath += ServerSavePath + ";";
                        uploadfilename += InputFileName + ";";
                    }

                }

                natobj.FileName = uploadfilename;
                natobj.FilePath = uploadfilepath;
                dbobj.NotesAttachmentTable.Add(natobj);
                dbobj.SaveChanges();

                return RedirectToAction("Dashboard", "Dashboard");
            }

            return RedirectToAction("Dashboard", "Dashboard");

        }
            
    }
    
}