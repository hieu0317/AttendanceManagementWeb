using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Instructor
    {
        public Instructor()
        {
            Groups = new HashSet<Group>();
            Users = new HashSet<User>();
        }

        public int InstructorId { get; set; }
        public string InstructorRollNumber { get; set; } = null!;
        public string InstructorName { get; set; } = null!;

        public virtual ICollection<Group> Groups { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}
