CREATE TABLE [dbo].[OrderDetails] (
    [OrderID]   INT   NOT NULL,
    [ProductID] INT   NOT NULL,
    [Unitprice] MONEY NOT NULL,
    [Quantity]  INT   NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_OrderDetails_OrderID] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_OrderDetails_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);
GO

