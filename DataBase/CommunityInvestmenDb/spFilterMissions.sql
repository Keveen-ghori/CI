SELECT * FROM Mission;


--CREATE PROCEDURE spFilterMissionsBySkills
--    @skillIds VARCHAR(1000)
--AS
--BEGIN
--    SELECT m.*
--    FROM Mission m
--    INNER JOIN mission_skill ms ON m.Mission_id = ms.Mission_id
--    WHERE ms.skill_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@skillIds, ','))
--END

--spFilterMissionsBySkills '1,2';

--CREATE PROCEDURE spFilterMissionsByTheme
--    @themeds VARCHAR(1000)
--AS
--BEGIN
--    SELECT m.*
--    FROM Mission m
--    INNER JOIN Theme t ON m.Theme_id = t.Theme_id
--    WHERE t.Theme_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@themeds, ','))
--END

--spFilterMissionsByTheme '1,2,3,4,5';

--CREATE PROCEDURE spFilterMissionsByCity
--    @cityIds VARCHAR(1000)
--AS
--BEGIN
--    SELECT m.*
--    FROM Mission m
--    INNER JOIN City c ON m.City_id = c.City_id
--    WHERE c.City_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@cityIds, ','))
--END

--spFilterMissionsByCity '1';

--CREATE PROCEDURE spFilterMissionsByKeyword
--    @Keyword VARCHAR(1000)
--AS
--BEGIN
--    SELECT m.*
--    FROM Mission m
--    WHERE m.Title LIKE '%' + @Keyword + '%'
--END

--spFilterMissionsByKeyword 'Grow';


ALTER PROCEDURE FilterMissions
    @title VARCHAR(255) = NULL,
    @cityIds VARCHAR(1000) = NULL,
    @skillIds VARCHAR(1000) = NULL,
    @themeIds VARCHAR(1000) = NULL,
	@pageNumber INT = 1,
    @pageSize INT = 6,
	@loggedInUserId INT = NULL
AS
BEGIN
    DECLARE @Missions TABLE (Mission_id INT)
    
    IF @skillIds IS NOT NULL
        INSERT INTO @Missions
        SELECT DISTINCT m.Mission_id
        FROM Mission m
        INNER JOIN mission_skill ms ON m.Mission_id = ms.Mission_id
        WHERE ms.skill_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@skillIds, ','))
        
    IF @themeIds IS NOT NULL
        INSERT INTO @Missions
        SELECT DISTINCT m.Mission_id
        FROM Mission m
        INNER JOIN Theme t ON m.Theme_id = t.Theme_id
        WHERE t.Theme_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@themeIds, ','))
        
    IF @cityIds IS NOT NULL
        INSERT INTO @Missions
        SELECT DISTINCT m.Mission_id
        FROM Mission m
        INNER JOIN City c ON m.City_id = c.City_id
        WHERE c.City_id IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@cityIds, ','))
        
    IF @title IS NOT NULL
        INSERT INTO @Missions
        SELECT m.Mission_id
        FROM Mission m
        WHERE m.Title LIKE '%' + @title + '%'
    
    IF @skillIds IS NULL AND @themeIds IS NULL AND @cityIds IS NULL AND @title IS NULL
        INSERT INTO @Missions
        SELECT m.Mission_id
        FROM Mission m
    

	;WITH FilteredMissions AS (
        SELECT m.*, c.Name AS CityName, s.skill_name AS SkillName, t.Title AS ThemeTitle, mf.User_id,
               mr.Rating AS Rating, ROW_NUMBER() OVER (ORDER BY m.Mission_id) AS RowNum
        FROM Mission m
        LEFT JOIN City c ON m.City_id = c.City_id
        LEFT JOIN Theme t ON m.Theme_id = t.Theme_id
        LEFT JOIN mission_skill ms ON m.Mission_id = ms.Mission_id
        LEFT JOIN Skills s ON ms.skill_id = s.Skill_id
        LEFT JOIN mission_rating mr ON m.Mission_id = mr.Mission_id
		LEFT JOIN favourit_mission mf ON mf.Mission_id = m.Mission_id
		LEFT JOIN (
            SELECT Mission_id
            FROM favourit_mission
            WHERE User_id = @loggedInUserId
        ) fm ON m.Mission_id = fm.Mission_id
        WHERE m.Mission_id IN (SELECT Mission_id FROM @Missions) 
    
    )
    SELECT *
    FROM FilteredMissions
    WHERE RowNum BETWEEN (@pageNumber - 1) * @pageSize + 1 AND @pageNumber * @pageSize
    ORDER BY Mission_id

END


GO
EXEC FilterMissions @loggedInUserId = 6, @cityIds = '1,2,13,32', @pageNumber = 2, @pageSize = 6;
GO

