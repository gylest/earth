-- Concatenating Strings
SELECT BusinessEntityID, FirstName, LastName, FirstName + ' ' + LastName as 'Full Name'
FROM Person.Person

-- Concatenating strings with CONCAT() function , ensures a null doesn't force result to null
-- Compare 2 queries below, the CONCAT function works as expected
SELECT BusinessEntityID, FirstName + ' ' + MiddleName +
' ' + LastName AS "Full Name"
FROM Person.Person;

SELECT BusinessEntityID, CONCAT(FirstName,' ',MiddleName,' ',LastName) AS "Full Name"
FROM Person.Person;

-- ISNULL() and COALESCE()
-- Both functions replace NULL values with another value
-- COALESCE() is ANSI compliant
SELECT BusinessEntityID, FirstName + ISNULL(' ' + MiddleName,'') +
' ' + LastName AS "Full Name"
FROM Person.Person;

SELECT BusinessEntityID, FirstName + COALESCE(' ' + MiddleName,'') +
' ' + LastName AS "Full Name"
FROM Person.Person;

-- CAST() and CONVERT()
-- Converting other data types to strings
-- CAST() is ANSI compliant
SELECT CAST(BusinessEntityID AS nvarchar) + ': ' + LastName
+ ', ' + FirstName AS ID_Name
FROM Person.Person;

SELECT CONVERT(nvarchar(10),BusinessEntityID) + ': ' + LastName
+ ', ' + FirstName AS ID_Name
FROM Person.Person;

-- Mathmatical Operators
SELECT OrderQty, OrderQty * 10 AS Times10
FROM Sales.SalesOrderDetail;

--
-- STRING Functions
--

-- RTRIM(), LTRIM()
-- Trim left and right spaces
DECLARE @myname nvarchar(50);
SET @myname = ' jennifer ';
SELECT @myname,LTRIM(@myname), RTRIM(@myname)

-- LEFT(), RIGHT()
-- Get x characters from left or right
SELECT LastName,LEFT(LastName,5) AS "LEFT",
RIGHT(LastName,4) AS "RIGHT"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- LEN()        returns number of characters
-- DATALENGTH() returns number of bytes
SELECT LastName,LEN(LastName) AS "Length",
DATALENGTH(LastName) AS "Data Length"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- CHARINDEX()
-- Return starting position of a string
SELECT LastName, CHARINDEX('e',LastName) AS "Find e",
CHARINDEX('e',LastName,4) AS "Skip 4 Characters",
CHARINDEX('be',LastName) AS "Find be",
CHARINDEX('Be',LastName) AS "Find B"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- UPPER(), LOWER()
SELECT LastName, UPPER(LastName) AS "UPPER",
LOWER(LastName) AS "LOWER"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- REPLACE()
-- Substitute a string
SELECT LastName, REPLACE(LastName,'A','Z') AS "Replace A",
REPLACE(LastName,'A','ZZ') AS "Replace with 2 characters",
REPLACE(LastName,'ab','') AS "Remove string"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- SUBSTRING()
-- Returns part of a string
SELECT LastName, SUBSTRING(LastName,1,4) AS "First 4", SUBSTRING(LastName,5,50) AS "Characters 5 and later"
FROM Person.Person
WHERE BusinessEntityID IN (1,50,167,201,285,6170);

-- REVERSE()
-- Returns the reverse order of a string value
SELECT REVERSE('!dlroW ,olleH') as ReverseValue;

--
-- DATE Functions
--

-- GETDATE()    returns datetime
-- GETSYSDATE() returns datetime2
SELECT GETDATE(), SYSDATETIME();

-- DATEADD()
SELECT OrderDate, DATEADD(year,1,OrderDate) AS OneMoreYear, DATEADD(month,1,OrderDate) AS OneMoreMonth, DATEADD(day,-1,OrderDate) AS OneLessDay
FROM Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);

-- DAY(), MONTH(), YEAR()
SELECT OrderDate, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, DAY(OrderDate) AS OrderDay
FROM Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);

