using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN211_Asssignment.Models;
using System.Globalization;

namespace PRN211_Project.Controllers
{
    public class InstructorController : Controller
    {
        public IActionResult Home()
        {
            if (HttpContext.Session.GetString("InstructorID") == null)
            {
                return RedirectToAction("Login", "Authentication");
            }

            ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
            ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
            return View();
        }

        public IActionResult TimeTable(string weekNumber)
        {
            if (HttpContext.Session.GetString("InstructorID") == null)
            {
                return RedirectToAction("Login", "Authentication");
            }
            using (PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                string date;
                if (!string.IsNullOrEmpty(weekNumber))
                {
                    int castWeekNumber = Convert.ToInt32(weekNumber);
                    date = getWeeks(castWeekNumber);
                    ViewBag.selectedWeek = date;
                    ViewBag.datesInWeek = getWeekDates(castWeekNumber);
                }
                else
                {
                    date = GetCurrentDateWeek();
                    ViewBag.selectedWeek = date;
                    int currentWeek = GetCurrentWeek();
                    ViewBag.datesInWeek = getWeekDates(currentWeek);
                }
                string[] dates = date.Split("-");
                string date1 = dates[0].Trim();
                string date2 = dates[1].Trim();
                DateTime startDate = DateTime.ParseExact(date1, "dd/MM/yyyy", null);
                DateTime endDate = DateTime.ParseExact(date2, "dd/MM/yyyy", null);
                var groupData = (from g in context.Groups
                                 join c in context.Courses on g.CourseId equals c.CourseId
                                 join ses in context.Sessions on g.GroupId equals ses.GroupId
                                 join t in context.TimeSlots on ses.TimeSlotId equals t.TimeSlotId
                                 join r in context.Rooms on ses.RoomId equals r.RoomId
                                 join i in context.Instructors on ses.InstructorId equals i.InstructorId
                                 where ses.Date >= startDate && ses.Date <= endDate
                                 select new
                                 {
                                     SessionID = ses.SessionId,
                                     Date = ses.Date,
                                     GroupID = g.GroupId,
                                     GName = g.Gname,
                                     CourseID = c.CourseId,
                                     CName = c.Cname,
                                     Code = c.Code,
                                     RoomID = r.RoomId,
                                     RName = r.Rname,
                                     InstructorID = i.InstructorId,
                                     InstructorRollNumber = i.InstructorRollNumber,
                                     InstructorName = i.InstructorName,
                                     TimeSlotID = t.TimeSlotId,
                                     TimeFrom = t.TimeFrom,
                                     TimeTo = t.TimeTo,
                                     sesStatus = ses.Status,
                                 }).ToList();
                var timeSlot = context.TimeSlots.ToList();
                int InstructorID = (int)HttpContext.Session.GetInt32("InstructorID");
                var instructor = context.Instructors.SingleOrDefault(i => i.InstructorId == InstructorID);
                ViewBag.timeSlot = timeSlot;
                ViewBag.instructor = instructor;
                ViewBag.data = groupData;
                ViewBag.weekDates = getWeeksInYear(2023);

                string currentDate = GetCurrentDate();
                ViewBag.currentDate = currentDate;

                ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
                ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
                return View();
            }
        }
        private int GetCurrentWeek()
        {
            CultureInfo culture = CultureInfo.CurrentCulture;
            Calendar calendar = culture.Calendar;

            DateTime currentDate = DateTime.Now;
            int currentWeek = calendar.GetWeekOfYear(currentDate, culture.DateTimeFormat.CalendarWeekRule, culture.DateTimeFormat.FirstDayOfWeek);

            return currentWeek;
        }


        private string GetCurrentDate()
        {
            return DateTime.Now.ToString("dd/MM/yyyy");
        }

        private List<string> getWeeksInYear(int year)
        {
            DateTime startDate = new DateTime(year, 1, 1);
            DateTime endDate = new DateTime(year + 1, 1, 1).AddDays(-1);

            DateTime currentDate = startDate;
            List<String> datesOfWeek = new List<String>();

            while (currentDate <= endDate)
            {
                string weekDates = currentDate.ToString("dd/MM/yyyy") + " - " + currentDate.AddDays(6).ToString("dd/MM/yyyy");
                datesOfWeek.Add(weekDates);
                currentDate = currentDate.AddDays(7);
            }
            return datesOfWeek;
        }

        private string GetCurrentDateWeek()
        {
            CultureInfo culture = CultureInfo.CurrentCulture;
            Calendar calendar = culture.Calendar;

            DateTime currentDate = DateTime.Now;
            int currentWeek = calendar.GetWeekOfYear(currentDate, culture.DateTimeFormat.CalendarWeekRule, culture.DateTimeFormat.FirstDayOfWeek);
            DateTime startOfYear = new DateTime(2023, 1, 1);
            DateTime startDate = startOfYear.AddDays((currentWeek - 1) * 7);
            DateTime endDate = startDate.AddDays(6);
            string date = startDate.ToString("dd/MM/yyyy") + " - " + endDate.ToString("dd/MM/yyyy");
            return date;
        }

