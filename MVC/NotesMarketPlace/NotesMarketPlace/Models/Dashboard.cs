using NotesMarketPlace.Context;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketPlace.Models
{
    public class Dashboard
    {
        public IPagedList<NoteTable> Progress { get; set; }
        public IPagedList<NoteTable> Published { get; set; }
    }
}