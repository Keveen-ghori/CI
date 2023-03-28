DBCC CHECKIDENT (Users, RESEED, 0);



--Inserting Data into User Table
INSERT INTO Users (First_name, Second_name, Email, Password, Phone_number, Avatar, Why_i_volunteer, Employee_id, Department, City_id, Country_id, Profile_text, Linked_in_url, Title)
VALUES 
('John', 'Doe', 'johndoe@example.com', 'password123', 1234567890, NULL, 'I want to make a difference in my community.', NULL, NULL, 1, 1, 'I am passionate about volunteering and giving back to society.', 'https://www.linkedin.com/in/johndoe', 'Software Engineer'),
('Jane', 'Doe', 'janedoe@example.com', 'letmein', 2345678901, NULL, 'Volunteering allows me to meet new people and learn new skills.', NULL, NULL, 8, 2, 'I have experience volunteering for various non-profit organizations.', 'https://www.linkedin.com/in/janedoe', 'Marketing Manager'),
('Bob', 'Smith', 'bobsmith@example.com', 'password456', 3456789012, NULL, 'I volunteer to create a positive impact in my community.', NULL, NULL, 13, 3, 'I am a dedicated volunteer with a track record of successfully completed projects.', 'https://www.linkedin.com/in/bobsmith', 'Project Manager'),
('Alice', 'Johnson', 'alicejohnson@example.com', 'abc123', 4567890123, NULL, 'Volunteering is a way to give back to the community and make a difference.', NULL, NULL, 16, 40, 'I am a passionate and committed volunteer with a focus on community development.', 'https://www.linkedin.com/in/alicejohnson', 'Community Outreach Coordinator'),
('David', 'Lee', 'davidlee@example.com', 'p@ssw0rd', 5678901234, NULL, 'I want to contribute to the betterment of society through volunteering.', NULL, NULL, 31, 46, 'I have experience volunteering in disaster relief efforts and community outreach programs.', 'https://www.linkedin.com/in/davidlee', 'Emergency Response Coordinator'),
('Sarah', 'Williams', 'sarahwilliams@example.com', 'password789', 6789012345, NULL, 'I volunteer to make a positive impact in the lives of others and to gain valuable experience.', NULL, NULL, 34, 46, 'I have experience volunteering for youth programs and mentoring underprivileged children.', 'https://www.linkedin.com/in/sarahwilliams', 'Youth Mentor'),
('Michael', 'Brown', 'michaelbrown@example.com', 'letmein123', 7890123456, NULL, 'I volunteer to create a sense of community and togetherness.', NULL, NULL, 27, 41, 'I am a dedicated and enthusiastic volunteer with a focus on community building.', 'https://www.linkedin.com/in/michaelbrown', 'Community Builder'),
('Emily', 'Jones', 'emilyjones@example.com', 'password321', 8901234567, NULL, 'Volunteering allows me to use my skills and knowledge to make a positive impact.', NULL, NULL, 36, 46, 'I have experience volunteering in fundraising and event planning for non-profit organizations.', 'https://www.linkedin.com/in/emilyjones', 'Fundraising Coordinator'),
('William', 'Davis', 'williamdavis@example.com', 'abc456', 9012345678, NULL, NULL, NULL, NULL, 28, 41, NULL, NULL, 'Architect');
GO


SELECT * FROM Users;
GO