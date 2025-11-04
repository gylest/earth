-- CONVERT XML into data
DECLARE @hdoc int
DECLARE @doc varchar(1000) = N'
<Products>
	<Product ProductID="32565451" ProductName="Bicycle Pump">
		<Order ProductID="32565451" SalesID="5" OrderDate="2011-07-04T00:00:00">
			<OrderDetail OrderID="10248" CustomerID="22" Quantity="12"/>
			<OrderDetail OrderID="10248" CustomerID="11" Quantity="10"/>
		</Order>
	</Product>
	<Product ProductID="57841259" ProductName="Bicycle Seat">
		<Order ProductID="57841259" SalesID="3" OrderDate="2011-08-16T00:00:00">
			<OrderDetail OrderID="54127" CustomerID="72" Quantity="3"/>
		</Order>
	</Product>
</Products>';
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc
SELECT *
FROM OPENXML(@hdoc, N'/Products/Product');
EXEC sp_xml_removedocument @hdoc;

--
-- Retrieving Data as XML
--

-- FOR XML RAW
SELECT TOP 5 FirstName
FROM Person.Person
FOR XML RAW;

-- FOR XML AUTO
SELECT CustomerID, LastName, FirstName, MiddleName
FROM Person.Person AS p
INNER JOIN Sales.Customer AS c ON p.BusinessEntityID = c.PersonID
FOR XML AUTO;

-- FOR XML EXPLICIT
-- Powerful but cumbersome to use
SELECT	1 AS Tag,
		NULL AS Parent,
		CustomerID AS [Customer!1!CustomerID],
		NULL AS [Name!2!FName],
		NULL AS [Name!2!LName]
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P
ON P.BusinessEntityID = C.PersonID
UNION
SELECT	2 AS Tag,
		1 AS Parent,
		CustomerID,
		FirstName,
		LastName
FROM Person.Person P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY [Customer!1!CustomerID], [Name!2!FName]
FOR XML EXPLICIT;

-- FOR XML PATH
-- Creates an element centric XML document, gives good results with simple SELECT statement
SELECT	p.FirstName,
		p.LastName,
		s.Bonus,
		s.SalesYTD
FROM Person.Person p
JOIN Sales.SalesPerson s
ON p.BusinessEntityID = s.BusinessEntityID
FOR XML PATH

-- XML Data Type
CREATE TABLE #CustomerList (CustomerInfo XML);
--2
DECLARE @XMLInfo XML;
--3
SET @XMLInfo = (SELECT CustomerID, LastName, FirstName, MiddleName
FROM Person.Person AS p
INNER JOIN Sales.Customer AS c ON p.BusinessEntityID = c.PersonID
FOR XML PATH);
--4
INSERT INTO #CustomerList(CustomerInfo)
VALUES(@XMLInfo);
--5
SELECT CustomerInfo FROM #CustomerList;

-- XML Method for XML Data TYpe

-- query(xquery)			Executes XQuery against the XML data type
-- value(xquery, sqltype)	Executes XQuery against the XML data type and returns a SQL scalar value
-- exists(xquery)			Executes XQuery against the XML data type and returns a BIT value: 1 at least 1 node, 2 no nodes
-- modify(xml_dml)			Used to update XML stored as the XML data type
-- nodes()					Method to convert XML data type into a table