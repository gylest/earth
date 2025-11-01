CREATE TABLE [dbo].[Departments] (
    [DepartmentID]       NCHAR (5)     NOT NULL,
    [DepartmentLocation] NVARCHAR (40) NULL,
    [DepartmentName]     NVARCHAR (40) NOT NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
GO

