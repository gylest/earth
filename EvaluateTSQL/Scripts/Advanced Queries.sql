--
-- The MERGE statement, also known as an Upsert.
-- Allows you to synchronize two tables with one statement.
--

-- M1. Create Source and Target tables
IF OBJECT_ID('dbo.CustomerSource') IS NOT NULL BEGIN DROP TABLE dbo.CustomerSource; END;
IF OBJECT_ID('dbo.CustomerTarget') IS NOT NULL BEGIN DROP TABLE dbo.CustomerTarget; END;

CREATE TABLE dbo.CustomerSource (CustomerID int NOT NULL PRIMARY KEY, Name varchar(150), PersonID int NOT NULL);
CREATE TABLE dbo.CustomerTarget (CustomerID int NOT NULL PRIMARY KEY, Name varchar(150), PersonID int NOT NULL);

-- M2. Populate Source Table
INSERT INTO dbo.CustomerSource(CustomerID,Name,PersonID)
SELECT CustomerID,p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName, PersonID
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID IN (11078,11287,11657,11794);

-- M3. Populate Target Table
INSERT INTO dbo.CustomerTarget(CustomerID,Name,PersonID)
SELECT CustomerID, p.FirstName + ' ' + p.LastName, PersonID
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID IN (11078,11287,14114);

-- M4. Show Source Rows
SELECT CustomerID, Name, PersonID FROM dbo.CustomerSource ORDER BY CustomerID;

-- M5. Show Target Rows
SELECT CustomerID, Name, PersonID FROM dbo.CustomerTarget ORDER BY CustomerID;

-- M6. Perform MERGE to Target table. These performs UPDATE, INSERT and DELETE as required
MERGE dbo.CustomerTarget AS t
USING dbo.CustomerSource AS s
ON (s.CustomerID = t.CustomerID)
WHEN MATCHED AND s.Name <> t.Name
THEN UPDATE SET Name = s.Name
WHEN NOT MATCHED BY TARGET
THEN INSERT (CustomerID, Name, PersonID) VALUES (CustomerID, Name, PersonID)
WHEN NOT MATCHED BY SOURCE
THEN DELETE
OUTPUT $action, DELETED.*, INSERTED.*;--semi-colon is required

-- M7. Show FInal Target Table
SELECT CustomerID, Name, PersonID FROM dbo.CustomerTarget ORDER BY CustomerID;
GO

--
-- WITH TIES
--

-- WT1. Create Table
IF OBJECT_ID('dbo.WithTiesTable') IS NOT NULL BEGIN DROP TABLE dbo.WithTiesTable; END;
GO
CREATE TABLE dbo.WithTiesTable (Purchase_Date datetime, Amount int);
GO

-- WT2. Populate Table
INSERT INTO dbo.WithTiesTable
SELECT '11/11/2011', 100 UNION ALL
SELECT '11/12/2011', 110 UNION ALL
SELECT '11/13/2011', 120 UNION ALL
SELECT '11/14/2011', 130 UNION ALL
SELECT '11/11/2011', 150;

-- WT3. Get all records which has minimum purchase date (i.e. 11/11/2011)
SELECT * FROM dbo.WithTiesTable
WHERE Purchase_Date IN
(SELECT MIN(Purchase_Date) FROM dbo.WithTiesTable);
GO

-- WT4. Do the same, but this time using WITH TIES
SELECT TOP(1) WITH TIES * FROM dbo.WithTiesTable ORDER BY Purchase_Date
GO

--
-- CTE (Common Table Expression)
--

--
-- A CTE is a temporary result set that you can reference within another SELECT, INSERT, UPDATE, or DELETE statement.
--
IF OBJECT_ID('[dbo].[Employee]') IS NOT NULL BEGIN DROP TABLE [dbo].[Employee]; END;
IF OBJECT_ID('[dbo].[Contact]')  IS NOT NULL BEGIN DROP TABLE [dbo].[Contact];  END;

