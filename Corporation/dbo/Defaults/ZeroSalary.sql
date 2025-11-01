CREATE DEFAULT [dbo].[ZeroSalary]
    AS 0;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ZeroSalary]', @objname = N'[dbo].[Employees].[Salary]';
GO

