CREATE TABLE [dbo].[OrderDetail] (
    [OrderDetailID]     INT      IDENTITY (1, 1) NOT NULL,
    [OrderID]           INT      NOT NULL,
    [ProductID]         INT      NOT NULL,
    [UnitPrice]         MONEY    NOT NULL,
    [Quantity]          INT      NOT NULL,
    [UnitPriceDiscount] MONEY    NOT NULL,
    [LineTotal]         AS       (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[Quantity],(0.0))),
    [CreateDate]        DATETIME CONSTRAINT [DF_OrderDetail_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]        DATETIME CONSTRAINT [DF_OrderDetail_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED ([OrderDetailID] ASC),
    CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderID]),
    CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);

