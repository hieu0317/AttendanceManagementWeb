using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN211_Asssignment.Models;
using System.Text.Json;

namespace PRN211_Project.Controllers
{
    public class AuthenticationController : Controller
    {
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(User user)
        {
            using(PRJ_ProjectContext context = new PRJ_ProjectContext()) {
                User authenUser = new User();
                authenUser = context.Users
                    .Include(u => u.Student)
                    .Include(i => i.Instructor)
                    .SingleOrDefault(u => u.Username == user.Username
                && u.Password == user.Password);
                if (authenUser == null)
                {
                    ViewBag.Err = "username or password is invalid!";
                    return View();
                }
                else if (authenUser.IsStudent == false)
                {
                    setInstructor(authenUser);
                    return RedirectToAction("Home", "Instructor");
                }
                else
                {
                    setStudent(authenUser);
                    return RedirectToAction("Home", "Student");
                }
            }
        }


        public IActionResult LogOut()
        {
            removeUser();
            return RedirectToAction("Login");
        }

        public void setStudent(User user)
        {
            HttpContext.Session.SetInt32("StudentID",user.Student.StudentId);
            HttpContext.Session.SetString("StudentName", (user.Student.LastName + " " + user.Student.FirstName));
            HttpContext.Session.SetString("StudentRollNumber", user.Student.StudentRollNumber);
            HttpContext.Session.SetString("Campus", user.Campus);

        }

        public void setInstructor(User user)
        {
            HttpContext.Session.SetInt32("InstructorID", user.Instructor.InstructorId);
            HttpContext.Session.SetString("InstructorName", user.Instructor.InstructorName);
            HttpContext.Session.SetString("InstructorRollNumber", user.Instructor.InstructorRollNumber);
        }

        public void removeUser()
        {
            HttpContext.Session.Remove("StudentName");
            HttpContext.Session.Remove("StudentRollNumber");
            HttpContext.Session.Remove("Campus");
        }
    }

}
