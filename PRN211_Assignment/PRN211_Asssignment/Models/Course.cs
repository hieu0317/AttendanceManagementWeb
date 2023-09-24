using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Course
    {
        public Course()
        {
            Groups = new HashSet<Group>();
        }

        public int CourseId { get; set; }
        public string Cname { get; set; } = null!;
        public string Code { get; set; } = null!;

        public virtual ICollection<Group> Groups { get; set; }
    }
}
