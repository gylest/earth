CREATE TABLE [dbo].[Order] (
    [OrderID]          INT                IDENTITY (1, 1) NOT NULL,
    [CustomerID]       INT                NOT NULL,
    [OrderNumber]      NCHAR (15)         NOT NULL,
    [PaymentID]        INT                NULL,
    [OrderDate]        DATETIME           NOT NULL,
    [OrderStatus]      [dbo].[strcatalog] NOT NULL,
    [OrderDescription] NVARCHAR (50)      NULL,
    [SubTotal]         MONEY              NOT NULL,
    [SalesTax]         MONEY              NOT NULL,
    [Freight]          MONEY              NOT NULL,
    [TotalDue]         AS                 (isnull(([SubTotal]+[SalesTax])+[Freight],(0.0))),
    [ShipToAddressID]  INT                NULL,
    [PaymentDate]      DATETIME           NULL,
    [CreateDate]       DATETIME           CONSTRAINT [DF_Order_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]       DATETIME           CONSTRAINT [DF_Order_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Order_Address] FOREIGN KEY ([ShipToAddressID]) REFERENCES [dbo].[Address] ([AddressID]),
    CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID]),
    CONSTRAINT [FK_Order_Payment] FOREIGN KEY ([PaymentID]) REFERENCES [dbo].[Payment] ([PaymentID])
);

