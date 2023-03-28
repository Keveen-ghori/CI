using CommunityInvestment.Models.Models;
using CommunityInvestment.Models.spModels;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Models.ViewModel
{
    public class FilterViewModel
    {

        public List<SelectListItem> Country
        {
            get; set;
        } = null!;

        public List<SelectListItem>? City { get; set; }
        public List<SelectListItem>? Skill { get; set; }
        public List<SelectListItem>? MissionTheme { get; set; }
        public List<Mission> mission { get; set; } = null!;
        public Theme theme { get; set; }
        public MissionRating? missionRating { get; set; }

        public GoalMission? goalMission { get; set; }
        public FavouritMission? favouritMission { get; set; }

        public MissionInvite? missionInvite { get; set; }

        public int? missionCount { get; set; }
        public List<SpFilterModel> Filters { get; set; }

        public int Ratings { get; set; }
    }
}
