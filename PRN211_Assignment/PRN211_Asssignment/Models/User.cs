using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class User
    {
        public int UserId { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Campus { get; set; } = null!;
        public int? StudentId { get; set; }
        public int? InstructorId { get; set; }
        public bool? IsStudent { get; set; }

        public virtual Instructor? Instructor { get; set; }
        public virtual Student? Student { get; set; }
    }
}
