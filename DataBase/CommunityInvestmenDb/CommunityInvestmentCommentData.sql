


--Inserting Data Into Comment Table
INSERT INTO Comment(User_id, Mission_id, Approval_status) 
VALUES
(3, 6, 1),
(5, 2, 1),
(5, 4, 0),
(11, 8, 1),
(6, 1, 0),
(7, 1, 1);
GO

SELECT * FROM Comment;