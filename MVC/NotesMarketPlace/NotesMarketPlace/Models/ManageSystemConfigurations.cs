using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class ManageSystemConfigurations
    {
        [Required]
        [EmailAddress]
        public string SupportEmail { get; set; }
        [Required]
        public string Password { get; set; }
        [Compare("Password", ErrorMessage = "Incorrect Password")]
        public string ConfirmPassword { get; set; }
        [Required]
        public string SupportPhoneNumber { get; set; }
        [EmailAddress]
        public string Email { get; set; }
        public string Facebook { get; set; }
        public string Twitter { get; set; }
        public string LinkedIn { get; set; }
        [Required]
        public HttpPostedFileBase DefaultNoteImage { get; set; }
        [Required]
        public HttpPostedFileBase DefaultProfilePicture { get; set; }
    }
}