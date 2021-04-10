using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class AddType
    {
        public int TypeID { get; set; }
        [Required]
        public string TypeName { get; set; }
        [Required]
        public string Description { get; set; }
    }
}