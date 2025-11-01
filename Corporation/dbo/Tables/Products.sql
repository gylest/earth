CREATE TABLE [dbo].[Products] (
    [ProductID]    INT           NOT NULL,
    [ProductName]  NVARCHAR (30) NOT NULL,
    [SupplierID]   INT           NOT NULL,
    [CategoryID]   INT           NOT NULL,
    [UnitPrice]    MONEY         NOT NULL,
    [UnitsInStock] INT           NOT NULL,
    [CreateDT]     DATETIME      CONSTRAINT [DF_Products_CreateDT] DEFAULT (sysdatetime()) NOT NULL,
    [Discontinued] BIT           NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Products_CategoryID] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Categories] ([CategoryID]),
    CONSTRAINT [FK_Products_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])
);
GO

