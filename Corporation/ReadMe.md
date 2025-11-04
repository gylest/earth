# CorporationDatabase

## Overview

The `CorporationDatabase` project contains the database schema and scripts to build the database.  
This is a `SQL Database Project` that has been built using the SDK-style from `Microsoft.Build.Sql`.  

## Project Structure

- **dbo**  
  Contains the defaults, stored procedures, tables, user defined types and views
- **Scripts**  
  Contains a post deployment script `Script.PostDeployment.sql` and ad-hoc database maintenance scripts
- **Security**  
  Contains security  scripts for logins, users and roles

## Prerequisites

- SQL Server 2022 or later  
- Command-line utility `SqlPackage`  

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
sqlpackage /Action:Publish /SourceFile:"bin/Debug/Corporation.dacpac" /TargetConnectionString:"Data Source=TONY23-PC\DEVSQL;Initial Catalog=Corporation;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Command Timeout=30;"
```

## Ad-hoc Scripts

These scripts are not deployed but are intended for database administration.  

|Script|Description|
|---|---|
|Backup.sql|Perform a backup of Corporation database|
|Jobs.sql|Create a SQL Server Job to perform backup of Corporation database|

## Documentation

Product documentation: <https://github.com/microsoft/DacFx>  
