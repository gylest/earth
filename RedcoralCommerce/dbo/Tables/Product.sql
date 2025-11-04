CREATE TABLE [dbo].[Product] (
    [ProductID]          INT             IDENTITY (1, 1) NOT NULL,
    [SKU]                NVARCHAR (50)   NOT NULL,
    [ProductName]        NVARCHAR (50)   NOT NULL,
    [ProductDescription] NVARCHAR (50)   NOT NULL,
    [UnitPrice]          MONEY           NOT NULL,
    [Note]               NVARCHAR (50)   NULL,
    [ForSale]            [dbo].[boolean] NOT NULL,
    [CreateDate]         DATETIME        CONSTRAINT [DF_Product_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]         DATETIME        CONSTRAINT [DF_Product_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [UN_ProductSKU] UNIQUE NONCLUSTERED ([SKU] ASC)
);

