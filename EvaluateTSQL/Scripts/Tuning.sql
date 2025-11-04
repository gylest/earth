--
-- Query tuning with STATISTICS IO and Execution plans
--
-- A query can be analyzed by using two tools:-
-- 1) SET STATISTICS IO ON.     This cost of the query in terms of the actual number of physical reads from  the disk and logical reads from memory
-- 2) Execution Plans.          An execution plan is a visual representation of the operations performed by the database engine in order to return the data required by your query.
--
-- The general pattern to improving a query is as follows:
-- a) Set statistics on and enable display on actual execution plan
-- b) Run query and note IO statistics and then look at exection plan to see where
-- c) Make changes to fix query (e.g. add an appropriate index)
-- d) Run query again and check the same information. Query has improved if number of logical reads is reduced.

--
-- Example 1: Query on Table with missing Index
-- 

-- STEP 1: Set Statistics on, plus "Include ACtual Query Plan"
  SET STATISTICS IO ON

-- STEP 2: Run query to be improved
SELECT Name, ProductNumber,Color,sellstartdate
FROM [EvaluateTSQL].[Production].[Product]
WHERE sellstartdate = '2012-05-30 00:00:00.000';

-- STEP 3. Examine statistics and query plan
--
-- The statistics result is:
-- Table 'Product'. Scan count 1, logical reads 13, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--
-- The query plan result is:
-- Select (0%) and Table Scan(100)

-- STEP 4. Create index to fix problem and re-examine results
--
CREATE NONCLUSTERED INDEX IDX1 on [EvaluateTSQL].[Production].[Product](sellstartdate)

-- The statistics result is:
-- Table 'Product'. Scan count 1, logical reads 13, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--
-- The query plan result is:
-- Select (0%) and Table Scan(100)
--
-- Conclusion: Index did not help as two columns missing from index

-- STEP 5. Create index to cover all columns
--
DROP INDEX [Production].[Product].[idx1];
CREATE NONCLUSTERED INDEX IDX1 ON [EvaluateTSQL].[Production].[Product](sellstartdate) INCLUDE(Name, ProductNumber,Color);

-- The statistics result is:
-- Table 'Product'. Scan count 1, logical reads 4, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--
-- The query plan result is:
-- Select (0%) and Index Seek(100)
--
-- Conclusion: Logical reads have reduced from 13 to 4. On checking Index Seek properties it is using the new index.
--             Query is now optimized.