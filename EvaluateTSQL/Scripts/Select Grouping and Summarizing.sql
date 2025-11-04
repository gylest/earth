-- AGGREGATE FUNCTIONS
SELECT COUNT(*) AS CountOfRows,
	   MAX(TotalDue) AS MaxTotal,
	   MIN(TotalDue) AS MinTotal,
	   SUM(TotalDue) AS SumOfTotal,
	   AVG(TotalDue) AS AvgTotal
FROM Sales.SalesOrderHeader;

-- GROUP BY Clause
SELECT CustomerID,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID;

-- Grouping on expressions
SELECT COUNT(*) AS CountOfOrders, YEAR(OrderDate) AS OrderYear
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

-- WHERE Clause
SELECT CustomerID, TerritoryID,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
WHERE TerritoryID in (5,6)
GROUP BY CustomerID, TerritoryID

-- Having Clause
SELECT CustomerID,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) > 65000
ORDER BY CustomerID;

-- Aggregate queries with more than 1 table
SELECT c.CustomerID, c.AccountNumber,COUNT(s.SalesOrderID) AS CountOfOrders,
SUM(COALESCE(TotalDue,0)) AS SumOfTotalDue
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.AccountNumber
ORDER BY c.CustomerID;

-- Correlated Subquery
-- Select all orders which have 4 items
SELECT CustomerID, SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader AS soh
WHERE 4 =
(SELECT COUNT(*)
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = soh.SalesOrderID);

-- Using Derived Tables
SELECT c.CustomerID, SalesOrderID, TotalDue, AvgOfTotalDue, TotalDue/SumOfTotalDue * 100 AS SalePercent
FROM Sales.SalesOrderHeader AS soh
INNER JOIN
(SELECT CustomerID, SUM(TotalDue) AS SumOfTotalDue,
AVG(TotalDue) AS AvgOfTotalDue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID) AS c ON soh.CustomerID = c.CustomerID
ORDER BY c.CustomerID;

-- Using Common Table Expression
WITH c AS (
	SELECT CustomerID, SUM(TotalDue) AS SumOfTotalDue, AVG(TotalDue) AS AvgOfTotalDue
	FROM Sales.SalesOrderHeader
	GROUP BY CustomerID
)
	SELECT c.CustomerID, SalesOrderID, TotalDue,AvgOfTotalDue,TotalDue/SumOfTotalDue * 100 AS SalePercent
	FROM Sales.SalesOrderHeader AS soh
	INNER JOIN c ON soh.CustomerID = c.CustomerID
	ORDER BY c.CustomerID;

-- Using OVER clause to add aggregate values to nonaggregate query
SELECT CustomerID, SalesOrderID, TotalDue, AVG(TotalDue) OVER(PARTITION BY CustomerID) AS AvgOfTotalDue,
       SUM(TotalDue) OVER(PARTITION BY CustomerID) AS SumOfTOtalDue,
	   TotalDue/(SUM(TotalDue) OVER(PARTITION BY CustomerID)) * 100 AS SalePercentPerCustomer,
	   SUM(TotalDue) OVER() AS SalesOverAll
FROM Sales.SalesOrderHeader
ORDER BY CustomerID;

--
-- CUBE and ROLLUP
--
SELECT COUNT(*) AS CountOfRows, Color, ISNULL(Size,CASE WHEN GROUPING(Size) = 0 THEN 'UNK' ELSE 'ALL' END) AS Size
FROM Production.Product
GROUP BY Color,Size
ORDER BY Size;

SELECT COUNT(*) AS CountOfRows, Color, ISNULL(Size,CASE WHEN GROUPING(Size) = 0 THEN 'UNK' ELSE 'ALL' END) AS Size
FROM Production.Product
GROUP BY CUBE(Color,Size)
ORDER BY Size;

SELECT COUNT(*) AS CountOfRows, Color, ISNULL(Size,CASE WHEN GROUPING(Size) = 0 THEN 'UNK' ELSE 'ALL' END) AS Size
FROM Production.Product
GROUP BY ROLLUP(Color,Size)
ORDER BY Size;