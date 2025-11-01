CREATE PROCEDURE [dbo].[sp_HighEarners]
AS
    SELECT FirstName, LastName, Address, Salary
    FROM Employees
    WHERE (((Salary)>20000))
    ORDER BY LastName
GO

