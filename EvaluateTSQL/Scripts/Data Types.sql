SET NOCOUNT ON;

--
-- String Data Types
--

--		NAME				Type					Maximum Characters		Character Set    Replaces Deprecated Types
--      ====				====					==================		=============    ==========================
--		char				Fixed Width				8000					ASCII
--		nchar				Fixed Width				4000					Unicode
--		varchar				Variable Width			8000					ASCII
--		nvarchar			Variable Width			4000					Unicode
--		varchar(max)		Variable Width			2^31-1					ASCII            TEXT
--		nvarchar(max)		Variable Width			2^30-1					Unicode          NTEXT
--
DECLARE	@myname nvarchar(50);
SET		@myname = 'Tony Gyles';
SELECT	@myname as 'nvarchar';


--
-- Binary Data Types
--

--		binary(n)			Fixed-length binary data. n is a value from 1 through 8,000. The storage size is n bytes.			
--		varbinary(n)		Variable-length binary data. n can be a value from 1 through 8,000.
--		varbinary(max)		Variable-length binary data from 0 through 2^31-1 (2,147,483,647) bytes. Replaces deprecated type image.

--
-- Approximate-number Data Types
--

--		NAME				Range																		Storage		
--      ====				====																		=======
--		float(n)			- 1.79E+308 to -2.23E-308, 0 and 2.23E-308 to 1.79E+308						Depends on value of n
--		real				- 3.40E + 38 to -1.18E - 38, 0 and 1.18E - 38 to 3.40E + 38					4 bytes
--
--		n-value (01-24)		Precsion =  7 digits, Storage = 4 bytes
--		n-value (25-53)		Precsion = 15 digits, Storage = 8 bytes
--
DECLARE	@myappox float(40);
SET		@myappox = 1654232.262552;
SELECT	@myappox as 'float';

--
-- Integer Data Types
--

--		NAME				Range																		Storage		
--      ====				====																		=======
--		bigint				-2^63 (-9,223,372,036,854,775,808) to 2^63-1 (9,223,372,036,854,775,807)	8 Bytes
--		int					-2^31 (-2,147,483,648) to 2^31-1 (2,147,483,647)							4 Bytes
--		smallint			-2^15 (-32,768) to 2^15-1 (32,767)											2 Bytes
--		tinyint				0 to 255																	1 Byte
DECLARE	@myfavnumber int;
SET		@myfavnumber = 7777;
SELECT	@myfavnumber as 'integer';

--
-- Numeric data types that have fixed precision and scale
--

--		decimal(p,s)		p(precision)	The maximum total number of decimal digits to be stored.
--		numeric(p,s)		s(scale)		The number of decimal digits that are stored to the right of the decimal point.
--
--		NOTES
--
--		Storage
--			Precision 1-9	, storage bytes =  5
--			Precision 10-19 , storage bytes =  9
--			Precision 20-28 , storage bytes = 13
--			Precision 29-38 , storage bytes = 17
--
--		Curency Storage
--			decimal(19,4) is used frequently in real-world applications
--
--		decimal and numeric are functionally equivalent
--
DECLARE	@mymoney decimal(19,4);
SET		@mymoney = 23400.4500;
SELECT  @mymoney as 'decimal';

--
-- Date and Time Types
--

-- date             Defines a date only e.g. 1/4/2015
--                  Date Range: 0001-01-01 through 9999-12-31
--                  Storage Size: 3 bytes
-- datetime         Replaced by datetime2 which has a larger date range and larger fractional precision, this type is deprecated.
--                  Date Range:   01-01-1753 through 31-12-9999
--                  Time Range:   00:00:00   through 23:59:59.997
--                  Accuracy:     Milliseconds
--                  Storage Size: 8 bytes
-- datetime2        Defines a date that is combined with a time of day that is based on 24-hour clock.
--                  Date Range:   01-01-0001 through 31-12-9999
--                  Time Range:   00:00:00   through 23:59:59.9999999
--                  Accuracy:     Nanoseconds
--                  Storage Size: 6-8 bytes
-- time(p)          Defines a time of a day. The time is without time zone awareness and is based on a 24-hour clock.
--                  Time Range: 00:00:00 through 23:59:59.9999999
--                  Storage Size: 5 bytes
-- datetimeoffset   Defines a date that is combined with a time of a day that has time zone awareness. Same as datetime2 but has time zone offset.
--                  Date Range:       01-01-0001 through 31-12-9999
--                  Time Range:       00:00:00   through 23:59:59.9999999
--                  Accuracy:         Nanoseconds
--                  Time zone Offset: -14:00 through +14:00
--                  Storage Size:     10 bytes
--
DECLARE @date           date              = GETDATE();
DECLARE @datetime       datetime2         = SYSDATETIME();;
DECLARE @time           time(4)           = '12:10:05.1237';
DECLARE @datetimeoffset datetimeoffset(4) = '1968-10-23 12:45:37.1234 +10:0';

