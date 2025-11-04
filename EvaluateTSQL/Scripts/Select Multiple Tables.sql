-- INNER JOIN (2 Tables)
SELECT Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.TotalDue,
       Sales.SalesOrderDetail.ProductID, Sales.SalesOrderDetail.OrderQty
FROM Sales.SalesOrderHeader INNER JOIN Sales.SalesOrderDetail ON 
Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID

SELECT s.SalesOrderID, s.OrderDate, s.TotalDue, d.SalesOrderDetailID,
d.ProductID, d.OrderQty
FROM Sales.SalesOrderHeader AS s
INNER JOIN Sales.SalesOrderDetail AS d ON s.SalesOrderID = d.SalesOrderID;

-- INNER JOIN (3 Tables)
SELECT soh.SalesOrderID, soh.OrderDate, p.ProductID, p.Name
FROM Sales.SalesOrderHeader       AS soh
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product     AS p   ON sod.ProductID    = p.ProductID
ORDER BY soh.SalesOrderID;

-- LEFT OUTER JOIN
-- Think of Venn Diagram with 2 overlapping cicrles. 
-- This is e=quiavlent to the area of intersection and outer left section
SELECT c.CustomerID, s.SalesOrderID, s.OrderDate
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS s ON c.CustomerID = s.CustomerID
WHERE c.CustomerID IN (11028,11029,1,2,3,4);

-- LEFT OUTER JOIN to find rows with no match
SELECT c.CustomerID, s.SalesOrderID, s.OrderDate
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS s ON c.CustomerID = s.CustomerID
WHERE s.SalesOrderID IS NULL;

-- RIGHT OUTER JOIN
-- Think of Venn Diagram with 2 overlapping cicrles. 
-- This is e=quiavlent to the area of intersection and outer right section
SELECT c.CustomerID, s.SalesOrderID, s.OrderDate
FROM Sales.SalesOrderHeader AS s
RIGHT OUTER JOIN Sales.Customer AS c ON c.CustomerID = s.CustomerID
WHERE c.CustomerID IN (11028,11029,1,2,3,4);

--
-- Join on column that has NULLs in column (i.e. use outer join)
-- and want to show null value
--
IF OBJECT_ID('Student', 'U') IS NOT NULL DROP TABLE Student;
GO
IF OBJECT_ID('Tutor', 'U') IS NOT NULL DROP TABLE Tutor;
GO

CREATE TABLE Student (
   StudentId int,
   FirstName nvarchar(50),
   LastName nvarchar(50),
   TutorId int
);

CREATE TABLE Tutor (
   TutorId int,
   TutorName nvarchar(100)
);

INSERT INTO Student VALUES (1, 'Tony', 'Gyles', NULL), (2, 'Lara', 'Gyles', 89);

INSERT INTO Tutor VALUES (89, 'Matt Turner');

SELECT st.FirstName, st.LastName, tu.TutorName
FROM student st
LEFT OUTER JOIN Tutor tu ON st.TutorId = tu.TutorId;

-- SELF JOIN
CREATE TABLE #Employee (
EmployeeID int,
ManagerID int,
Title nvarchar(50));
INSERT INTO #Employee
VALUES (1, NULL, 'Chief Executive Officer')
INSERT INTO #Employee
VALUES (2, 1, 'Engineering Manager')
INSERT INTO #Employee
VALUES (3, 2, 'Senior Tool Designer')
INSERT INTO #Employee
VALUES (4, 2, 'Design Engineer')
INSERT INTO #Employee
VALUES (5, 2, 'Research and Development')
INSERT INTO #Employee
VALUES (6, 1, 'Marketing Manager')
INSERT INTO #Employee
VALUES (7, 6, 'Marketing Specialist');

SELECT 
a.EmployeeID AS Employee,
a.Title      AS EmployeeTitle,
b.EmployeeID AS ManagerID,
b.Title      AS ManagerTitle
FROM #Employee AS a
LEFT OUTER JOIN #Employee AS b ON a.ManagerID = b.EmployeeID;

DROP TABLE #Employee;

-- CROSS JOIN
-- Each row from one table ( m rows) multiples each row in the other table (n rows). Total rows = m x n.
IF OBJECT_ID('dbo.Digits', 'U') IS NOT NULL DROP TABLE dbo.Digits;
GO

CREATE TABLE dbo.Digits(digit int NOT NULL PRIMARY KEY);
GO

INSERT INTO dbo.Digits(digit) VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
GO

-- Create numbers from 1 .. 1000
SELECT D3.digit * 100 + D2.digit * 10 + D1.digit + 1 AS n
FROM dbo.Digits       AS D1
CROSS JOIN dbo.Digits AS D2
CROSS JOIN dbo.Digits AS D3
ORDER BY n;

-- Subquery and NOT IN
-- All customers without a sale
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE CustomerID NOT IN
(SELECT CustomerID FROM Sales.SalesOrderHeader);

--
-- UNION and UNION ALL
-- 

-- A UNION query is not really a join, but it is a way to merge the results of two or more queries together.
-- Each individual query must contain the same number of columns and be of compatible data types.
-- UNION removes duplicate records
-- UNION ALL includes duplicate rows

SELECT BusinessEntityID AS ID
FROM HumanResources.Employee
UNION
SELECT BusinessEntityID
FROM Person.Person
UNION
SELECT SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY ID;

SELECT BusinessEntityID AS ID
FROM HumanResources.Employee
UNION ALL
SELECT BusinessEntityID
FROM Person.Person
UNION ALL
SELECT SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY ID;

-- DERIVED TABLE
SELECT OrderYear, COUNT(SalesOrderId) AS numsales
FROM (SELECT YEAR(orderdate) AS OrderYear, SalesOrderId
FROM Sales.SalesOrderHeader) AS d
GROUP BY OrderYear;

SELECT c.CustomerID, d.SalesOrderID
FROM Sales.Customer AS c
INNER JOIN (SELECT SalesOrderID, CustomerID
FROM Sales.SalesOrderHeader) AS d ON c.CustomerID = d.CustomerID;

-- Common Table Expressions
WITH orders AS (
   SELECT SalesOrderID, CustomerID, OrderDate
   FROM Sales.SalesOrderHeader
   WHERE OrderDate = '2005/07/01'
)
SELECT c.CustomerID, orders.SalesOrderID, orders.OrderDate
FROM Sales.Customer AS c
LEFT OUTER JOIN orders ON c.CustomerID = orders.CustomerID
ORDER BY orders.OrderDate DESC;