CREATE TABLE [dbo].[Employee](
[EmployeeID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[ManagerID] [int] NULL,
[Title] [nvarchar](50) NOT NULL);

CREATE TABLE [dbo].[Contact] (
[ContactID] [int] NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[MiddleName] [nvarchar](50) NULL,
[LastName] [nvarchar](50) NOT NULL);

INSERT INTO [dbo].[Contact] (ContactID, FirstName, MiddleName, LastName) VALUES
(1030,'Kevin','F','Brown'),
(1002,'Anthony','P','Gyles'),
(1009,'Thierry','B','DHers'),
(1028,'David','M','Bradley'),
(1070,'JoLynn','M','Dobney'),
(1071,'Ruth','Ann','Ellerbrock'),
(1076,'Barry','K','Johnson'),
(1001,'Terri','Lee','Duffy'),
(1231,'Peter','J','Krebs'),
(1287, 'Ken', 'J', 'Sanchez'),
(1052, 'James', 'R', 'Hamilton'),
(1056, 'Jack', 'S', 'Richins'),
(1053, 'Andrew', 'R', 'Hill'),
(1064, 'Lori', 'A', 'Kane'),
(1007, 'Ovidiu', 'V', 'Cracium');

INSERT INTO [dbo].[Employee] (EmployeeID, ContactID, ManagerID, Title) VALUES
(2, 1030, 6,'Marketing Assistant'),
(3, 1002, 12,'Engineering Manager'),
(5, 1009, 263,'Tool Designer'),
(6, 1028, 109,'Marketing Manager'),
(7, 1070, 21,'Production Supervisor - WC60'),
(8, 1071, 185,'Production Technician - WC10'),
(10, 1076, 185,'Production Technician - WC10'),
(12, 1001, 109,'Vice President of Engineering'),
(21, 1231, 148,'Production Control Manager'),
(109, 1287, NULL, 'Chief Executive Officer'),
(148, 1052, 109, 'Vice President of Production'),
(184, 1056, 21, 'Production Supervisor - WC30'),
(185, 1053, 21, 'Production Supervisor - WC10'),
(197, 1064, 21, 'Production Supervisor - WC45'),
(263, 1007, 3, 'Senior Tool Designer');

--
-- Each CTE can be its own distinct query. Then later can join queries together
--
WITH
Emp AS(
	SELECT e.EmployeeID, e.ManagerID,e.Title AS EmpTitle, c.FirstName + ISNULL(' ' + c.MiddleName,'') + ' ' + c.LastName AS EmpName
    FROM [dbo].[Employee]  AS e
    INNER JOIN Contact AS c ON e.ContactID = c.ContactID
),
Mgr AS(
	SELECT e.EmployeeID AS ManagerID,e.Title AS MgrTitle, c.FirstName + ISNULL(' ' + c.MiddleName,'') + ' ' + c.LastName AS MgrName
	FROM [dbo].[Employee]  AS e
	INNER JOIN Contact AS c ON e.ContactID = c.ContactID
)
	SELECT EmployeeID, Emp.ManagerID, EmpName, EmpTitle, MgrName, MgrTitle
	FROM Emp LEFT JOIN Mgr ON Emp.ManagerID = Mgr.ManagerID
	ORDER BY EmployeeID;
GO

--
-- Recursive CTE
--

-- Used to retrieve hierarchical data such as organization structure
-- In e.g. below, the organizational data is stored within the employee table, a recursive call is required to find the level and the corresponding node from this table.
--

WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node) AS (
	-- Anchor member (returns top of results)
	SELECT EmployeeID, ManagerID, Title, 0, CONVERT(VARCHAR(30),'/') AS Node
	FROM Employee
	WHERE ManagerID IS NULL
	UNION ALL
	-- Recursive member (this query runs repeatedly down all paths)
	SELECT a.EmployeeID, a.ManagerID,a.Title, b.Level + 1, CONVERT(VARCHAR(30),b.Node +CONVERT(VARCHAR,a.ManagerID) + '/')
	FROM Employee AS a
	INNER JOIN OrgChart AS b ON a.ManagerID = b.EmployeeID
)
	SELECT EmployeeID, ManagerID, SPACE(Level * 3) + Title AS Title, Level, Node
	FROM OrgChart
GO

--
-- Using geography data type to calculate distance between two points
-- To find latitude and longitude of a place use this site:
-- https://www.latlong.net/ 
-- Use Spatial Reference Identifier (SRID) of 4326 which is for GPS data
--
DECLARE @gBasingstoke geography;
SET     @gBasingstoke = geography::Point(51.266541, -1.092396, 4326)

DECLARE @gReading geography;
SET     @gReading = geography::Point(51.454266, -0.978130, 4326)

DECLARE @gCambridge geography;
SET     @gCambridge = geography::Point(52.205338, 0.121817, 4326)

