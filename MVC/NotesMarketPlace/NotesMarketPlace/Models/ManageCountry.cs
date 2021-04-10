using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class ManageCountry
    {
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public string CountryCode { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string AddedBy { get; set; }
        public bool IsActive { get; set; }
    }
}