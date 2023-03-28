USE CI
GO



ALTER PROCEDURE spMissionDetails
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
		   C.Name AS CityName, 
		   gm.goal_objective_text, 
		   gm.goal_value,
		   u.User_id, 
		   mi.from_user_id, 
		   mi.to_user_id, 
		   mr.Rating, 
		   m.Organization_name, 
		   m.Organization_detail,
		   t.title AS ThemeTitle, 
		   cm.Comment_id, 
		   cm.comment_text, 
		   S.skill_name, 
		   S.status, 
		   ma.media_name, 
		   ma.media_path, 
		   ma.media_type,
		   CASE WHEN maap.mission_application_id IS NOT NULL THEN 1 ELSE 0 END AS is_applied,
		   CASE WHEN fm.User_id IS NOT NULL THEN 1 ELSE 0 END AS is_favorite,
		   m.Max_seats
		   
	FROM Mission m
	JOIN City C ON C.City_id = m.City_id
	LEFT JOIN goal_mission gm ON m.Mission_id = gm.Mission_id AND m.Mission_type = 0
	LEFT JOIN [Users] u ON u.User_id = @userId
	LEFT JOIN mission_invite mi ON mi.Mission_id = m.Mission_id AND mi.from_user_id = u.User_id
	LEFT JOIN mission_rating mr ON mr.Mission_id = m.Mission_id AND mr.User_id = u.User_id
	JOIN Theme t ON t.Theme_id = m.Theme_id
	LEFT JOIN Comment cm ON cm.Mission_id = m.Mission_id AND cm.User_id = u.User_id
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



--Execute Stored Procedure
spMissionDetails 30, 1, @addToFavorites=1
 
--Here 0 for goal missions and 1 for Time Based mission
