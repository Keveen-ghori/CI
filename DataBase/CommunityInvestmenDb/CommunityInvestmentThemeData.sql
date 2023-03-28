DBCC CHECKIDENT (Theme, RESEED, 0);


--Inserting Data into Theme Table
INSERT INTO Theme (Title) VALUES
('Education'),
('Children'),
('Health'),
('Animal Welfare'),
('Environment'),
('Poverty Alleviation'),
('Women Empowerment'),
('Disaster Relief'),
('Arts and Culture'),
('Elderly Care');
GO

SELECT * FROM Theme;


