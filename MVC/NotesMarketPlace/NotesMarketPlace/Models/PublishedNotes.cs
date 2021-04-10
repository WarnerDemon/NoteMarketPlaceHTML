using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class PublishedNotes
    {
        public int NID { get; set; }
        public int UID { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string SellType { get; set; }
        public int Price { get; set; }
        public string Seller { get; set; }
        public Nullable<System.DateTime> PublishedDate { get; set; }
        public string ApprovedBy { get; set; }
        public int TotalDownloads { get; set; }

    }
}