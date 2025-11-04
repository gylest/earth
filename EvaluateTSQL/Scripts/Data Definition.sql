--
-- TABLES
--

--
-- SQL Constraints
-- 1) NOT NULL    - Ensures that a column cannot have a NULL value
-- 2) UNIQUE      - Ensures that all values in a column are different
-- 3) PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
-- 4) FOREIGN KEY - Uniquely identifies a row/record in another table
-- 5) CHECK       - Ensures that all values in a column satisfies a specific condition
-- 6) DEFAULT     - Sets a default value for a column when no value is specified

-- CHECK Constraints
IF OBJECT_ID('table5') IS NOT NULL BEGIN DROP TABLE table5; END;
IF OBJECT_ID('table4') IS NOT NULL BEGIN DROP TABLE table4; END;
IF OBJECT_ID('table3') IS NOT NULL BEGIN DROP TABLE table3; END;
IF OBJECT_ID('table2') IS NOT NULL BEGIN DROP TABLE table2; END;
IF OBJECT_ID('table1') IS NOT NULL BEGIN DROP TABLE table1; END;
IF OBJECT_ID('table0') IS NOT NULL BEGIN DROP TABLE table0; END;

-- Create Table with Column Constraints
CREATE TABLE table0 (
	col1 smallint,
	col2 varchar(20)
);

ALTER TABLE table0 ADD CONSTRAINT ch_table0_col1        CHECK (col1 BETWEEN 1 and 12);
ALTER TABLE table0 ADD CONSTRAINT ch_table0_col2_months CHECK (col2 IN ('January','February','March','April','May','June'))

INSERT INTO table0 (col1,col2) VALUES (1,'January');

SELECT * FROM table0;

-- This update should fail!
UPDATE table0 SET col1 = 20;

-- Create Table with UNIQUE column
CREATE TABLE table1 (
	col1 int UNIQUE,
	col2 varchar(20),
	col3 datetime2
);
GO

ALTER TABLE table1 ADD CONSTRAINT unq_table1_col2_col3 UNIQUE (col2,col3);

INSERT INTO table1(col1,col2,col3)
VALUES (1,2,'1/1/2009'),(2,2,'1/2/2009');

SELECT * FROM table1;


-- Create Tables with Foreign Key Relationship
CREATE TABLE table2 (
	col1 int NOT NULL PRIMARY KEY,
	col2 varchar(20),
	col3 datetime
);

CREATE TABLE table3 (
	col4 int NULL DEFAULT 7,
	col5 varchar(20) NOT NULL,
	CONSTRAINT pk_table2 PRIMARY KEY (col5),
	CONSTRAINT fk_table3_table2 FOREIGN KEY (col4) REFERENCES table2(col1)
);

-- Create Table with Identity Column
CREATE TABLE table4 (
	col1 varchar(10),
	idCol int NOT NULL IDENTITY,
	rvCol rowversion,
	defCol datetime2 DEFAULT GETDATE(),
	calcCol1 AS DATEADD(m,1,defCol),
	calcCol2 AS col1 + ':' + col1 PERSISTED
);

INSERT INTO table4 (col1)
VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('g');

INSERT INTO table4 (col1, defCol)
VALUES ('h', NULL),('i','1/1/2009');

SELECT * FROM table4;

--
-- Table with Composite Primary Key
--

-- A primary key may be made of one column or multiple columns, called a composite key
-- A table can have only one primary key
-- The values of a primary key must be unique
-- If the primary key is a composite key, the combination of the values must be unique
-- None of the columns making up a primary key can contain NULL values

CREATE TABLE [dbo].[table5] (
    [col1] int          NOT NULL,
    [col2] varchar (10) NOT NULL,
    [col3] int          NULL,
CONSTRAINT PK_table2_col1col2 PRIMARY KEY (col1, col2)
);

INSERT INTO table5 (col1, col2, col3)
VALUES (1,'2',3), (2,'2',4), (3,'5',6), (3,'6',9), (4,'9',22), (5,'78',101);

SELECT * FROM table5;

GO

--
-- VIEWS
--
IF OBJECT_ID('dbo.vw_Customer') IS NOT NULL BEGIN DROP VIEW dbo.vw_Customer; END;
GO

