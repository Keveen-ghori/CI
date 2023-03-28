--Reset Seed Property of id column
DBCC CHECKIDENT ('Admin', RESEED, 1);

--Inserting Data into Admin Table
INSERT INTO Admin (First_name, Last_name, Email, Password)
VALUES 
  ('John', 'Doe', 'john.doe@example.com', 'password123'),
  ('Jane', 'Doe', 'jane.doe@example.com', 'letmein'),
  ('Bob', 'Smith', 'bob.smith@example.com', 'password456'),
  ('Alice', 'Johnson', 'alice.johnson@example.com', 'abc123'),
  ('David', 'Lee', 'david.lee@example.com', 'p@ssw0rd'),
    ('Mary', 'Smith', 'mary.smith@example.com', 'password789'),
  ('Tom', 'Johnson', 'tom.johnson@example.com', 'password101'),
  ('Emily', 'Davis', 'emily.davis@example.com', 'qwerty123'),
  ('Mark', 'Thompson', 'mark.thompson@example.com', 'letmein123'),
  ('Sara', 'Lee', 'sara.lee@example.com', 'password321'),
  ('Michael', 'Scott', 'michael.scott@example.com', 'theoffice'),
  ('Pam', 'Beesly', 'pam.beesly@example.com', 'paper'),
  ('Dwight', 'Schrute', 'dwight.schrute@example.com', 'beets'),
  ('Jim', 'Halpert', 'jim.halpert@example.com', 'pranks'),
  ('Andy', 'Bernard', 'andy.bernard@example.com', 'cornell'),
  ('Kevin', 'Malone', 'kevin.malone@example.com', 'chili'),
  ('Angela', 'Martin', 'angela.martin@example.com', 'cats'),
  ('Oscar', 'Martinez', 'oscar.martinez@example.com', 'accounting'),
  ('Ryan', 'Howard', 'ryan.howard@example.com', 'temp'),
  ('Kelly', 'Kapoor', 'kelly.kapoor@example.com', 'gossip'),
  ('Sarah', 'Wilson', 'sarah.wilson@example.com', 'qwerty123'),
  ('Michael', 'Brown', 'michael.brown@example.com', 'password789'),
  ('Emily', 'Jones', 'emily.jones@example.com', 'letmeinnow'),
  ('Andrew', 'Davis', 'andrew.davis@example.com', 'newpassword'),
  ('Karen', 'Taylor', 'karen.taylor@example.com', 'iloveyou'),
  ('Robert', 'Clark', 'robert.clark@example.com', 'hello123'),
  ('Megan', 'Smith', 'megan.smith@example.com', 'sunshine'),
  ('Matthew', 'Garcia', 'matthew.garcia@example.com', 'abcdef'),
  ('Elizabeth', 'Hernandez', 'elizabeth.hernandez@example.com', 'password1234'),
  ('William', 'Adams', 'william.adams@example.com', 'password5678');

SELECT * FROM ADMIN;
GO

INSERT INTO Admin (First_name, Last_name, Email, Password)
VALUES 
  ('Sarah', 'Williams', 'sarah.williams@example.com', 'sarahpass'),
  ('Michael', 'Johnson', 'michael.johnson@example.com', 'mike123'),
  ('Emily', 'Brown', 'emily.brown@example.com', 'password789'),
  ('Brandon', 'Davis', 'brandon.davis@example.com', 'brandonpass'),
  ('Jennifer', 'Wilson', 'jennifer.wilson@example.com', 'jenpass'),
  ('Steven', 'Anderson', 'steven.anderson@example.com', 'steven123'),
  ('Laura', 'Clark', 'laura.clark@example.com', 'laurapass'),
  ('Richard', 'Miller', 'richard.miller@example.com', 'richard123'),
  ('Amanda', 'Allen', 'amanda.allen@example.com', 'amandapass'),
  ('Thomas', 'Scott', 'thomas.scott@example.com', 'thomaspass'),
  ('Kimberly', 'Lee', 'kimberly.lee@example.com', 'kimberlypass'),
  ('Kevin', 'Lewis', 'kevin.lewis@example.com', 'kevin123'),
  ('Rachel', 'Harris', 'rachel.harris@example.com', 'rachelpass'),
  ('Justin', 'Nelson', 'justin.nelson@example.com', 'justinpass'),
  ('Tiffany', 'White', 'tiffany.white@example.com', 'tiffanypass'),
  ('Keith', 'Jackson', 'keith.jackson@example.com', 'keith123'),
  ('Stephanie', 'Hill', 'stephanie.hill@example.com', 'stephaniepass'),
  ('Jonathan', 'Roberts', 'jonathan.roberts@example.com', 'jonathan123'),
  ('Megan', 'Phillips', 'megan.phillips@example.com', 'meganpass'),
  ('Andrew', 'Campbell', 'andrew.campbell@example.com', 'andrew123');


INSERT INTO Admin (First_name, Last_name, Email, Password, Created_at, Updated_at, Deleted_at)
VALUES 
 ('Tom', 'Hanks', 'tom.hanks@example.com', 'hanks123', GETUTCDATE(), GETUTCDATE() - 8, NULL),
  ('Sarah', 'Connor', 'sarah.connor@example.com', 'terminator', GETUTCDATE(), GETUTCDATE() - 9, NULL),
  ('Tony', 'Stark', 'tony.stark@example.com', 'ironman', GETUTCDATE(), GETUTCDATE() - 10, NULL),
  ('Natasha', 'Romanoff', 'natasha.romanoff@example.com', 'blackwidow', GETUTCDATE(), GETUTCDATE() - 11, NULL),
  ('Bruce', 'Banner', 'bruce.banner@example.com', 'hulk123', GETUTCDATE(), GETUTCDATE() - 12, NULL),
  ('Wanda', 'Maximoff', 'wanda.maximoff@example.com', 'scarletwitch', GETUTCDATE(), GETUTCDATE() - 13, GETUTCDATE()),
  ('Steve', 'Rogers', 'steve.rogers@example.com', 'captainamerica', GETUTCDATE(), GETUTCDATE() - 14, GETUTCDATE()),
  ('Peter', 'Parker', 'peter.parker@example.com', 'spiderman', GETUTCDATE(), GETUTCDATE() - 15, GETUTCDATE()),
  ('Thor', 'Odinson', 'thor.odinson@example.com', 'mjolnir', GETUTCDATE(), GETUTCDATE() - 16, GETUTCDATE()),
  ('Loki', 'Laufeyson', 'loki.laufeyson@example.com', 'trickster', GETUTCDATE(), GETUTCDATE() - 17, GETUTCDATE()),
  ('Carol', 'Danvers', 'carol.danvers@example.com', 'captainmarvel', GETUTCDATE(), GETUTCDATE() - 18, GETUTCDATE());