-- FORMAT()
-- Convert date into string format
DECLARE @d1 datetime2 = SYSDATETIME();
SELECT FORMAT ( @d1, 'd', 'en-US' ) AS 'US Date'  
      ,FORMAT ( @d1, 'd', 'en-gb' ) AS 'UK Date'
      ,FORMAT ( @d1, 'd', 'ja' )    AS 'Japanese Date';

DECLARE @d2 datetime2 = SYSDATETIME();
SELECT FORMAT( @d2, 'dd/MM/yyyy hh:mm:ss', 'en-GB' ) AS Result;

--
-- Mathmatical Functions
--

-- ABS()
SELECT ABS(2) AS "2", ABS(-2) AS "-2";

-- POWER()
SELECT POWER(10,1) AS "Ten to the First",POWER(10,2) AS "Ten to the Second";

-- SQUARE(), SQRT()
SELECT '10' as '10',SQUARE(10) AS "Square of 10",SQRT(10) AS "Square Root of 10";

-- ROUND()
SELECT ROUND(1234.1294,2)    AS "2 places on the right",
       ROUND(1234.1294,-2)   AS "2 places on the left",
       ROUND(1234.1294,2,1)  AS "Truncate 2",
       ROUND(1234.1294,-2,1) AS "Truncate -2";

-- FLOOR()   - Returns the largest integer less than or equal to the specified numeric expression.
-- CEILING() - Returns the smallest integer greater than, or equal to, the specified numeric expression.
-- SIGN()    - Returns the positive (+1), zero (0), or negative (-1) sign of the specified expression
-- RAND()    - Create a random number
SELECT FLOOR(123.45) as RoundDownResult,  CEILING(123.45) as RoundUpResult
SELECT SIGN(-125), SIGN(0), SIGN(564);
SELECT CAST(RAND() * 100 AS int) + 1 AS "1 to 100";

--
-- System Functions
--

-- CASE
SELECT Title,
CASE Title
WHEN 'Mr.' THEN 'Male'
WHEN 'Ms.' THEN 'Female'
WHEN 'Mrs.' THEN 'Female'
WHEN 'Miss' THEN 'Female'
ELSE 'Unknown' END AS Gender
FROM Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423);

-- IIF
SELECT IIF (50 > 20, 'TRUE', 'FALSE') AS RESULT;

--
-- ADMIN Functions
--
SELECT DB_NAME()    AS "Database Name", HOST_NAME()  AS "Host Name", CURRENT_USER AS "Current User", USER_NAME()  AS "User Name", APP_NAME()   AS "App Name";


--
-- TOP Keyword
--
SELECT TOP(5) *
FROM Person.Person
ORDER BY LastName DESC;

--
-- RANKING Functions
--

-- ROW_NUMBER()   numbers all rows sequentially
-- RANK()         provides the same numeric value for ties and following values have rank adjusted accordingly
-- DENSE_RANK()   returns the rank of each row within a result set with no gaps in the ranking values
-- NTILE()        divides rows equally into a number of buckets set
SELECT ROW_NUMBER() OVER(ORDER by City ASC) AS ROWNUM_CITY,
       RANK()       OVER(ORDER BY City ASC) AS RANK_CITY,
       DENSE_RANK() OVER(ORDER BY City ASC) AS DENSERANK_CITY,
       NTILE(4)     OVER(ORDER BY City ASC) AS NTILE_CITY,
       [AddressLine1]
      ,[City]
  FROM [EvaluateTSQL].[Person].[Address];

--
-- PARTITION BY
--

-- The PARTITION BY clause divides the result set into partitions. 
-- The ROW_NUMBER() function is applied to each partition separately and reinitialized the row number for each partition.
-- The PARTITION BY clause is optional. If you skip it, the ROW_NUMBER() function will treat the whole result set as a single partition.
SELECT CustomerID, FirstName + ' ' + LastName AS Name, c.TerritoryID, ROW_NUMBER() OVER (PARTITION BY c.TerritoryID ORDER BY LastName, FirstName) AS Row
FROM Sales.Customer AS c INNER JOIN Person.Person AS p
ON c.PersonID = p.BusinessEntityID;