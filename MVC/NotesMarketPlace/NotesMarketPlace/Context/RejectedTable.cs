//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace NotesMarketPlace.Context
{
    using System;
    using System.Collections.Generic;
    
    public partial class RejectedTable
    {
        public int ID { get; set; }
        public int NID { get; set; }
        public int RejectedBy { get; set; }
        public string Comments { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
    
        public virtual NoteTable NoteTable { get; set; }
        public virtual UserTable UserTable { get; set; }
    }
}