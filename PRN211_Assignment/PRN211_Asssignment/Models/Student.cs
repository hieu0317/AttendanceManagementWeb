using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Student
    {
        public Student()
        {
            Attendances = new HashSet<Attendance>();
            Users = new HashSet<User>();
            Groups = new HashSet<Group>();
        }

        public int StudentId { get; set; }
        public string StudentRollNumber { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public DateTime Dob { get; set; }
        public bool Gender { get; set; }

        public virtual ICollection<Attendance> Attendances { get; set; }
        public virtual ICollection<User> Users { get; set; }

        public virtual ICollection<Group> Groups { get; set; }
    }
}
