using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class DisplayReview
    {
        public string ReviewBy { get; set; }
        public string UserImage { get; set; }
        public int Stars { get; set; }
        public string Comment { get; set; }
        
    }
}