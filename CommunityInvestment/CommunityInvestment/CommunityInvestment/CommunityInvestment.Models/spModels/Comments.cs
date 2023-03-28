using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Models.spModels
{
    public class Comments
    {
        public long CommentId { get; set; }
        public string? CommentText { get; set; }
        public string? Avatar { get; set; }
        public string? FirstName { get; set; }
        public string? SecondName { get; set; }
        public DateTime Created_Date { get; set; }
    }
}
