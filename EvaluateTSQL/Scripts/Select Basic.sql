-- Select a literal
SELECT 'ABC'

-- Select from a table
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee;

-- Where clause
SELECT CustomerID, SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate > '2014-06-29';

-- Where clause with comparison operator
SELECT SalesOrderID, SalesOrderDetailID, OrderQty
FROM Sales.SalesOrderDetail
WHERE OrderQty <= 10;

-- MIN() and MAX() functions
SELECT MIN(OrderDate) as MinDate, MAX(Orderdate) as MaxDate
FROM Sales.SalesOrderHeader;

-- Where clause with BETWEEN operator
SELECT CustomerID, SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2014-06-29 00:00' AND '2014-06-29 18:00';

--
-- Pattern matching with LIKE operator
--

--   %   = Matches any string of zero or more characters. This wildcard character can be used as either a prefix or a suffix.
--   []  = Matches any single character within the specified range or set that is specified between brackets [ ].
--   [^] = Matches any single character that is not within the range or set specified between brackets [ ].

SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE '%and%';

SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'R[d-z]%';

SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'R[^d-z]%';

-- Where clause with multiple predicates
SELECT BusinessEntityID,FirstName,MiddleName,LastName
FROM Person.Person
WHERE LastName = 'Duffy' OR LastName = 'Wood' AND FirstName = 'Brown';

-- Using IN operator
SELECT TerritoryID, Name
FROM Sales.SalesTerritory
WHERE TerritoryID IN (2,1,4,5);

-- Working with NULL
SELECT MiddleName
FROM Person.Person
WHERE MiddleName IS NULL
OR MiddleName !='B';

-- Sorting Data
SELECT ProductID, LocationID
FROM Production.ProductInventory
ORDER BY ProductID, LocationID DESC

--
-- Return subset of rows
-- OFFSET             - Row count for start of data
-- FETCH NEXT .. ONLY - Limit the number of rows returned
--
SELECT ProductID, LocationID
FROM   Production.ProductInventory
ORDER BY ProductID, LocationID DESC
OFFSET 200 ROWS
FETCH NEXT 100 ROWS ONLY;