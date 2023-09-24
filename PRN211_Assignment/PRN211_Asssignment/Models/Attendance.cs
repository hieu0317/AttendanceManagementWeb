using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Attendance
    {
        public int Aid { get; set; }
        public int Sid { get; set; }
        public int Sesid { get; set; }
        public bool? Status { get; set; }
        public string? Description { get; set; }

        public virtual Session Ses { get; set; } = null!;
        public virtual Student Student { get; set; } = null!;
    }
}
