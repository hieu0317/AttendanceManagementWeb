using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class TimeSlot
    {
        public TimeSlot()
        {
            Sessions = new HashSet<Session>();
        }

        public int TimeSlotId { get; set; }
        public string? TimeFrom { get; set; }
        public string? TimeTo { get; set; }

        public virtual ICollection<Session> Sessions { get; set; }
    }
}
