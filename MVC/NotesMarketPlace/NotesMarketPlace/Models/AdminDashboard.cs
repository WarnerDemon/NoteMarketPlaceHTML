using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class AdminDashboard
    {
        public int NID { get; set; }
        public int UID { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string FileSize { get; set; }
        public string SellType { get; set; }
        public int Price { get; set; }
        public string Publisher { get; set; }
        public Nullable<System.DateTime> PublishedDate { get; set; }
        public int TotalDownloads { get; set; }
    }
}