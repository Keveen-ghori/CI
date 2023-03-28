using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Models.spModels
{
    public class SpFilterModel
    {
        public long Mission_id { get; set; }
        public long Theme_id { get; set; }
        public long City_id { get; set; }
        public long Country_id { get; set; }
        public string? Title { get; set; }
        public string? Short_Description { get; set; }
        public string? Description { get; set; }
        public DateTime Start_Date { get; set; }
        public DateTime End_Date { get; set; }
        public bool Mission_type { get; set; }
        public bool Status { get; set; }
        public string? Organization_name { get; set; }
        public string? Organization_detail { get; set; }
        public bool Availability { get; set; }
        
        public int? Max_seats { get; set; }
        public int? Filled_seats { get; set; }
        public string? CityName { get; set; }
        public string? SKillName { get; set; }
        public string? ThemeTitle { get; set; }
        public int is_applied { get; set; }
        public bool is_fav { get; set; }
        public long RowNum { get; set; }

        public int Ratings { get; set; }

    }
}