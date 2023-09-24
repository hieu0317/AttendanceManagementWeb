using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Group
    {
        public Group()
        {
            Sessions = new HashSet<Session>();
            Students = new HashSet<Student>();
        }

        public int GroupId { get; set; }
        public string Gname { get; set; } = null!;
        public int CourseId { get; set; }
        public int InstructorId { get; set; }

        public virtual Course Course { get; set; } = null!;
        public virtual Instructor Instructor { get; set; } = null!;
        public virtual ICollection<Session> Sessions { get; set; }

        public virtual ICollection<Student> Students { get; set; }
    }
}