        private string getWeeks(int weekNumber)
        {
            int year = 2023;
            DateTime startOfYear = new DateTime(year, 1, 1);
            DateTime startDate = startOfYear.AddDays((weekNumber - 1) * 7);

            string date = startDate.ToString("dd/MM/yyyy") + " - " + startDate.AddDays(6).ToString("dd/MM/yyyy");
            return date;
        }

        private List<string> getWeekDates(int weekNumber)
        {
            int year = 2023;
            DateTime startOfYear = new DateTime(year, 1, 1);
            DateTime startDate = startOfYear.AddDays((weekNumber - 1) * 7);
            List<string> weekDates = new List<string>();
            for (int i = 0; i < 6; i++)
            {
                DateTime nextDate = startDate.AddDays(i);
                string date = nextDate.ToString("dd/MM/yyyy");
                weekDates.Add(date);
            }
            return weekDates;
        }

        public IActionResult TakeAttend(string id)
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext()) 
            {
                List<Attendance> attendances = context.Attendances
                                  .Include(a => a.Student)
                                  .Where(a => a.Sesid == Convert.ToInt32(id))
                                  .ToList();
                bool isAdd = true;
                foreach(Attendance attendance in attendances)
                {
                    if(attendance.Status != null)
                    {
                        isAdd = false;
                    }
                }
                ViewBag.isAdd = isAdd;
                ViewBag.sessionID = id;

                ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
                ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
                return View(attendances);
            }           
        }

        public IActionResult ViewAttendances(string id)
        {
            using (PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                List<Attendance> attendances = context.Attendances
                                  .Include(a => a.Student)
                                  .Where(a => a.Sesid == Convert.ToInt32(id))
                                  .ToList();
                bool isAdd = true;
                foreach (Attendance attendance in attendances)
                {
                    if (attendance.Status != null)
                    {
                        isAdd = false;
                    }
                }
                ViewBag.isAdd = isAdd;
                ViewBag.sessionID = id;

                ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
                ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
                return View(attendances);
            }
        }

        [HttpPost]
        public IActionResult TakeAttend(List<Attendance> attendances,string id)
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                foreach (Attendance attendance in attendances)
                {
                    attendance.Sesid = Convert.ToInt32(id);  
                    if(attendance.Aid == null)
                    {
                        context.Attendances.Add(attendance);
                    }else
                    {
                        var attend = context.Attendances.FirstOrDefault(a => a.Aid == attendance.Aid);
                        context.Attendances.Remove(attend);
                        context.Attendances.Add(attendance);
                    }
                }
                int sesID = Convert.ToInt32(id);
                Session session = context.Sessions.FirstOrDefault(s => s.SessionId == sesID);
                session.Status = true;
                context.SaveChanges();
                attendances = context.Attendances
                                  .Include(a => a.Student)
                                  .Where(a => a.Sesid == Convert.ToInt32(id))
                                  .ToList();
                ViewBag.sessionID = id;

                ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
                ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
                return RedirectToAction("TimeTable");
            }
        }

        public IActionResult AttendanceManagement()
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                int InstructorID = (int)HttpContext.Session.GetInt32("InstructorID");
                var session = context.Sessions
                                     .Include(s => s.Group)
                                     .Include(s => s.Room)
                                     .Where(s => s.InstructorId == InstructorID && s.Status == true)
                                     .ToList();
                ViewBag.session = session;
                return View();
            }           
        }

        public IActionResult GroupReport(string selectedGroup)
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                int InstructorID = (int)HttpContext.Session.GetInt32("InstructorID");
                var groups = (from gr in context.Groups
                                   where gr.InstructorId == InstructorID
                                   select new
                                   {
                                       groupID = gr.GroupId,
                                       groupName = gr.Gname
                                   }).ToList();
                int groupID = 0;
                if (!string.IsNullOrEmpty(selectedGroup))
                {
                     groupID = Convert.ToInt32(selectedGroup);
                }
                var sessions = context.Sessions.Where(ses => ses.InstructorId == InstructorID).ToList();
                var students = context.Students
                                      .Include(s => s.Groups.Where(gr => gr.GroupId == groupID)).ToList();
                var attendances = context.Attendances
                                         .Include(a => a.Ses)
                                         .ToList();
                ViewBag.sessions = sessions;
                ViewBag.attendances = attendances;
                ViewBag.selectedCourse = groupID;
                ViewBag.students = students;
                ViewBag.groups = groups;

                ViewBag.InstructorName = HttpContext.Session.GetString("InstructorName");
                ViewBag.InstructorRollNumber = HttpContext.Session.GetString("InstructorRollNumber");
                return View();
            }
        }
    }
}

