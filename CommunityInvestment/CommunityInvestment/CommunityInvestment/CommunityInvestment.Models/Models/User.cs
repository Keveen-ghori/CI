using CommunityInvestment.Models.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CommunityInvestment.Models.Models;

public partial class User
{
    public long UserId { get; set; }

    [DisplayName("First Name")]
    [Required(ErrorMessage = "First Name Required")]
    public string? FirstName { get; set; }

    [DisplayName("Last Name")]
    public string? SecondName { get; set; }

    [DisplayName("Email Address")]
    [Required(ErrorMessage = "Email is Required")]
    [DataType(DataType.EmailAddress)]
    public string Email { get; set; } = null!;

    [Required(ErrorMessage = "Password is Required")]
    [DataType(DataType.Password)]
    [MinLength(8)]
    public string Password { get; set; } = null!;

    [DisplayName("Phone Number")]
    [Required(ErrorMessage = "Phone Number is Required")]
    [DataType(DataType.PhoneNumber)]
    public long PhoneNumber { get; set; }

    public string? Avatar { get; set; }

    [DisplayName("Why I Volunteer?")]
    public string? WhyIVolunteer { get; set; }

    public string? EmployeeId { get; set; }

    public string? Department { get; set; }

    public long CityId { get; set; }

    public long CountryId { get; set; }

    public string? ProfileText { get; set; }

    public string? LinkedInUrl { get; set; }

    public string? Title { get; set; }

    public bool? Status { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual City City { get; set; } = null!;

    public virtual Country Country { get; set; } = null!;

    public virtual ICollection<FavouritMission> FavouritMissions { get; } = new List<FavouritMission>();

    public virtual ICollection<MissionApplication> MissionApplications { get; } = new List<MissionApplication>();

    public virtual ICollection<MissionInvite> MissionInviteFromUsers { get; } = new List<MissionInvite>();

    public virtual ICollection<MissionInvite> MissionInviteToUsers { get; } = new List<MissionInvite>();

    public virtual ICollection<MissionRating> MissionRatings { get; } = new List<MissionRating>();

    public virtual ICollection<Story> Stories { get; } = new List<Story>();

    public virtual ICollection<StotyInvite> StotyInviteFromUsers { get; } = new List<StotyInvite>();

    public virtual ICollection<StotyInvite> StotyInviteToUsers { get; } = new List<StotyInvite>();

    public virtual ICollection<Timesheet> Timesheets { get; } = new List<Timesheet>();

    public virtual ICollection<UserSkill> UserSkills { get; } = new List<UserSkill>();
}
