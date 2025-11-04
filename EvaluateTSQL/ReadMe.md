# EvaluateTSQL Database

## Overview

The `EvaluateTSQL` project contains the database schema and scripts to build the database.  
This is a `SQL Database Project` that has been built using the SDK-style from `Microsoft.Build.Sql`.  

---

## Project Structure

- **dbo**  
  Contains the functions, roles, users, stored procedures, tables, types and views  for the dbo schema
- **EvaluateOffice**  
  Contains the functions and stored procedures for the EvaluateOffice schema
- **HumanResources**  
  Contains the tables for the HumanResources schema  
- **Person**  
  Contains the tables for the Person schema  
- **Production**  
  Contains the tables for the Production schema  
- **Purchasing**  
  Contains the tables for the Purchasing schema  
- **Sales**  
  Contains the tables for the Sales schema  
- **Scripts**  
  Contains a post deployment script `Script.PostDeployment.sql` and ad-hoc programming scripts
- **Security**  
  Contains security  scripts for schemas

---

## Prerequisites

- SQL Server 2022 or later (local or remote instance)
- Command-line utility SqlPackage

---

## Build and Deployment Instructions

### Pre-requisites

Install SqlPackage for creating and deploying .dacpac: `dotnet tool install -g microsoft.sqlpackage`  
Update SqlPackage to latest version: `dotnet tool update -g microsoft.sqlpackage`  
Templates NuGet package: `dotnet new install Microsoft.Build.Sql.Templatess`  
Create a new project: `dotnet new sqlproj -n Corporation`  

### Build the Database Model

Clean build folder: `dotnet clean`  
Create .dacpac: `dotnet build`  

### Deploy the Database Model

```pwsh
sqlpackage /Action:Publish /SourceFile:"bin/Debug/EvaluateTSQL.dacpac" /TargetConnectionString:"Data Source=TONY23-PC\DEVSQL;Initial Catalog=EvaluateTSQL;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Command Timeout=30;"
```

## Ad-hoc Scripts

These scripts are not deployed but are intended for learning.  

|Script|Description|
|---|---|
|Advanced Queries.sql|MERGE statement, WITH TIES and CTE|
|Data Definition.sql|Creating tables and views|
|Data Manipulation.sql|INSERT, DELETE, UPDATE and TRUNCATE|
|Data Types.sql|String, Binary, Number, Integer, Currency and Date types|
|Database_Design.sql|Indexes|  
|Programming Functions.sql|Using built-in functions and user-defined functions|  
|Programming JSON.sql|JSON Document Storage|  
|Programming Logic.sql|IF-ELSE, WHILE, TRY-CATCH etc|  
|Programming XML.sql|XML manipulation|  
|Select Basic.sql|SELECT statement|  
|Select Grouping and Summarizing.sql|Aggregate functions, GROUP BY and HAVING,ROLLUP, CUBE and DISTINCT|  
|Select Multiple Tables.sql|LEFT and RIGHT joins|  
|Tests.sql|Data tests|  
|Tuning.sql|SQL Query tuning|

## Documentation

Product documentation: <https://github.com/microsoft/DacFx>  
