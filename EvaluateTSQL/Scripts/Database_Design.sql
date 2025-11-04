--
-- Collation
--

-- 1. Collation Definition
--    In SQL Server collation provide sorting rules, case, and accent sensitivity properties for your data.
--    Collations that are used with character data types, such as char and varchar, dictate the code page and corresponding characters that can be represented for that data type.
--
-- 2. The default collation for UK is Latin1_General_CI_AS 
--    This means the latin1 set of characters, case insensitive ( 'c' = 'C') , accent sensitive ('a' != 'á')
--
-- 3. Scope
--    Server Collation acts as default collation for all system databases in an instance and also any new user databases created.
--    Database Collation is the collation for an individual database, this can be changed in the "CREATE DATABASE" statement using the COLLATE option.
--    Column Collation is the collation for an indiviual column in a table, this can be chnaged in the "CREATE TABLE" statement using the COLLATE option for a column.
--
-- 4. Temporary Tables and Table Variables
--    When a temporary table    is created it is created in TempDB using collation of TempDB
--    When a table     variable is created it is created in TempDB using collation of TempDB

--
-- Indexes
--
IF OBJECT_ID('dbo.Movie') IS NOT NULL BEGIN DROP TABLE dbo.Movie; END;

CREATE TABLE [dbo].[Movie] (
    [Id]                int              NOT NULL,
    [Type]              nvarchar (2)     NOT NULL,
    [Name]              nvarchar(100)    NOT NULL,
    [IMDBNumber]        integer          NOT NULL,
    [ReleaseYear]       integer          NOT NULL,
    [ReleaseMonth]      tinyint          NOT NULL,
    [ReleaseDay]        tinyint          NOT NULL,
    [ModifiedDate]      datetime         CONSTRAINT [DF_Movie_ModifiedDate] DEFAULT (GETDATE()) NOT NULL,
);

-- 1. Indexes are special data structures associated with tables or views that help speed up the query. 
--
-- 2. Types of Index: 
--
--    Clustered     -  Clustered indexes sort and store the data rows in the table or view based on their key values. These are the columns included in the index definition.
--                     There can be only one clustered index per table, because the data rows themselves can be stored in only one order.
--                     The only time the data rows in a table are stored in sorted order is when the table contains a clustered index. When a table has a clustered index, the table is called a clustered table.
--                     If a table has no clustered index, its data rows are stored in an unordered structure called a heap.
--
CREATE CLUSTERED INDEX IX_Movie_Id ON dbo.Movie (Id);
--
--   Nonclustered   -  Nonclustered indexes have a structure separate from the data rows.
--                     A nonclustered index contains the nonclustered index key values and each key value entry has a pointer to the data row that contains the key value.
--                     The pointer from an index row in a nonclustered index to a data row is called a row locator. The structure of the row locator depends on whether the data pages are stored in a heap or a clustered table. For a heap, a row locator is a pointer to the row.
--                     For a clustered table, the row locator is the clustered index key.
--
CREATE NONCLUSTERED INDEX IX_Movie_Name ON dbo.Movie (Name); 
--
--   Unique         -  A unique index ensures that the index key contains no duplicate values and therefore every row in the table or view is in some way unique.
--
CREATE UNIQUE INDEX UN_Movie_IMDBNumber ON dbo.Movie (IMDBNumber); 
--
--   Columnstore    -  An in-memory columnstore index stores and manages data by using column-based data storage and column-based query processing.
--                     Columnstore indexes work well for data warehousing workloads that primarily perform bulk loads and read-only queries. 
--
--   Index with     -  A nonclustered index that is extended to include nonkey columns in addition to the key columns.
--   included columns
CREATE NONCLUSTERED INDEX IX_Movie_ReleaseYear  ON dbo.Movie (ReleaseYear)  INCLUDE (ReleaseMonth,ReleaseDay); 
--
--   XML            - A shredded, and persisted, representation of the XML binary large objects (BLOBs) in the xml data type column.
--
--   Full-Text      - A special type of token-based functional index that is built and maintained by the Microsoft Full-Text Engine for SQL Server.
--                    It provides efficient support for sophisticated word searches in character string data.