-- View from 2 tables
CREATE VIEW dbo.vw_Customer AS
SELECT c.CustomerID, c.AccountNumber, c.StoreID,
c.TerritoryID, p.FirstName, p.MiddleName,
p.LastName
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
GO
--3
SELECT CustomerID,AccountNumber,FirstName, MiddleName, LastName
FROM dbo.vw_Customer;

-- View which can be updated
-- Only the base table can be updated
IF OBJECT_ID('dbo.demoCustomer') IS NOT NULL BEGIN DROP TABLE dbo.demoCustomer; END;
IF OBJECT_ID('dbo.demoPerson')   IS NOT NULL BEGIN DROP TABLE dbo.demoPerson;   END;
IF OBJECT_ID('dbo.vw_Customer')  IS NOT NULL BEGIN DROP VIEW  dbo.vw_Customer;   END;

SELECT CustomerID, TerritoryID, StoreID, PersonID
INTO dbo.demoCustomer
FROM Sales.Customer;

SELECT BusinessEntityID, Title, FirstName, MiddleName, LastName
INTO dbo.demoPerson
From Person.Person;

IF OBJECT_ID('dbo.vw_Customer') IS NOT NULL BEGIN DROP VIEW dbo.vw_Customer; END;
GO

CREATE VIEW dbo.vw_Customer AS
SELECT CustomerID, TerritoryID, PersonID, StoreID,
Title, FirstName, MiddleName, LastName
FROM dbo.demoCustomer
INNER JOIN dbo.demoPerson ON PersonID = BusinessEntityID;
GO

SELECT CustomerID, FirstName, MiddleName, LastName
FROM dbo.vw_Customer
WHERE CustomerID IN (5,10,15,20);

INSERT INTO dbo.vw_Customer(TerritoryID,StoreID, PersonID)
VALUES (5,5,100000);
GO

--
-- User-Defined Functions (UDFs)
--

-- Scalar Function
IF OBJECT_ID (N'dbo.ufnGetInventoryStock', N'FN') IS NOT NULL BEGIN DROP FUNCTION ufnGetInventoryStock; END;
GO

CREATE FUNCTION dbo.ufnGetInventoryStock(@ProductID int)
RETURNS int 
AS 
-- Returns the stock level for the product.
BEGIN
    DECLARE @ret int;
    SELECT @ret = SUM(p.Quantity) 
    FROM Production.ProductInventory p 
    WHERE p.ProductID = @ProductID  AND p.LocationID = '6';
    IF (@ret IS NULL) SET @ret = 0;
    RETURN @ret;
END;
GO

SELECT ProductModelID, Name, dbo.ufnGetInventoryStock(ProductID)AS CurrentSupply
FROM Production.Product
WHERE ProductModelID BETWEEN 75 and 80;

-- Table-Valued Function
IF OBJECT_ID (N'dbo.ufn_SalesByStore', N'IF') IS NOT NULL BEGIN DROP FUNCTION dbo.ufn_SalesByStore; END;
GO

CREATE FUNCTION dbo.ufn_SalesByStore (@storeid int)
RETURNS TABLE
AS
RETURN 
(
    SELECT P.ProductID, P.Name, SUM(SD.LineTotal) AS 'Total'
    FROM Production.Product AS P 
    JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID = P.ProductID
    JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID
    JOIN Sales.Customer AS C ON SH.CustomerID = C.CustomerID
    WHERE C.StoreID = @storeid
    GROUP BY P.ProductID, P.Name
);
GO

SELECT * FROM dbo.ufn_SalesByStore (602);

--
-- Stored Procedues
--

-- Stored procedure with input parameters
IF OBJECT_ID('dbo.uspGetEmployeesTest2') IS NOT NULL BEGIN DROP PROC dbo.uspGetEmployeesTest2; END;
GO

CREATE PROCEDURE dbo.uspGetEmployeesTest2 
    @LastName  nvarchar(50), 
    @FirstName nvarchar(50) 
AS 

    SET NOCOUNT ON;
	
	SELECT per.Title, per.FirstName, per.LastName, emp.JobTitle, emp.HireDate, emp.NationalIDNumber
    FROM HumanResources.Employee as emp
	inner join person.person as per on emp.BusinessEntityID = per.BusinessEntityID
    WHERE per.FirstName = @FirstName AND per.LastName = @LastName

GO

EXECUTE dbo.uspGetEmployeesTest2 N'Ackerman', N'Pilar';
EXEC    dbo.uspGetEmployeesTest2 @LastName = N'Ackerman', @FirstName = N'Pilar';

