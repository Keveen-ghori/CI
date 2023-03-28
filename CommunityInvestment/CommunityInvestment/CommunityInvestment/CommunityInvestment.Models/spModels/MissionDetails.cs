using CommunityInvestment.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Models.spModels
{
    public class MissionDetails
    {
        public long MissionId { get; set; }
        public string Title { get; set; }
        public string Short_Description { get; set; }
        public string Description { get; set; }
        public bool Mission_type { get; set; }
        public DateTime Start_Date { get; set; }
        public DateTime End_Date { get; set; }
        public string CityName { get; set; }
        public string goal_objective_text { get; set; }
        public int? goal_value { get; set; }
        public long User_id { get; set; }
        public long? from_user_id { get; set; }
        public long? to_user_id { get; set; }
        public int? Rating { get; set; }
        public string? Organization_name { get; set; }
        public string? Organization_detail { get; set; }
        public string ThemeTitle { get; set; }
        public long? Comment_id { get; set; }
        public string comment_text { get; set; }
        public List<string> skill_name { get; set; }

        public string? media_name { get; set; }
        public string? media_path { get; set; }
        public string? media_type { get; set; }
        public bool is_applied { get; set; }
        public bool is_favorite { get; set; }
        public int? Max_seats { get; set; }
        public int? filled_seats { get; set; }
        public List<Skill> skills { get; set; }
        
        public List<Comment> Comments { get; set; }
        public bool Availability { get; set; }

        public int? UserCount { get; set; }
    }
}
