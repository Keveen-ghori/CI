DBCC CHECKIDENT (Country, RESEED, 0);
GO

--Inserting Data Into Country Table

INSERT INTO Country (Name, ISO)
VALUES 
  ('United States', 'US'),
  ('Canada', 'CA'),
  ('Mexico', 'MX'),
  ('Brazil', 'BR'),
  ('Argentina', 'AR'),
  ('Colombia', 'CO'),
  ('Peru', 'PE'),
  ('Chile', 'CL'),
  ('Ecuador', 'EC'),
  ('Guatemala', 'GT'),
  ('Cuba', 'CU'),
  ('Haiti', 'HT'),
  ('Dominican Republic', 'DO'),
  ('Honduras', 'HN'),
  ('El Salvador', 'SV'),
  ('Nicaragua', 'NI'),
  ('Costa Rica', 'CR'),
  ('Panama', 'PA'),
  ('Puerto Rico', 'PR'),
  ('Jamaica', 'JM'),
  ('Trinidad and Tobago', 'TT'),
  ('Bahamas', 'BS'),
  ('Barbados', 'BB'),
  ('Saint Lucia', 'LC'),
  ('Grenada', 'GD'),
  ('Dominica', 'DM'),
  ('Saint Vincent and the Grenadines', 'VC'),
  ('Antigua and Barbuda', 'AG'),
  ('Saint Kitts and Nevis', 'KN'),
  ('Guyana', 'GY'),
  ('Suriname', 'SR'),
  ('Uruguay', 'UY'),
  ('Paraguay', 'PY'),
  ('Bolivia', 'BO'),
  ('Venezuela', 'VE'),
  ('Spain', 'ES'),
  ('France', 'FR'),
  ('Germany', 'DE'),
  ('Italy', 'IT'),
  ('United Kingdom', 'GB'),
  ('Australia', 'AU'),
  ('New Zealand', 'NZ'),
  ('China', 'CN'),
  ('Japan', 'JP'),
  ('South Korea', 'KR'),
  ('India', 'IN'),
  ('Pakistan', 'PK'),
  ('Bangladesh', 'BD'),
  ('Indonesia', 'ID'),
  ('Philippines', 'PH'),
  ('Thailand', 'TH'),
  ('Vietnam', 'VN');
GO

SELECT * FROM Country;
GO



DBCC CHECKIDENT ('MyTable', RESEED, 0);

--Inserting data into city Table
INSERT INTO City (Country_id, Name)
VALUES
(1, 'New Yourk'),
(1, 'California'),
(1, 'Chicago'),
(1, 'Texas'),
(1, 'Arizona'),
(1, 'San Diego'),
(1, 'Phoenix'),
(2, 'Toronto'),
(2, 'Montreal'),
(2, 'Calgary'),
(2, 'Hamilton'),
(2, 'Quebec City'),
(3, 'Mexico City'),
(3, 'Ecatepec de Morelos'),
(3, 'Guadalajara'),
(40, 'London'),
(40, 'Birmingham'),
(40, 'Glasgow'),
(40, 'Liverpool'),
(40, 'Leeds'),
(40, 'Sheffield'),
(40, 'Edinburgh'),
(40, 'Bristol'),
(40, 'Manchester'),
(3, 'Zapopan'),
(41, 'Sydney'),
(41, 'Melbourne'),
(41, 'Brisbane'),
(41, 'Perth'),
(41, 'Canberra-Queanbeyan'),
(46, 'Ahmedabad'),
(46, 'Pune'),
(46, 'Surat'),
(46, 'Jaipur'),
(46, 'Delhi'),
(46, 'Bangalore'),
(46, 'Hyderabad');
GO


SELECT * FROM City;
GO
