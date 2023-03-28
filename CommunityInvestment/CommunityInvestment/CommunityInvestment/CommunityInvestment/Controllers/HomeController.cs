using CommunityInvestment.Data;
using CommunityInvestment.Models;
using CommunityInvestment.Models.Models;
using CommunityInvestment.Models.spModels;
using CommunityInvestment.Models.ViewModel;
using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.InkML;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace CommunityInvestment.Controllers
{
    public class HomeController : Controller
    {
        private readonly CiContext _d;
        private readonly string connectionString = @"server=PCI101\SQL2019;Database=CI;User Id=sa;Password=Tatva@123;Trusted_connection=SSPI;Encrypt=false;TrustServerCertificate=True";
        public HomeController(CiContext d)
        {
            _d = d;
        }

        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("email") == null)
            {

                return RedirectToAction("Index", "Users");
            }
            else
            {
                FilterViewModel filterViewModel = new();

                filterViewModel.Country = GetAllCountry();
                filterViewModel.MissionTheme = GetAllTheme();
                filterViewModel.Skill = GetAllSkill();
                var userId = HttpContext.Session.GetString("UserId");

                List<SpFilterModel> model = _d.GetMissions.FromSqlInterpolated($@"Exec FilterMissions @loggedInUserId = {userId}, @pageNumber = {1}, @pageSize = {6}").ToList();


              
                filterViewModel.Filters = model;

                return View(filterViewModel);
            }

        }


        public List<SelectListItem> GetAllCountry()
        {
            return _d.Countries.ToList().Select(
                        c => new SelectListItem
                        {
                            Text = c.Name,
                            Value = c.CountryId.ToString(),
                        }).ToList();
        }

        public List<SelectListItem> GetAllSkill()
        {
            return _d.Skills.ToList().Select(
                       c => new SelectListItem
                       {
                           Text = c.SkillName,
                           Value = c.SkillId.ToString(),
                       }
                   ).ToList();
        }

        public List<SelectListItem> GetAllTheme()
        {
            return _d.Themes.ToList().Select(
                       c => new SelectListItem
                       {
                           Text = c.Title,
                           Value = c.ThemeId.ToString(),
                       }
                   ).ToList();
        }





        public IActionResult Filter(string countryId)
        {

            List<long> countryIds = new List<long>();

            if (!string.IsNullOrEmpty(countryId))
            {
                countryIds = countryId.Split(',')
                                      .Where(s => !string.IsNullOrEmpty(s))
                                      .Select(s => (long)Convert.ToDouble(s))
                                      .ToList();
            }

            List<SelectListItem> cityList = new List<SelectListItem>();

            if (countryIds.Any())
            {
                cityList = _d.Cities
                              .Where(c => countryIds.Contains(c.CountryId))
                              .Select(c => new SelectListItem
                              {
                                  Text = c.Name,
                                  Value = c.CityId.ToString()
                              })
                              .ToList();
            }

            return Json(cityList);


        }


        public IActionResult Mission(string cityId, string skillId, string themeId, string keyword, string sortBy)
        {
            FilterViewModel filterViewModel = new();

            var userId = HttpContext.Session.GetString("UserId");
            List<SpFilterModel> model = _d.GetMissions.FromSqlInterpolated($@"Exec FilterMissions @loggedInUserId = {userId}, @pageNumber = {1}, @pageSize = {6}, @title={keyword}, @cityIds={cityId}, @skillIds={skillId},@themeIds={themeId}").ToList();

            if (model == null || model.Count == 0)
            {
                filterViewModel.Filters = new List<SpFilterModel>();
                return PartialView("NotFound");
            }
            filterViewModel.Filters = model;

            filterViewModel.missionCount = _d.Missions.AsQueryable().Count();
            return PartialView("_MissionsPartial", filterViewModel);
        }


        public IActionResult PlatformDetails(long missionId)
        {

            MissionDetails missionDetails = new();

            using (SqlConnection connection = new(connectionString))
            {
                var userId = HttpContext.Session.GetString("UserId");
                connection.Open();

                using (SqlCommand cmdRating = new("spMissionRating", connection))
                {
                    cmdRating.CommandType = CommandType.StoredProcedure;
                    cmdRating.CommandTimeout = 120;
                    using (SqlDataAdapter adapter = new(cmdRating))
                    {
                        cmdRating.Parameters.AddWithValue("@missionId", missionId);
                        try
                        {
                            DataSet ds = new();
                            adapter.Fill(ds);
                            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                            {

                                missionDetails.Rating = ds.Tables[0].Rows[0]["Mission Rating"] == DBNull.Value ? null : (int?)ds.Tables[0].Rows[0]["Mission Rating"];
                                missionDetails.UserCount = (int)ds.Tables[0].Rows[0]["User Count"];
                            }
                            cmdRating.ExecuteNonQuery();

                        }
                        catch (Exception)
                        {
                            connection.Close();
                        }
                    }
                }

                using (SqlCommand cmd = new("spMissionDetails", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 120;
                    using (SqlDataAdapter adapter = new(cmd))
                    {
                        cmd.Parameters.AddWithValue("@missionId", missionId);
                        cmd.Parameters.AddWithValue("@userId", userId);
                        
                        cmd.Parameters.Add("@addToFavorites", SqlDbType.Bit).Value = DBNull.Value;
                        cmd.Parameters.Add("@removeFromFavorites", SqlDbType.Bit).Value = DBNull.Value;
                        try
                        {
                            DataSet ds = new();
                            adapter.Fill(ds);
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                               
                                missionDetails.MissionId = (long)ds.Tables[0].Rows[0]["Mission_id"];
                                missionDetails.Title = (string)ds.Tables[0].Rows[0]["Title"];
                                missionDetails.Short_Description = (string)ds.Tables[0].Rows[0]["Short_Description"];
                                missionDetails.Description = (string)ds.Tables[0].Rows[0]["Description"];
                                missionDetails.Mission_type = (bool)ds.Tables[0].Rows[0]["Mission_type"];
                                missionDetails.Start_Date = (DateTime)ds.Tables[0].Rows[0]["Start_Date"];
                                missionDetails.End_Date = (DateTime)ds.Tables[0].Rows[0]["End_Date"];
                                missionDetails.CityName = (string)ds.Tables[0].Rows[0]["CityName"];
                                missionDetails.goal_objective_text = ds.Tables[0].Rows[0]["goal_objective_text"] == DBNull.Value ? "" : (string)ds.Tables[0].Rows[0]["goal_objective_text"];
                                
                                missionDetails.goal_value = ds.Tables[0].Rows[0]["goal_value"] == DBNull.Value ? null : (int?)ds.Tables[0].Rows[0]["goal_value"]; ;
                                missionDetails.from_user_id = ds.Tables[0].Rows[0]["from_user_id"] == DBNull.Value ? null : (long?)ds.Tables[0].Rows[0]["from_user_id"];
                                missionDetails.to_user_id = ds.Tables[0].Rows[0]["to_user_id"] == DBNull.Value ? null : (long?)ds.Tables[0].Rows[0]["to_user_id"];
                                missionDetails.Rating = ds.Tables[0].Rows[0]["Rating"] == DBNull.Value ? null : (int?)ds.Tables[0].Rows[0]["Rating"];
                                missionDetails.Organization_name = ds.Tables[0].Rows[0]["Organization_name"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["Organization_name"];
                                missionDetails.Organization_detail = ds.Tables[0].Rows[0]["Organization_detail"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["Organization_detail"];
                                missionDetails.ThemeTitle = (string)ds.Tables[0].Rows[0]["ThemeTitle"];
                                missionDetails.Comment_id = ds.Tables[0].Rows[0]["Comment_id"] == DBNull.Value ? null : (long?)ds.Tables[0].Rows[0]["Comment_id"];
                                missionDetails.comment_text = ds.Tables[0].Rows[0]["comment_text"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["comment_text"];


                                List<string> skills = ds.Tables[0].AsEnumerable()
                                     .Select(row => row.Field<string>("skill_name"))
                                     .Where(name => !string.IsNullOrEmpty(name))
                                     .ToList();
                                missionDetails.skill_name = skills;
                                //ds.Tables[0].Rows[0]["skill_name"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["skill_name"]

                                missionDetails.media_name = ds.Tables[0].Rows[0]["media_name"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["media_name"];
                                missionDetails.media_path = ds.Tables[0].Rows[0]["media_path"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["media_path"];
                                missionDetails.media_type = ds.Tables[0].Rows[0]["media_type"] == DBNull.Value ? "" : (string?)ds.Tables[0].Rows[0]["media_type"];
                                missionDetails.is_applied = Convert.ToBoolean(ds.Tables[0].Rows[0]["is_applied"]);
                                missionDetails.Availability = Convert.ToBoolean(ds.Tables[0].Rows[0]["Availability"]);
                                missionDetails.is_favorite = Convert.ToBoolean(ds.Tables[0].Rows[0]["is_favorite"]);
                                missionDetails.Max_seats = ds.Tables[0].Rows[0]["Max_seats"] == DBNull.Value ? null : (int?)ds.Tables[0].Rows[0]["Max_seats"];
                                missionDetails.filled_seats = ds.Tables[0].Rows[0]["filled_seats"] == DBNull.Value ? null : (int?)ds.Tables[0].Rows[0]["filled_seats"];
                               

                            }
                            connection.Close();
                            return View(missionDetails);
                        }
                        catch (Exception)
                        {
                            connection.Close();
                        }
                    }
                }

                using (SqlCommand cmdFav = new("spMissionFav", connection))
                {
                    cmdFav.CommandType = CommandType.StoredProcedure;
                    cmdFav.CommandTimeout = 120;
                    using (SqlDataAdapter adapter = new(cmdFav))
                    {
                        cmdFav.Parameters.AddWithValue("@missionId", missionId);
                        try
                        {
                            DataSet ds = new();
                            adapter.Fill(ds);
                            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                            {

                                missionDetails.is_favorite = Convert.ToBoolean(ds.Tables[0].Rows[0]["is_favorite"]);
                            }
                            cmdFav.ExecuteNonQuery();

                        }
                        catch (Exception)
                        {
                            connection.Close();
                        }
                    }
                }
            }


            return View();



        }

        public IActionResult NotFound()
        {
            return View();
        }


        public IActionResult Comments(long missionId)
        {
            var userId = HttpContext.Session.GetString("UserId");
            var mission = _d.Missions.Find(missionId);
            MissionDetails missionDetails = new();
            missionDetails.Comments = _d.Comments.Where(c => c.MissionId == missionId).Select(
                cf => new Comment
                {
                    CommentId = cf.CommentId,
                    UserId = cf.UserId
                }).ToList();
            return View("_Comments", missionDetails);
        }

        [HttpPost]
        public IActionResult RemoveFromFavorites(long missionId)
        {
            var userId = HttpContext.Session.GetString("UserId");
            var favoriteMission = _d.FavouritMissions.FirstOrDefault(fm => fm.UserId.ToString() == userId && fm.MissionId == missionId);
            if (favoriteMission != null)
            {
                _d.FavouritMissions.Remove(favoriteMission);
                _d.SaveChanges();
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public IActionResult addToFavorites(long missionId)
        {
            var userId = Convert.ToInt64(HttpContext.Session.GetString("UserId"));


            var favoriteMission = _d.FavouritMissions.Where(fm => fm.MissionId == missionId && fm.UserId == userId).FirstOrDefault();

            if (favoriteMission == null)
            {
         
                // Add the mission to the favorite list
                _d.FavouritMissions.Add(new FavouritMission { UserId = userId, MissionId = missionId });
                _d.SaveChanges();

                return Json(new { success = true });
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public IActionResult RateMission(long missionId, int rating)
        {
            try
            {
                // Save the rating in the database
                _d.MissionRatings.Add(new MissionRating { MissionId = missionId, Rating = rating });
                _d.SaveChanges();

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

    }

}