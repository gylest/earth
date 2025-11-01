CREATE TABLE [dbo].[Orders] (
    [OrderID]    INT       NOT NULL,
    [CustomerID] NCHAR (5) NOT NULL,
    [EmployeeID] NCHAR (5) NOT NULL,
    [OrderDT]    DATETIME  NOT NULL,
    [RequiredDT] DATETIME  NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Orders_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID])
);
GO

