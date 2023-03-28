USE [CI]
GO

/****** Object:  StoredProcedure [dbo].[spMissionDetails]    Script Date: 22-03-2023 16:49:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
spMissionDetails @missionId=22, @userId=13
ALTER PROCEDURE [dbo].[spMissionDetails]
	@missionId bigint,
	@userId bigint,
	@addToFavorites bit = NULL,
	@removeFromFavorites bit = NULL
AS
BEGIN



	SELECT m.Mission_id, 
	   m.Title, 
	   m.Short_Description, 
	   m.Description, 
	   m.Mission_type, 
	   m.Start_Date, 
	   m.End_Date, 
	   mr.Rating,
	   C.Name AS CityName, 
	   gm.goal_objective_text, 
	   gm.goal_value,
	   u.User_id, 
	   mi.from_user_id, 
	   mi.to_user_id, 
	   m.Organization_name, 
	   m.Organization_detail,
	   t.title AS ThemeTitle, 
	   cm.Comment_id, 
	   cm.comment_text, 
	   cm.User_id AS [Comment UserId],
	   us.First_name,
	   us.Second_name,
	   cm.Created_at,
	   S.skill_name, 
	   S.status, 
	   ma.media_name, 
	   ma.media_path, 
	   ma.media_type,
	   CASE WHEN maap.mission_application_id IS NOT NULL THEN 1 ELSE 0 END AS is_applied,
	   CASE WHEN fm.User_id IS NOT NULL THEN 1 ELSE 0 END AS is_favorite,
	   m.Max_seats,
	   m.Filled_seats
	   
FROM Mission m
JOIN City C ON C.City_id = m.City_id
LEFT JOIN goal_mission gm ON m.Mission_id = gm.Mission_id AND m.Mission_type = 0
LEFT JOIN [Users] u ON u.User_id = @userId
LEFT JOIN mission_invite mi ON mi.Mission_id = m.Mission_id AND mi.from_user_id = u.User_id
LEFT JOIN mission_rating mr ON mr.Mission_id = m.Mission_id 
JOIN Theme t ON t.Theme_id = m.Theme_id
LEFT JOIN Comment cm ON cm.Mission_id = m.Mission_id
LEFT JOIN Users us ON us.User_id = cm.User_id
LEFT JOIN mission_skill ms ON ms.Mission_id = m.Mission_id 
LEFT JOIN Skills S ON S.Skill_id = ms.skill_id 
LEFT JOIN mission_media ma ON ma.Mission_id = m.Mission_id 
LEFT JOIN mission_application maap ON maap.Mission_id = m.Mission_id AND maap.User_id = @userId
LEFT JOIN favourit_mission fm ON fm.Mission_id = m.Mission_id AND fm.User_id = @userId

WHERE m.Mission_id = @missionId

	IF @userId IS NOT NULL AND (@addToFavorites IS NOT NULL OR @removeFromFavorites IS NOT NULL)
	BEGIN
		IF @addToFavorites = 1 AND NOT EXISTS (SELECT 1 FROM favourit_mission WHERE User_id = @userId AND Mission_id = @missionId)
		BEGIN
			INSERT INTO favourit_mission (User_id, Mission_id) VALUES (@userId, @missionId)
		END

		IF @removeFromFavorites = 1 AND EXISTS (SELECT 1 FROM favourit_mission WHERE User_id = @userId AND Mission_id = @missionId)
		BEGIN
			DELETE FROM favourit_mission WHERE User_id = @userId AND Mission_id = @missionId
		END
	END
END
GO


ALTER PROCEDURE spMissionRating
	@missionId bigint 
AS
BEGIN
	SELECT AVG(mr.Rating) AS Rating
	FROM Mission m
	LEFT JOIN mission_rating mr ON mr.Mission_id = m.Mission_id
	WHERE m.Mission_id = @missionId
	GROUP BY m.Mission_id;
END

 
spMissionRating @missionId=22


ALTER PROCEDURE spMissionComments
	@missionId bigint 
AS
BEGIN
	SELECT cm.comment_text, cm.Created_at, u.First_name, u.Second_name, u.Avatar
	FROM Mission m
	LEFT JOIN Comment cm ON cm.Mission_id = m.Mission_id
	LEFT JOIN Users u ON cm.User_id = u.User_id
	WHERE m.Mission_id = @missionId;
END

spMissionComments @missionId=22

ALTER PROCEDURE spMissionComments
	@missionId bigint 
AS
BEGIN
	SELECT cm.comment_text, cm.Created_at, u.First_name, u.Second_name, u.Avatar
	FROM Mission m
	LEFT JOIN Comment cm ON cm.Mission_id = m.Mission_id
	LEFT JOIN Users u ON cm.User_id = u.User_id
	WHERE m.Mission_id = @missionId;
END
