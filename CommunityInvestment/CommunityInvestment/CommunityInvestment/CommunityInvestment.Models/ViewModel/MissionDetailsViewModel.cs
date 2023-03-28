using CommunityInvestment.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Models.ViewModel
{
    public class MissionDetailsViewModel
    {
        public long MissionId { get; set; }
        public string Title { get; set; }
        public string ShortDescription { get; set; }
        public string Description { get; set; }
        public bool MissionType { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string CityName { get; set; }
        public string? GoalObjectiveText { get; set; }
        public decimal? GoalValue { get; set; }
        public long UserId { get; set; }
        public long FromUserId { get; set; }
        public long ToUserId { get; set; }
        public int Rating { get; set; }
        public string OrganizationName { get; set; }
        public string OrganizationDetail { get; set; }
        public string ThemeTitle { get; set; }
        public long CommentId { get; set; }
        public string CommentText { get; set; }
        public int Status { get; set; }
        public string MediaName { get; set; }
        public string MediaPath { get; set; }
        public string MediaType { get; set; }
        public bool IsApplied { get; set; }
        public bool IsFavorite { get; set; }
        public bool IsApprove { get; set; }
        public int MaxSeats { get; set; }
        public Mission mission { get; set; }
        public List<string> Skills { get; set; }
        public GoalMission Finalgoal { get; set; }
        public bool IsGoalMission { get; set; }
      
    }
}
