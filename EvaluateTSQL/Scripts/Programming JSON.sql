--
-- JSON Document Storage
--

-- The first storage design decision is how to store JSON documents in the tables. There are two available options:
--
-- 1) Large Object Storage. JSON documents can be stored as-is in NVARCHAR columns.
--    This is the best way for quick data load and ingestion because the loading speed is matching loading of string columns.
-- 2) Relational Storage.
--    JSON documents can be parsed while they are inserted in the table using OPENJSON, JSON_VALUE or JSON_QUERY functions.

--
-- Storing JSON document as large object
--
IF OBJECT_ID('[dbo].[DocumentStore]') IS NOT NULL BEGIN DROP TABLE [dbo].[DocumentStore]; END;
CREATE TABLE DocumentStore (
    id       bigint PRIMARY KEY IDENTITY,
    document nvarchar(max)
);

-- Constraint to only allow JSON documents
ALTER TABLE DocumentStore ADD CONSTRAINT [Document should be formatted as JSON] CHECK (ISJSON(document)=1);

-- Insert json document
DECLARE @json NVARCHAR(MAX);

SET @json='{"reference":"123","movie":"Ad Astra","star":"Brad Pitt","realeaseYear":2019}';

INSERT INTO dbo.DocumentStore(document) VALUES (@json);

SELECT * FROM dbo.DocumentStore;

GO

--
-- Storing JSON document as relational
--
IF OBJECT_ID('[dbo].[RelationalStore]') IS NOT NULL BEGIN DROP TABLE [dbo].[RelationalStore]; END;
CREATE TABLE RelationalStore (
    Number   varchar(200),
    Date     datetime2,
    Customer varchar(200),
    Quantity int
);

DECLARE @json NVARCHAR(MAX)
SET @json =   
  N'[  
       {  
         "Order": {  
           "Number":"SO43659",  
           "Date":"2011-05-31T00:00:00"  
         },  
         "AccountNumber":"AW29825",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":1  
         }  
       },  
       {  
         "Order": {  
           "Number":"SO43661",  
           "Date":"2011-06-01T00:00:00"  
         },  
         "AccountNumber":"AW73565",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":3  
         }  
      }  
 ]'  
 
INSERT INTO [dbo].[RelationalStore]
SELECT * FROM OPENJSON ( @json )  
WITH (    Number   varchar(200) '$.Order.Number' ,  
          Date     datetime2    '$.Order.Date',  
          Customer varchar(200) '$.AccountNumber',  
          Quantity int          '$.Item.Quantity'  
 )

 SELECT * FROM [dbo].[RelationalStore];

 GO

 
--
-- Open JSON data with default output
--
DECLARE @json NVARCHAR(MAX)

SET @json='{"name":"John","surname":"Doe","age":45,"skills":["SQL","C#","MVC"]}';

SELECT * FROM OPENJSON(@json);
GO