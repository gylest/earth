CREATE TABLE [dbo].[SalesTaxRate] (
    [SalesTaxRateID] INT        IDENTITY (1, 1) NOT NULL,
    [CountryCode]    CHAR (2)   NOT NULL,
    [TaxRate]        SMALLMONEY NOT NULL,
    [StartDate]      DATE       NOT NULL,
    [EndDate]        DATE       NULL,
    CONSTRAINT [PK_SalesTaxRate] PRIMARY KEY CLUSTERED ([SalesTaxRateID] ASC),
    CONSTRAINT [FK_SalesTaxRate_CountryCode] FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode])
);

