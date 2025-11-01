CREATE TABLE [dbo].[Employees] (
    [EmployeeID]   NCHAR (5)            NOT NULL,
    [FirstName]    NVARCHAR (50)        NULL,
    [LastName]     NVARCHAR (50)        NOT NULL,
    [Address]      NVARCHAR (255)       CONSTRAINT [DF_Employees_Address] DEFAULT ('UNKNOWN') NULL,
    [City]         NVARCHAR (50)        NULL,
    [PostCode]     [dbo].[PostCodeType] NULL,
    [Phone]        [dbo].[PhoneType]    NULL,
    [Salary]       MONEY                NULL,
    [DepartmentID] NCHAR (5)            NULL,
    [DateJoined]   DATE                 NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Employees_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID])
);
GO

CREATE NONCLUSTERED INDEX [lastnameind]
    ON [dbo].[Employees]([LastName] ASC);
GO

CREATE NONCLUSTERED INDEX [departmentidind]
    ON [dbo].[Employees]([DepartmentID] ASC);
GO
