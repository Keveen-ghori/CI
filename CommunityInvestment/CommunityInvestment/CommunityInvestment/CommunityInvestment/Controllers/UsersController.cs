using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using CommunityInvestment.Data;
using System.Web.Helpers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Net.Mail;
using System.Net;
using CommunityInvestment.Models.Models;
using System.Web;
using MimeKit;
using Microsoft.AspNet.Http;
using Microsoft.AspNetCore.Http;

namespace CommunityInvestment.Controllers
{

    //[Authorize(AuthenticationSchemes = Microsoft.AspNetCore.Authentication.JwtBearer.JwtBearerDefaults.AuthenticationScheme)]
    public class UsersController : Controller
    {
        private readonly CiContext _context;

        public UsersController(CiContext context)
        {
            _context = context;
        }


        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Index(User s)

        {


            var Data = _context.Users.FirstOrDefault(model => model.Email == s.Email);

            if (Data == null)
            {
                ViewBag.ErrorMessage = "Login Failed";
                return View();
            }

            if (!Crypto.VerifyHashedPassword(Data.Password, s.Password))
            {
                ViewBag.ErrorMessage = "Login Failed";
                return View();
            }
            else
            {
                HttpContext.Session.SetString("email", s.Email);
                HttpContext.Session.SetString("UserId", Data.UserId.ToString());
                HttpContext.Session.SetString("Username", Data.FirstName + ' ' +Data.SecondName);
                return RedirectToAction("Index", "Home");

            }

        }



        public IActionResult Create()
        {

            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(User user)
        {

            var data = _context.Users.Where(model => model.Email == user.Email).FirstOrDefault();
            if (data != null)
            {
                ViewBag.ErrorMessage = "Email is Exists. Enter Other Email";
                return View();
            }

            else
            {
                if (user != null)
                {
                    user.CityId = 1;
                    user.CountryId = 1;
                    var pass = user.Password;
                    if (pass == null)
                    {
                        return RedirectToAction("Create");
                    }
                    user.Password = Crypto.HashPassword(user.Password);
                    _context.Users.Add(user);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                TempData["Failed"] = "Registration Failed";
                return View(user);
            }


        }


        public IActionResult Forgot()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public IActionResult Forgot(string email, ResetPassword u)
        {


            var user = _context.Users.FirstOrDefault(model => model.Email == email);
            if (user == null)
            {
                ViewBag.ErrorMessage = "Email not Exists. Register Account";
                return View();
            }


            else
            {

                string jwtToken = string.Empty;

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes("MyJwtKeyForPasswordReset");
                var tokenDescription = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                        new Claim(ClaimTypes.Email, u.Email),
                    }),
                    Expires = DateTime.UtcNow.AddMinutes(4),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                };

                var token = tokenHandler.CreateToken(tokenDescription);
                u.Token = tokenHandler.WriteToken(token);

                string tokenString = u.Token;
                u.CreatedAt = DateTime.Now.AddMinutes(4);

                _context.ResetPasswords.Add(u);
                _context.SaveChanges();

                var smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential("keveenjghori@gmail.com", "qvkuwajuqxprmjve"),
                    EnableSsl = true,
                };

                var resetLink = "< a href = '" + Url.Action("PasswordReset", "Users", new { email = email, code = u.Token }, "https") + "' > Reset Password </ a >";
                var mailMessage = new MailMessage
                {
                    From = new MailAddress("keveenjghori@gmail.com"),
                    Subject = "Your changed password",
                    Body = "Please find the Password Reset Link." + resetLink,
                    IsBodyHtml = true,
                };

                mailMessage.To.Add("kjghori3@gmail.com");

                smtpClient.Send(mailMessage);
                TempData["error"] = "Link Sends to your account";


                return View();
            }
        }


        [AllowAnonymous]
        //[Authorize(AuthenticationSchemes = Microsoft.AspNetCore.Authentication.JwtBearer.JwtBearerDefaults.AuthenticationScheme)]
        public IActionResult PasswordReset(string email, string code, ResetPassword u)
        {
            var resetPassword = _context.ResetPasswords
        .FirstOrDefault(r => r.Email == u.Email && r.Token == u.Token);

            if (resetPassword != null && resetPassword.CreatedAt > DateTime.UtcNow)
            {
                return View();
            }

            ViewBag.Message = "Invalid Password Reset Link";
            return RedirectToAction("Forgot");

        }

        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult PasswordReset(string email, string token, User u)
        {
            var resetPassword = _context.ResetPasswords
                .FirstOrDefault(r => r.Email == email && r.Token == token);


            if (resetPassword == null && resetPassword.CreatedAt < DateTime.UtcNow)
            {
                ViewBag.Message = "Invalid Password Reset Link";
                return View("Forgot");
            }

            var user = _context.Users.FirstOrDefault(u => u.Email == email);

            if (user == null)
            {
                ViewBag.Message = "Invalid Password Reset Link";
                return View("Forgot");
            }

            user.Password = Crypto.HashPassword(u.Password);
            user.UpdatedAt = DateTime.UtcNow;
            _context.Users.Update(user);
            _context.ResetPasswords.Remove(resetPassword);
            _context.SaveChanges();

            return RedirectToAction("Index", "User");


        }


        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Users");
        }



    }
}
