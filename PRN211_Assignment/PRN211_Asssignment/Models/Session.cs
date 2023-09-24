using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Session
    {
        public Session()
        {
            Attendances = new HashSet<Attendance>();
        }

        public int SessionId { get; set; }
        public int GroupId { get; set; }
        public int? InstructorId { get; set; }
        public int TimeSlotId { get; set; }
        public int RoomId { get; set; }
        public DateTime Date { get; set; }
        public bool? Status { get; set; }

        public virtual Group Group { get; set; } = null!;
        public virtual Room Room { get; set; } = null!;
        public virtual TimeSlot TimeSlot { get; set; } = null!;
        public virtual ICollection<Attendance> Attendances { get; set; }
    }
}