SELECT @datetime AS 'datetime2', @date AS 'date', @time as 'time',@datetimeoffset as 'datetimeoffset';


--
-- Other Data Types
--

--	rowversion			This is an automatically incrementing number. Storage size 8 bytes. This is a replacement for timestamp which is deprecated.
--	uniqueidentifier	This is a 16-byte (128 bit) GUID. Create using NEWID() function
--  xml					Used to store XML documents
--	sql_variant			A data type that stores values of various SQL Server-supported data types
--	table				A special data type to store a result set for processing at a later time
--	bit					An integer type that can take a value of 1, 0 and NULL
--  money				Data types that represent monetary or currency values, use decimal type
--  smallmoney			Data types that represent monetary or currency values, use decimal type
--  hierarchyid			Used to represent position in a hierarchy. Variable length system data type.
--	geography			This type represents data in a round-earth coordinate system.
--  geometry			This type represents data in a Euclidean (flat) coordinate system.

--
-- rowversion example
--
IF OBJECT_ID('[dbo].[RowVersionTest]') IS NOT NULL BEGIN DROP TABLE [dbo].[RowVersionTest]; END;

CREATE TABLE [RowVersionTest] (myKey int PRIMARY KEY  ,myValue int, RV rowversion);  
GO
INSERT INTO [RowVersionTest] (myKey, myValue) VALUES (1, 0);
INSERT INTO [RowVersionTest] (myKey, myValue) VALUES (2, 0);
GO

SELECT * FROM [RowVersionTest]
GO

--
-- Sequence
--
-- A SQL Server sequence object generates sequence of numbers just like an identity column in sql tables.
-- But the advantage of sequence numbers is the sequence number object is not limited with single sql table.
--
IF OBJECT_ID('[dbo].[Customers]') IS NOT NULL BEGIN DROP TABLE [dbo].[Customers]; END;
IF OBJECT_ID('[dbo].[Employees]') IS NOT NULL BEGIN DROP TABLE [dbo].[Employees]; END;
DROP SEQUENCE IF EXISTS SequenceOfPerson;

-- Create sql table Customers
CREATE TABLE Customers (
  CustomerID int Identity (1,1) PRIMARY KEY,
  PersonID int,
  FirstName nvarchar(100) NOT NULL,
  LarstName nvarchar(100) NOT NULL,
);
GO
-- Create sql table Employees
CREATE TABLE Employees (
  EmployeeID int Identity(1,1) PRIMARY KEY,
  PersonID int,
  FirstName nvarchar(100) NOT NULL,
  LarstName nvarchar(100) NOT NULL
)
GO
-- Create sequence of numbers for people
CREATE SEQUENCE SequenceOfPerson
  START WITH 1
  INCREMENT BY 1;
GO

-- Insert new rows into sql tables
INSERT INTO Employees (PersonID, FirstName, LarstName) VALUES (NEXT VALUE FOR SequenceOfPerson, 'Eralper', 'YILMAZ');
INSERT Customers (PersonID, FirstName, LarstName) VALUES (NEXT VALUE FOR SequenceOfPerson, 'Bill', 'GATES') ;
INSERT Employees SELECT NEXT VALUE FOR SequenceOfPerson, 'Robert', 'Vieira' ;
INSERT Customers SELECT NEXT VALUE FOR SequenceOfPerson, 'Ken', 'England' ;

SELECT * FROM Employees ;
SELECT * FROM Customers ;
GO