GRANT EXECUTE ON OBJECT::dbo.uspGetEmployeesTest2 TO Guest;

-- Stored procedure with output parameter
IF OBJECT_ID('dbo.usp_OrderDetailCount') IS NOT NULL BEGIN DROP PROC dbo.usp_OrderDetailCount; END;
GO

CREATE PROC dbo.usp_OrderDetailCount @OrderID int, @Count int OUTPUT AS
	SELECT @Count = COUNT(*)
	FROM Sales.SalesOrderDetail
GO

DECLARE @OrderCount int;
EXEC usp_OrderDetailCount 71774, @OrderCount OUTPUT;
PRINT @OrderCount;

--
-- Dynamic SQL
--

-- Dynamic SQL is a programming technique that enables you to build SQL statements dynamically at runtime.
-- There is a possibility of SQL injection when you construct the SQL statement by concatenating strings from user input values e.g. "Gyles;DELETE * FROM dbo.Product;".
-- You should use dynamic SQL in cases where static SQL does not support the operation you want to perform.
DECLARE @SQL1           nvarchar(1000);
DECLARE @SQL2           nvarchar(1000);
DECLARE @IntVariable    varchar(50) = '740';
DECLARE @ParmDefinition nvarchar(500);

SET @ParmDefinition = N'@Pid int'; 
 
SET @SQL1 = 'SELECT Name, ProductNumber,Color FROM [Production].[Product] where ProductID = ' + @IntVariable;
SET @SQL2 = 'SELECT Name, ProductNumber,Color FROM [Production].[Product] where ProductID = @Pid';

-- Two ways to execute dynamic sql
-- Prefer sp_executesql over exec because:-
-- 1) Parameter definition can stop sql injection attack as in example below only integer is excepted
-- 2) sp_executesql can leverage cached query plans
EXEC (@SQL1);

EXECUTE sp_executesql @SQL2, @ParmDefinition, @Pid = @IntVariable;

--
-- CLR Procedure and Function
--
-- When you need to create a procedure or function that uses complex procedural logic that is difficult in TSQL
-- you can create a method in C#
--
-- Three step process:-
-- 1) Create a new .NET DLL using Visual Studio using C#
-- 2) Create a method in C# and markup with the attribute [Microsoft.SqlServer.Server.SqlProcedure] or [SqlFunction] for procedure or function
-- 3) Create the SQL Server object (stored procedure, function, UDF) by referencing assembly created
--
-- To run CLR routines this option must be enabled
-- EXEC sp_configure 'clr enabled', 1
--
-- NO example shown here

--
-- User-Defined Data Types
--
IF TYPE_ID(N'[dbo].[AccountNumber2]') IS NOT NULL BEGIN DROP TYPE [dbo].[AccountNumber2]; END;
GO

CREATE TYPE [dbo].[AccountNumber2] FROM [nvarchar](15) NULL;
GO


--
-- Triggers
--
-- 2 Types:-
-- After Trigger
-- Instead Of Trigger
--

-- After Trigger
IF OBJECT_ID ('[Purchasing].[NewPODetail3]', 'TR') IS NOT NULL  DROP TRIGGER [Purchasing].[NewPODetail3];
GO

CREATE TRIGGER NewPODetail3
ON [Purchasing].[PurchaseOrderDetail]
FOR INSERT AS
IF @@ROWCOUNT = 1
BEGIN
   UPDATE Purchasing.PurchaseOrderHeader
   SET SubTotal = SubTotal + LineTotal
   FROM inserted
   WHERE PurchaseOrderHeader.PurchaseOrderID = inserted.PurchaseOrderID
END
ELSE
BEGIN
   UPDATE Purchasing.PurchaseOrderHeader
   SET SubTotal = SubTotal + 
      (SELECT SUM(LineTotal)
      FROM inserted
      WHERE PurchaseOrderHeader.PurchaseOrderID
       = inserted.PurchaseOrderID)
   WHERE PurchaseOrderHeader.PurchaseOrderID IN
      (SELECT PurchaseOrderID FROM inserted)
END;
GO

-- An INSTEAD OF trigger is a trigger that allows you to skip an INSERT, DELETE, or UPDATE statement
-- to a table or a view and execute other statements defined in the trigger instead.
-- The actual insert, delete, or update operation does not occur at all.