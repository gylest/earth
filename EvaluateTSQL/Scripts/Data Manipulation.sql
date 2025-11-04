--
-- INSERT
--

-- SETUP
IF OBJECT_ID('demoCustomer') IS NOT NULL BEGIN DROP TABLE demoCustomer; END;
GO

CREATE TABLE demoCustomer(
CustomerID int NOT NULL PRIMARY KEY,
FirstName nvarchar(50) NOT NULL,
MiddleName nvarchar(50) NULL,
LastName nvarchar(50) NOT NULL);
GO

-- ENDSETUP

-- INSERT (one row with literals)
INSERT INTO dbo.demoCustomer (CustomerID, FirstName, MiddleName, LastName)
VALUES (1,'Orlando','N.','Gee');

-- INSERT (Multiple rows with 1 statement)
INSERT INTO dbo.demoCustomer (CustomerID, FirstName, MiddleName, LastName)
VALUES
(12,'Johnny','A.','Capino'),
(16,'Christopher','R.','Beck'),
(18,'David','J.','Liu');

-- INSERT (rows from another table)
INSERT INTO dbo.demoCustomer (CustomerID, FirstName, MiddleName, LastName)
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID BETWEEN 19 AND 35;

-- SELECT INTO (Create a new table and copy data into it, used by developers)
DROP TABLE demoCustomer;
GO

SELECT *
INTO dbo.demoCustomer
FROM Person.Person;

-- INSERT (rows into table with DEFAULT values)

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoDefault]') AND type in (N'U')) DROP TABLE [dbo].[demoDefault]
GO

CREATE TABLE [dbo].[demoDefault](
[KeyColumn] [int] NOT NULL PRIMARY KEY,
[HasADefault1] [datetime2](1) NOT NULL,
[HasADefault2] [nvarchar](50) NULL,
)
GO

ALTER TABLE [dbo].[demoDefault] ADD CONSTRAINT [DF_demoDefault_HasADefault]
DEFAULT (GETDATE()) FOR [HasADefault1]
GO
ALTER TABLE [dbo].[demoDefault] ADD CONSTRAINT [DF_demoDefault_HasADefault2]
DEFAULT ('the default') FOR [HasADefault2]
GO

INSERT INTO dbo.demoDefault (HasADefault1,HasADefault2,KeyColumn)
VALUES (DEFAULT,DEFAULT,3),(DEFAULT,DEFAULT,4);

SELECT * FROM [dbo].[demoDefault];
GO
--
-- DELETE and TRUNCATE
--

--
-- TRUNCATE - removes all rows from a table or specified partitions of a table, without logging the individual row deletions. 
--          - is faster and uses fewer system and transaction log resources than DELETE
--          - if the table contains an identity column, the counter for that column is reset to the seed value defined for the column. 
--
-- DELETE   - removes one or more rows from a table or view in SQL Server, use WHERE clause to limit
--          - each deletion is logged, and hence data can be recovered from transaction log
--          - if the table contains an identity column, the counter for that column is unchanged
--



-- SETUP
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoProduct]') AND type in (N'U')) DROP TABLE [dbo].[demoProduct];
GO
SELECT * INTO dbo.demoProduct FROM Production.Product;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoCustomer]') AND type in (N'U')) DROP TABLE [dbo].[demoCustomer];
GO
SELECT * INTO dbo.demoCustomer FROM Sales.Customer;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoAddress]') AND type in (N'U')) DROP TABLE [dbo].[demoAddress];
GO
SELECT * INTO dbo.demoAddress FROM Person.Address;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoSalesOrderHeader]') AND type in (N'U')) DROP TABLE [dbo].[demoSalesOrderHeader];
GO
SELECT * INTO dbo.demoSalesOrderHeader FROM Sales.SalesOrderHeader;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoSalesOrderDetail]') AND type in (N'U')) DROP TABLE [dbo].[demoSalesOrderDetail];
GO
SELECT * INTO dbo.demoSalesOrderDetail FROM Sales.SalesOrderDetail;
GO

SELECT * FROM dbo.demoProduct
SELECT * FROM dbo.demoCustomer
SELECT * FROM dbo.demoAddress
SELECT * FROM dbo.demoSalesOrderHeader
SELECT * FROM dbo.demoSalesOrderDetail
GO
-- END SETUP


-- DELETE (all rows in table)
DELETE [dbo].[demoDefault];
GO

-- DELETE (all rows in table, faster way)
TRUNCATE TABLE [dbo].[demoDefault];
GO

-- DELETE (specific rows based on a query)
DELETE dbo.demoSalesOrderDetail
SELECT d.SalesOrderID
FROM dbo.demoSalesOrderDetail AS d
INNER JOIN dbo.demoSalesOrderHeader AS h ON d.SalesOrderID = h.SalesOrderID
WHERE h.SalesOrderNumber = 'SO71797';
GO

--
-- UPDATE
--

-- SETUP
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoPerson]') AND type in (N'U')) DROP TABLE [dbo].[demoPerson]
GO

SELECT * INTO dbo.demoPerson
FROM Person.Person
WHERE Title in ('Mr.', 'Mrs.', 'Ms.')
GO

SELECT * FROM dbo.demoPerson
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoPersonStore]') AND type in (N'U')) DROP TABLE [dbo].[demoPersonStore]
GO

CREATE TABLE [dbo].[demoPersonStore] (
[FirstName]   nvarchar (60),
[LastName]    nvarchar (60),
[CompanyName] nvarchar (60)
);
GO

INSERT INTO dbo.demoPersonStore (FirstName, LastName, CompanyName)
SELECT a.FirstName, a.LastName, c.Name
FROM Person.Person a
JOIN Sales.SalesPerson b
ON a.BusinessEntityID = b.BusinessEntityID
JOIN Sales.Store c
ON b.BusinessEntityID = c.SalesPersonID
GO

-- END SETUP

-- UPDATE ( simple)
UPDATE dbo.demoPerson
SET NameStyle = 1;

-- UPDATE ( with expression)
UPDATE dbo.demoPersonStore
SET CompanyName = LEFT(FirstName,3) + '.' + LEFT(LastName,3);

-- UPDATE ( using INNER JOIN)
UPDATE a
SET AddressLine1 = FirstName + ' ' + LastName,
    AddressLine2 = AddressLine1 + ISNULL(' ' + AddressLine2,'')
FROM dbo.demoAddress AS a
INNER JOIN Person.BusinessEntityAddress c ON a.AddressID = c.AddressID
INNER JOIN Person.Person b ON b.BusinessEntityID = c.BusinessEntityID

--
-- TRANSACTIONS
--

-- SETUP
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demoTransaction]') AND type in (N'U')) DROP TABLE [dbo].[demoTransaction];
GO
CREATE TABLE dbo.demoTransaction (col1 int NOT NULL);
GO

-- END SETUP

-- TRANSACTION (with COMMIT)
BEGIN TRAN
	INSERT INTO dbo.demoTransaction (col1) VALUES (1);
	INSERT INTO dbo.demoTransaction (col1) VALUES (2);
COMMIT TRAN

-- TRANSACTION (with ROLLBACK)
BEGIN TRAN
	INSERT INTO dbo.demoTransaction (col1) VALUES (1);
	INSERT INTO dbo.demoTransaction (col1) VALUES (2);
ROLLBACK TRAN