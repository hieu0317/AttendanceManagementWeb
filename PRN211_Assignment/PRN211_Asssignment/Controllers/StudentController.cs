using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN211_Asssignment.Models;
using System.Globalization;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace PRN211_Project.Controllers
{
    public class StudentController : Controller
    {
        public IActionResult Home()
        {
            if(HttpContext.Session.GetString("StudentID") == null)
            {
                return RedirectToAction("Login","Authentication");
            }

            ViewBag.StudentName = HttpContext.Session.GetString("StudentName");
            ViewBag.StudentRollNumber = HttpContext.Session.GetString("StudentRollNumber");
            ViewBag.Campus = HttpContext.Session.GetString("Campus");
            return View();
        }

        public IActionResult TimeTable(string weekNumber)
        {
            if (HttpContext.Session.GetString("StudentName") == null)
            {
                return RedirectToAction("Login", "Authentication");
            }
            using(PRJ_ProjectContext context = new PRJ_ProjectContext())
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
                DateTime startDate = DateTime.ParseExact(date1,"dd/MM/yyyy", null);
                DateTime endDate = DateTime.ParseExact(date2, "dd/MM/yyyy", null);
                var groupData = (from g in context.Groups
                                   join c in context.Courses on g.CourseId equals c.CourseId
                                   join ses in context.Sessions on g.GroupId equals ses.GroupId
                                   join t in context.TimeSlots on ses.TimeSlotId equals t.TimeSlotId
                                   join r in context.Rooms on ses.RoomId equals r.RoomId
                                   join a in context.Attendances on ses.SessionId equals a.Sesid
                                   join i in context.Instructors on ses.InstructorId equals i.InstructorId
                                   where ses.Date >= startDate && ses.Date <= endDate
                                   select new
                                   {
                                       SessionID = ses.SessionId,
                                       Date = ses.Date,
                                       Aid = a.Aid,
                                       Status = a.Status,
                                       Description = a.Description,
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
                                       TimeTo = t.TimeTo
                                   }).ToList();
                var timeSlot = context.TimeSlots.ToList();
                int studentID = (int)HttpContext.Session.GetInt32("StudentID");
                var student = context.Students
                              .Include(s => s.Groups)
                              .Include(s => s.Attendances)
                              .SingleOrDefault(s => s.StudentId == studentID);
                ViewBag.timeSlot = timeSlot;
                ViewBag.student = student;
                ViewBag.data = groupData;
                ViewBag.weekDates = getWeeksInYear(2023);

                
                ViewBag.StudentName = HttpContext.Session.GetString("StudentName");
                ViewBag.StudentRollNumber = HttpContext.Session.GetString("StudentRollNumber");
                ViewBag.Campus = HttpContext.Session.GetString("Campus");
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



        public IActionResult StudentAttendanceReport(string selectedCourse)
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext())
            {
                int studentID = (int)HttpContext.Session.GetInt32("StudentID");
                int courseID = 0;
                if(selectedCourse != null) {
                    courseID = Convert.ToInt32(selectedCourse);
                }
                var sessions = context.Sessions
                                      .Where(ses => ses.Group.CourseId == courseID)
                                      .Include(ses => ses.TimeSlot)
                                      .Include(ses => ses.Group)
                                      .Include(ses => ses.Room)
                                      .Include(ses => ses.Attendances.Where(a => a.Sid == studentID))
                                      .Include(ses => ses.Group.Instructor)
                                      .ToList();
                ViewBag.sessions = sessions;
                ViewBag.selectedCourse = courseID;
                var courses = context.Courses.ToList();
                ViewBag.courses = courses;

                ViewBag.StudentName = HttpContext.Session.GetString("StudentName");
                ViewBag.StudentRollNumber = HttpContext.Session.GetString("StudentRollNumber");
                ViewBag.Campus = HttpContext.Session.GetString("Campus");
                return View();
            }
        }
    }
}
