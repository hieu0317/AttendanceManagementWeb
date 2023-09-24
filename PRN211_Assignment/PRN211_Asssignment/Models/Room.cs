using System;
using System.Collections.Generic;

namespace PRN211_Asssignment.Models
{
    public partial class Room
    {
        public Room()
        {
            Sessions = new HashSet<Session>();
        }

        public int RoomId { get; set; }
        public string Rname { get; set; } = null!;

        public virtual ICollection<Session> Sessions { get; set; }
    }
}
