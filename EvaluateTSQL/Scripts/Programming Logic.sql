-- Declare and Initialize Variables
DECLARE @myNumber int = 10;
PRINT 'The value of @myNumber';
PRINT @myNumber;
SET @myNumber = 20;
PRINT 'The value of @myNumber';
PRINT @myNumber;
GO

-- Using Variables in WHERE clause
DECLARE @ID int;
SET @ID = 1;
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID = @ID;
GO

-- IF-ELSE
DECLARE @Count int;
SELECT @Count = COUNT(*)
FROM Sales.Customer;
IF @Count < 500 PRINT 'The customer count is less than 500.';
ELSE PRINT 'The customer count is 500 or more.';
GO

-- IF Exists
DECLARE @BusID int = 778
IF EXISTS(SELECT * FROM Person.Person WHERE BusinessEntityID = @BusID) BEGIN
PRINT 'There is a row with BusinessEntityID = ' + CAST(@BusID AS nvarchar);
END
ELSE BEGIN
PRINT 'There is not a row with BusEntityID = ' + CAST(@BusID AS nvarchar);
END;
GO

-- WHILE
DECLARE @Count int = 1;
WHILE @Count < 5 BEGIN
PRINT @Count;
SET @Count += 1;
END;
GO

-- BREAK (Exiting a loop early)
DECLARE @Count int = 1;
WHILE @Count < 50 BEGIN
	PRINT @Count;
	IF @Count = 10 BEGIN
		PRINT 'Exiting the WHILE loop';
		BREAK;
	END;
	SET @Count += 1;
END;
GO

-- CONTINUE ( Cause loop to continue at the top)
DECLARE @Count int = 1;
WHILE @Count < 10 BEGIN
	PRINT @Count;
	SET @Count += 1;
	IF @Count = 3 BEGIN
		PRINT 'CONTINUE';
		CONTINUE;
	END;
	PRINT 'Bottom of loop';
END;
GO

-- @@ERROR
DECLARE @errorNo int;
PRINT 1/0;
SET @errorNo = @@ERROR;
IF @errorNo > 0 BEGIN
	PRINT 'An error has occurred.'
	PRINT @errorNo;
	PRINT @@ERROR;
END;
GO

-- TRY ... CATCH
BEGIN TRY
	PRINT 1/0;
END TRY
BEGIN CATCH
	PRINT 'Inside the Catch block';
	PRINT ERROR_NUMBER();
	PRINT ERROR_MESSAGE();
	PRINT ERROR_NUMBER();
END CATCH
PRINT 'Outside the catch block';
PRINT ERROR_NUMBER()
GO

-- RAISERROR
IF NOT EXISTS(SELECT * FROM Sales.Customer WHERE CustomerID = -1)
BEGIN
	RAISERROR(50002,16,1);
END
GO

-- THROW
BEGIN TRY
	INSERT INTO Person.Person (BusinessEntityID, PersonType,NameStyle,FirstName,LastName,EmailPromotion,ModifiedDate)
	VALUES (1, 'EM', 0,'Tony','Gyles',0, SYSDATETIME());
END TRY
BEGIN CATCH
	THROW 999999, 'I will not allow you to insert a duplicate value.', 1;
END CATCH
GO

--
-- Local Temporary Tables (table name prefixed by #)
-- 1. Table is created in TempDB using collation of TempDB
-- 2. Local temporary tables are visible only in the current session. So if you create another connection you will not see it.
-- 3. If local temporary table is created in a stored procedure, it is dropped automatically when the stored procedure is finished.
-- 4. If local temporary table is created in a script, it is dropped automatically when the connection ends.
--
CREATE TABLE #myCustomers(CustomerID int, FirstName varchar(25), LastName varchar(25));
GO

INSERT INTO #myCustomers(CustomerID,FirstName,LastName)
SELECT C.CustomerID, FirstName, LastName
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID;
GO

SELECT CustomerID, FirstName, LastName
FROM #myCustomers;
GO

DROP TABLE #myCustomers;
GO

--
-- Global Temporary Tables (table name prefixed by ##)
-- 1. Table is created in TempDB using collation of TempDB
-- 2. Global temporary tables are visible in all connections.
-- 3. Global temporary table is automatically dropped when the session that created the table ends and the last active TSQL statement referencing this table in other sessions ends.
--
CREATE TABLE ##myCustomers(CustomerID int, FirstName varchar(25),
LastName VARCHAR(25));
GO

INSERT INTO ##myCustomers(CustomerID,FirstName,LastName)
SELECT C.CustomerID, FirstName,LastName
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID;
GO

SELECT CustomerID, FirstName, LastName
FROM ##myCustomers;
GO

DROP TABLE ##myCustomers;
GO

-- Table Variables
-- Created in tempDB
-- Does not allow full use of features as per a real table, e.g. certain types of indexes
DECLARE @IDTable TABLE(ArrayIndex int NOT NULL IDENTITY, ID int);
DECLARE @RowCount int;

DECLARE @ID int;
DECLARE @Count int = 1;
--3
INSERT INTO @IDTable(ID)
VALUES(500),(333),(200),(999);

SELECT @RowCount = COUNT(*)
FROM @IDTable;

SELECT * FROM @IDTable;

--
-- CURSOR
--
DECLARE @ProductID int;
DECLARE @Name nvarchar(25);

DECLARE products CURSOR FAST_FORWARD FOR
SELECT ProductID, Name FROM Production.Product;

OPEN products;

FETCH NEXT FROM products INTO @ProductID, @Name;

WHILE @@FETCH_STATUS = 0 BEGIN
	PRINT @ProductID;
	PRINT @Name;
	FETCH NEXT FROM products INTO @ProductID, @Name;
END

CLOSE products;
DEALLOCATE products;