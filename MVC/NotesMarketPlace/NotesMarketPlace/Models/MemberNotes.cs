using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class MemberNotes
    {
        public int NID { get; set; }
        public int UID { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string Status { get; set; }
        public int TotalDownloads { get; set; }
        public double Earnings { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<System.DateTime> PublishedDate { get; set; }
    }
}