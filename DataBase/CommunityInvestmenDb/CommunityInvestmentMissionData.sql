DBCC CHECKIDENT ('MyTable', RESEED, 1);



--Inserting Data Into Mission Table
INSERT INTO Mission (Theme_id, City_id, Country_id, Title, Short_Description, Description, Start_Date, End_Date, Mission_type, Status, Organization_name, Organization_detail, Availability)
VALUES 
(1, 1, 1, 'Education Supplies for Every Pair of Shoes Sold', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-01', '2023-03-07', 1, 1, 'Amaze Doctors', 'Details for Organization 1', 1),
(2, 2, 1, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-02', '2023-03-08', 0, 1, 'Amaze Doctors', 'Details for Organization 2', 0),
(3, 3, 1, 'Nourish the Children in African country', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-03', '2023-03-09', 1, 0, 'Amaze Doctors', 'Details for Organization 3', 1),
(4, 13, 3, 'Plantation and Afforestation programme', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-04', '2023-03-10', 0, 0, 'Amaze Doctors', 'Details for Organization 4', 0),
(5, 15, 3, 'Education Supplies for Every Pair of Shoes Sold', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-05', '2023-03-11', 1, 1, 'Amaze Doctors', 'Details for Organization 5', 1),
(6, 31, 46, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-06', '2023-03-12', 0, 1, 'Junior Charity', 'Details for Organization 6', 0),
(7, 32, 46, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-07', '2023-03-13', 1, 0, 'Junior Charity', 'Details for Organization 7', 1),
(8, 32, 46, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-08', '2023-03-14', 0, 0, 'Junior Charity', 'Details for Organization 8', 0),
(9, 32, 46, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-09', '2023-03-15', 1, 1, 'Tree Canada', 'Details for Organization 9', 1),
(10, 32, 10, 'Grow Trees – On the path to environment sustainability', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', '2023-03-10', '2023-03-16', 0, 1, 'Tree Canada', 'Details for Organization 10', 0)
GO


SELECT * FROM Mission;
GO
