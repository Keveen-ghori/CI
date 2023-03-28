using System;
using System.Collections.Generic;

namespace CommunityInvestment.Models.Models;

public partial class ResetPassword
{
    public string Email { get; set; } = null!;

    public string Token { get; set; } = null!;

    public DateTime CreatedAt { get; set; }
}
