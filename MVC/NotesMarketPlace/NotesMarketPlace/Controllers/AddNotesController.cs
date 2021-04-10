using NotesMarketPlace.Context;
using NotesMarketPlace.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketPlace.Controllers
{
    [Authorize(Roles = "User")]
    public class AddNotesController : Controller
    {
        NotesMarketPlaceEntities dbobj = new NotesMarketPlaceEntities();

        [HttpGet]
        [Route("AddNotes")]
        public ActionResult AddNotes(int? id, string clone)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            var upobj = dbobj.UserProfileTable.Where(a => a.UID == obj.UID).FirstOrDefault();
            if (upobj == null)
            {
                return RedirectToAction("UserProfile", "UserProfile");
            }

            if (id != null)     //for edit note
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
                ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == noteobj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
                ViewBag.Clone = clone;
                return View(editobj);
            }

            //for new note

            ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
            ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
            ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();
        }

        [HttpPost]
        [Route("AddNotes")]
        public ActionResult AddNotes(Models.AddNotes model, string submitButton)
        {
            var emailid = User.Identity.Name.ToString();
            Context.UserTable obj = dbobj.UserTable.Where(x => x.Email == emailid).FirstOrDefault();

            if (ModelState.IsValid)
            {
                if(model.NID == null)     //for new note
                {
                    if ((model.File[0] == null) || ((model.IsPaid == true) && (model.PreviewAttachment == null)))
                    {
                        if (model.File[0] == null)
                        {
                            ModelState.AddModelError("File", "File Required");
                        }
                        if (model.PreviewAttachment == null)
                        {
                            ModelState.AddModelError("PreviewAttachment", "PreviewAttachment Required");
                        }

                        ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
                        ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
                        ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
                        ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
                        return View(model);
                    }

                    string path = Path.Combine(Server.MapPath("~/Members"), obj.UID.ToString());

                    //Checking for directory

                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }

                    //Saving into database
                    NoteTable noteobj = new NoteTable();
                    noteobj.UID = obj.UID;
                    noteobj.Title = model.Title;
                    noteobj.CategoryID = model.CategoryID;
                    noteobj.TypeID = model.TypeID;
                    noteobj.NumberOfPages = model.NumberOfPages;
                    noteobj.Description = model.Description;
                    noteobj.CountryID = model.CountryID == null ? 8 : model.CountryID;  //if null then country id = 8
                    noteobj.InstituteName = model.InstituteName;
                    noteobj.CourseName = model.CourseName == null ? "Other" : model.CourseName;
                    noteobj.CourseCode = model.CourseCode;
                    noteobj.Professor = model.Professor;
                    noteobj.IsPaid = model.IsPaid;
                    noteobj.Price = model.Price;
                    if (submitButton == "1")
                    {
                        noteobj.Status = 1;
                    }
                    else
                    {
                        noteobj.Status = 2;
                        NotifyAdmin(obj.FirstName, model.Title);
                    }
                    noteobj.ActionBy = obj.UID;
                    noteobj.CreatedDate = DateTime.Now;
                    noteobj.IsActive = true;

                    dbobj.NoteTable.Add(noteobj);
                    dbobj.SaveChanges();

                    var NoteID = noteobj.NID;
                    string finalpath = Path.Combine(Server.MapPath("~/Members/" + obj.UID), NoteID.ToString());

                    if (!Directory.Exists(finalpath))
                    {
                        Directory.CreateDirectory(finalpath);
                    }

                    if (model.DisplayPicture != null && model.DisplayPicture.ContentLength > 0)
                    {
                        var displayimagename = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + Path.GetExtension(model.DisplayPicture.FileName);
                        var ImageSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/") + "DP_" + displayimagename);
                        model.DisplayPicture.SaveAs(ImageSavePath);
                        noteobj.DisplayPicture = Path.Combine(("Members/" + obj.UID + "/" + noteobj.NID + "/"), "DP_" + displayimagename);
                        dbobj.SaveChanges();
                    }
                    else
                    {
                        /*noteobj.DisplayPicture = "Default/Book.jpg";*/
                        noteobj.DisplayPicture = dbobj.SystemConfigurationTable.Select(x=>x.DefaultNoteImage).ToString();
                        dbobj.SaveChanges();
                    }

                    if (model.PreviewAttachment != null && model.PreviewAttachment.ContentLength > 0)
                    {
                        var notespreviewname = "Preview_" + DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + "_" + Path.GetFileName(model.PreviewAttachment.FileName);
                        var PreviewSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/") + notespreviewname);
                        model.PreviewAttachment.SaveAs(PreviewSavePath);
                        noteobj.PreviewAttachment = Path.Combine(("Members/" + obj.UID + "/" + noteobj.NID + "/") + notespreviewname);
                        dbobj.SaveChanges();
                    }

                    NotesAttachmentTable natobj = new NotesAttachmentTable();
                    natobj.NID = NoteID;    //nat stands for note attachment table
                    natobj.IsActive = true;
                    natobj.CreatedBy = obj.UID;
                    natobj.CreatedDate = DateTime.Now;

                    string AttachmentPath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID), "Attachment");

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
                            var InputFileName = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + "_" + Path.GetFileName(file.FileName);
                            var ServerSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + noteobj.NID + "/Attachment/") + "Attachment_" + counter + "_" + InputFileName);
                            counter++;
                            //Save file to server folder
                            file.SaveAs(ServerSavePath);
                            uploadfilepath += Path.Combine(("Members/" + obj.UID + "/" + noteobj.NID + "/Attachment/") + "Attachment_" + counter + "_" + InputFileName) + ";";
                            uploadfilename += Path.GetFileName(file.FileName) + ";";
                        }

                    }

                    natobj.FileName = uploadfilename;
                    natobj.FilePath = uploadfilepath;
                    dbobj.NotesAttachmentTable.Add(natobj);
                    dbobj.SaveChanges();
                }
                else     //for edit note
                {
                    //Saving into database

                    NoteTable oldnote = dbobj.NoteTable.Where(x => x.NID == model.NID).FirstOrDefault();
                    oldnote.Title = model.Title;
                    oldnote.CategoryID = model.CategoryID;
                    oldnote.TypeID = model.TypeID;
                    oldnote.NumberOfPages = model.NumberOfPages;
                    oldnote.Description = model.Description;
                    oldnote.CountryID = model.CountryID == null ? 8 : model.CountryID;  //if null then country id = 8
                    oldnote.InstituteName = model.InstituteName;
                    oldnote.CourseName = model.CourseName == null ? "Other" : model.CourseName;
                    oldnote.CourseCode = model.CourseCode;
                    oldnote.Professor = model.Professor;
                    oldnote.IsPaid = model.IsPaid;
                    oldnote.Price = model.Price;

                    if (submitButton == "1")
                    {
                        oldnote.Status = 1;
                    }
                    else
                    {
                        oldnote.Status = 2;
                        NotifyAdmin(obj.FirstName, model.Title);
                    }
                    oldnote.ActionBy = obj.UID;
                    oldnote.ModifiedDate = DateTime.Now;
                    oldnote.IsActive = true;

                    dbobj.Entry(oldnote).State = System.Data.Entity.EntityState.Modified;
                    dbobj.SaveChanges();

                    var NoteID = oldnote.NID;
                    string finalpath = Path.Combine(Server.MapPath("~/Members/" + obj.UID), NoteID.ToString());

                    //  For New Display Picture
                    if (model.DisplayPicture != null && model.DisplayPicture.ContentLength > 0)
                    {
                        var OldDisplayPicture = Server.MapPath(oldnote.DisplayPicture);
                        FileInfo file = new FileInfo(OldDisplayPicture);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                        var displayimagename = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + Path.GetExtension(model.DisplayPicture.FileName);
                        var ImageSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + oldnote.NID + "/") + "DP_" + displayimagename);
                        model.DisplayPicture.SaveAs(ImageSavePath);
                        oldnote.DisplayPicture = Path.Combine(("Members/" + obj.UID + "/" + oldnote.NID + "/"), "DP_" + displayimagename);
                        dbobj.SaveChanges();
                    }

                    //  For New PreviewAttachment
                    if (model.PreviewAttachment != null && model.PreviewAttachment.ContentLength > 0)
                    {
                        var OldPreviewAttachment = Server.MapPath(oldnote.PreviewAttachment);
                        FileInfo file = new FileInfo(OldPreviewAttachment);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                        var notespreviewname = "Preview_" + DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + "_" + Path.GetFileName(model.PreviewAttachment.FileName);
                        var PreviewSavePath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + oldnote.NID + "/") + notespreviewname);
                        model.PreviewAttachment.SaveAs(PreviewSavePath);
                        oldnote.PreviewAttachment = Path.Combine(("Members/" + obj.UID + "/" + oldnote.NID + "/") + notespreviewname);
                        dbobj.SaveChanges();
                    }

                    if (model.File[0] != null)      // New file Uploaded
                    {
                        Context.NotesAttachmentTable oldnatobj = dbobj.NotesAttachmentTable.Where(x => x.NID == NoteID).FirstOrDefault();
                        oldnatobj.ModifiedDate = DateTime.Now;

                        string AttachmentPath = Path.Combine(Server.MapPath("~/Members/" + obj.UID + "/" + oldnote.NID), "Attachment");

                        Directory.Delete(AttachmentPath, true);
                        Directory.CreateDirectory(AttachmentPath);

                        int counter = 1;
                        var uploadfilepath = "";
                        var uploadfilename = "";

                        foreach (HttpPostedFileBase file in model.File)
                        {
                            //Checking file is available to save.  
                            if (file != null)
                            {
                                var InputFileName = DateTime.Now.ToString().Replace(':', '-').Replace(' ', '_') + "_" + Path.GetFileName(file.FileName);
                                var ServerSavePath = Path.Combine(Server.MapPath("Members/" + obj.UID + "/" + oldnote.NID + "/Attachment/") + "Attachment_" + counter + "_" + InputFileName);
                                counter++;
                                //Save file to server folder
                                file.SaveAs(ServerSavePath);
                                uploadfilepath += Path.Combine(("Members/" + obj.UID + "/" + oldnote.NID + "/Attachment/") + "Attachment_" + counter + "_" + InputFileName) + ";";
                                uploadfilename += Path.GetFileName(file.FileName) + ";";
                            }

                        }

                        oldnatobj.FileName = uploadfilename;
                        oldnatobj.FilePath = uploadfilepath;
                        dbobj.Entry(oldnatobj).State = System.Data.Entity.EntityState.Modified;
                        dbobj.SaveChanges();
                    }
                }

                return RedirectToAction("Dashboard", "Dashboard");
            }
            ViewBag.Category = new SelectList(dbobj.CategoryTable, "CategoryID", "Name");
            ViewBag.Type = new SelectList(dbobj.TypeTable, "TypeID", "Name");
            ViewBag.Country = new SelectList(dbobj.CountryTable, "CountryID", "CountryName");
            ViewBag.ProfilePicture = dbobj.UserProfileTable.Where(x => x.UID == obj.UID).Select(x => x.ProfilePicture).FirstOrDefault();
            return View();

        }
        [Authorize]
        public void NotifyAdmin(string Seller, string Title)
        {
            var fromEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().SupportEmail);
            var toEmail = new MailAddress(dbobj.SystemConfigurationTable.FirstOrDefault().Email);
            var fromEmailPassword = dbobj.SystemConfigurationTable.FirstOrDefault().Password; // Replace with actual password
            string subject = Seller + " sent his note for review";

            string body = "Hello Admins," +
                "<br/><br/>We want to inform you that, " + Seller + " sent his note " + Title +
                "for review. Please look at the notes and take required actions." +
                "<br/><br/>Regards,<br/>Notes Marketplace";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromEmail.Address, fromEmailPassword)
            };

            using (var message = new MailMessage(fromEmail, toEmail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
            smtp.Send(message);
        }

    }
    
}