SELECT ROUND(@gBasingstoke.STDistance(@gReading)/1000,2)   as 'Basingstoke to Reading (KM)';
SELECT ROUND(@gBasingstoke.STDistance(@gCambridge)/1000,2) as 'Basingstoke to Cambridge (KM)'; 

--
-- HASHBYTES
-- Returns the hash value of its input using the specified algorithm.
-- In this example a hash value is calculated for all values in a table.
-- When trying to update this record instead of comparing every column simply compare the hash values of new versus existing, if different then update.
-- The following hash algorithms are supported (from SQL Server 2016): SHA2_256, SHA2_512.
--
IF OBJECT_ID('[dbo].[ChurchBuilding]') IS NOT NULL BEGIN DROP TABLE [dbo].[ChurchBuilding]; END;

CREATE TABLE [dbo].[ChurchBuilding](
[ChurchID] [int] NOT NULL,
[ChurchType] NVARCHAR(50) NOT NULL,
[ChurchName] NVARCHAR(100) NOT NULL,
[AddressLine1] NVARCHAR(50) NOT NULL,
[AddressLine2] NVARCHAR(50) NULL,
[AddressCity] NVARCHAR(50) NOT NULL,
[AddressPostCode] NVARCHAR(50) NOT NULL,
[ConstructionYear] INT NOT NULL,
[HashValue] BINARY(32) NULL
)
GO

INSERT INTO [dbo].[ChurchBuilding] (ChurchID, ChurchType, ChurchName, AddressLine1, AddressLine2, AddressCity,AddressPostCode,ConstructionYear) VALUES
(1,'Cathedral','St. Paul''s Cathedral','St. Paul''s Churchyard',NULL,'London','EC4M 8AD',1675),
(2,'Cathedral','Liverpool Cathedral','St James Mt',NULL,'Liverpool','L1 7AZ',1978)
GO

WITH ChurchHash AS
(
SELECT ChurchId,
HASHBYTES('SHA2_256', CONCAT([ChurchId], '|',[ChurchType], '|',[ChurchName], '|',[AddressLine1], '|',[AddressLine2], '|',[AddressCity], '|',[AddressCity], '|',[AddressCity], '|')) as hv
FROM ChurchBuilding
)
UPDATE ChurchBuilding 
SET [HashValue] = hv
FROM ChurchHash;

--
-- PIVOT
-- 
IF OBJECT_ID('[Advanced].[Employees]')   IS NOT NULL BEGIN DROP TABLE [Advanced].[Employees]; END;
IF OBJECT_ID('[Advanced].[Departments]') IS NOT NULL BEGIN DROP TABLE [Advanced].[Departments]; END;

CREATE TABLE [Advanced].[Departments]
( dept_id INT NOT NULL,
  dept_name VARCHAR(50) NOT NULL,
  CONSTRAINT departments_pk PRIMARY KEY (dept_id)
);

CREATE TABLE [Advanced].[Employees]
( employee_number INT NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  salary INT,
  dept_id INT,
  CONSTRAINT employees_pk PRIMARY KEY (employee_number)
);

INSERT INTO [Advanced].[Departments] (dept_id, dept_name)
VALUES
(30, 'Accounting'),
(45, 'Sales');

INSERT INTO [Advanced].[Employees] (employee_number, last_name, first_name, salary, dept_id)
VALUES
(12009, 'Sutherland', 'Barbara', 54000, 45),
(34974, 'Yates', 'Fred', 80000, 45),
(34987, 'Erickson', 'Neil', 42000, 45),
(45001, 'Parker', 'Salary', 57500, 30),
(75623, 'Gates', 'Steve', 65000, 30);

-- Create a cross-tabulation query using the PIVOT clause
-- A cross tab query is a transformation of rows of data to columns. It usually involves aggregation of data.
SELECT 'TotalSalary' AS TotalSalaryByDept, 
[30], [45]
FROM
(SELECT dept_id, salary
 FROM [Advanced].[Employees] ) AS SourceTable
PIVOT
(
 SUM(salary)
 FOR dept_id IN ([30], [45])
) AS PivotTable;

--
-- INFORMATION SCHEMA
-- 

-- List all tables in current database
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';

-- Get important information on columns in a table
SELECT COLUMN_NAME, ORDINAL_POSITION, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'EvaluateOffice' AND TABLE_NAME = N'Customer';
