--Switch to CI Database
USE CI;
GO


--ADMIN Table
CREATE TABLE Admin(
	Admin_id bigint IDENTITY(1,1) NOT NULL PRIMARY KEY CHECK (admin_id >=0 ),
	First_name varchar(16) NULL,
	Last_name varchar(16) NULL,
	Email varchar(128) NOT NULL UNIQUE,
	Password varchar(255) NOT NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--BANNER Table
CREATE TABLE Banner(
	Banner_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Banner_id >=0),
	Image varchar(512) NOT NULL,
	Text text,
	Sort_Order int DEFAULT 0,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--COUNTRY Table
CREATE TABLE Country(
	Country_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Country_id >=0),
	Name varchar(255) NOT NULL,
	ISO varchar(16) NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--CITY Table
CREATE TABLE City(
	City_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(City_id >=0),
	Country_id bigint NOT NULL CHECK(Country_id >=0),
	Name varchar(255) NOT NULL,
	FOREIGN KEY (Country_id) REFERENCES Country(Country_id),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--USER Table
CREATE TABLE Users(
	User_id bigint NOT NULL PRIMARY KEY IDENTITY(1,1) CHECK(User_id >=0),
	First_name varchar(16) NULL,
	Second_name varchar(16) NULL,
	Email varchar(128) NOT NULL UNIQUE,
	Password varchar(255) NOT NULL,
	Phone_number int NOT NULL,
	Avatar varchar(2048) NULL,
	Why_i_volunteer text NULL,
	Employee_id varchar(16) NULL,
	Department varchar(16) NULL,
	City_id bigint NOT NULL FOREIGN KEY REFERENCES City(City_id) CHECK(City_id >=0),
	Country_id bigint NOT NULL FOREIGN KEY REFERENCES Country(Country_id) CHECK(Country_id >=0),
	Profile_text text NULL,
	Linked_in_url varchar(255) NULL,
	Title varchar(255) NULL,
	Status bit NOT NULL DEFAULT 1,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO



--THEME Table
CREATE TABLE Theme(
	Theme_id bigint NOT NULL PRIMARY KEY IDENTITY(1,1) CHECK(Theme_id >=0),
	Title varchar(255) NOT NULL,
	Status tinyint NOT NULL DEFAULT 1,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--MISSION Table
CREATE TABLE Mission(
	Mission_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Mission_id >=0),
	Theme_id bigint NOT NULL FOREIGN KEY REFERENCES Theme(Theme_id) CHECK(Theme_id >=0),
	City_id bigint NOT NULL FOREIGN KEY REFERENCES City(City_id) CHECK(City_id >=0),
	Country_id bigint NOT NULL FOREIGN KEY REFERENCES Country(Country_id) CHECK(Country_id >=0),
	Title varchar(128) NOT NULL,
	Short_Description text,
	Description text,
	Start_Date datetime2(0) NULL,
	End_Date datetime2(0) NULL,
	Mission_type bit NOT NULL,
	Status bit,
	Organization_name varchar(255) NULL,
	Organization_detail text NULL,
	Availability bit NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO



--COMMENT Table
CREATE TABLE Comment (
	Comment_id bigint NOT NULL IDENTITY(1,1) CHECK(Comment_id >=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	Approval_status bit NOT NULL DEFAULT 0,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--CMS Table
CREATE TABLE cms_page(
	cms_page_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(cms_page_id >=0),
	Title varchar(255),
	Description text,
	Slug varchar(255) NOT NULL,
	Status bit DEFAULT 1,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO

--Favorit Mission Table
CREATE TABLE favourit_mission(
	favourit_mission_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(favourit_mission_id >=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--goal mission Table
CREATE TABLE goal_mission(
	goal_mission_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(goal_mission_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	goal_objective_text varchar(255) NULL,
	goal_value int NOT NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission application
CREATE TABLE mission_application(
	mission_application_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(mission_application_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id>=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_ID) CHECK(User_id>=0),
	Applied_at datetime2(0) NOT NULL,
	Approval_status bit NOT NULL DEFAULT 0,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission document
CREATE TABLE mission_document (
	Mission_document_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(mission_document_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	Document_name varchar(255),
	Document_type varchar(255),
	Document_path varchar(255) NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission invite Table
CREATE TABLE mission_invite(
	Mission_invite_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Mission_invite_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	from_user_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(from_user_id >=0),
	to_user_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(to_user_id>=0),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission media Table
CREATE TABLE mission_media(
	mission_media_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Mission_media_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	media_name varchar(64),
	media_type varchar(4),
	media_path varchar(255) NULL,
	defaults bit NOT NULL DEFAULT 0,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission rating Table
CREATE TABLE mission_rating(
	mission_rating_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(mission_rating_id >=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	Rating int NOT NULL CHECK(Rating >=1 AND Rating <=5),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--Skills Table
CREATE TABLE Skills(
	Skill_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(Skill_id >=0),
	skill_name varchar(64) NOT NULL,
	status tinyint NOT NULL DEFAULT 1,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--mission skills Table
CREATE TABLE mission_skill(
	mission_skill_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(mission_skill_id>=0),
	skill_id bigint NOT NULL FOREIGN KEY REFERENCES Skills(Skill_id) CHECK(skill_id>=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id >=0),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--Password Reset Table
CREATE TABLE password_reset(
	Email varchar(191) NOT NULL UNIQUE,
	token varchar(191) NOT NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE()
)
GO


--Story Table
CREATE TABLE story(
	story_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(story_id>=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id >=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id>=0),
	Title varchar(255) NULL,
	Description text NULL,
	Status int NOT NULL CHECK(Status>=1 AND Status<=4) DEFAULT 1,
	Published_at datetime2(0) NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--story_invite Table
CREATE TABLE stoty_invite(
	story_invite_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(story_invite_id >=0),
	story_id bigint NOT NULL FOREIGN KEY REFERENCES Story(story_id),
	from_user_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(from_user_id>=0),
	to_user_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(to_user_id>=0),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--story media Table
CREATE TABLE story_media(
	story_media_id bigint NOT NULL PRIMARY KEY IDENTITY(1,1) CHECK(story_media_id>=0),
	story_id bigint NOT NULL FOREIGN KEY REFERENCES story(story_id) CHECK(story_id>=0),
	type varchar(8) NOT NULL,
	path text NOT NULL,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--timesheet Table
CREATE TABLE timesheet(
	timesheet_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(timesheet_id>=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id>=0),
	Mission_id bigint NOT NULL FOREIGN KEY REFERENCES Mission(Mission_id) CHECK(Mission_id>=0),
	time datetime2(0) NULL,
	action int NULL,
	date_volunteer datetime2(0) NOT NULL,
	notes text NULL,
	status bit NOT NULL DEFAULT 0,
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)
GO


--User Skills Table
CREATE TABLE user_skill(
	user_skill_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CHECK(user_skill_id>=0),
	User_id bigint NOT NULL FOREIGN KEY REFERENCES Users(User_id) CHECK(User_id>=0),
	skill_id bigint NOT NULL FOREIGN KEY REFERENCES Skills(skill_id) CHECK(skill_id>=0),
	Created_at datetime2(0) NOT NULL DEFAULT GETUTCDATE(),
	Updated_at datetime2(0) NULL,
	Deleted_at datetime2(0) NULL
)


