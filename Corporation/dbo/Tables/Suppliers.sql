CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]   INT                  NOT NULL,
    [SupplierName] NVARCHAR (100)       NOT NULL,
    [Address]      NVARCHAR (100)       NOT NULL,
    [City]         NVARCHAR (100)       NOT NULL,
    [PostCode]     [dbo].[PostCodeType] NULL,
    [Country]      NVARCHAR (100)       NULL,
    [Phone]        [dbo].[PhoneType]    NULL,
    [Fax]          NVARCHAR (100)       NULL,
    [PaymentTerms] NVARCHAR (100)       NOT NULL,
    [EMail]        [dbo].[EMailType]    NULL,
    [WebAddress]   NVARCHAR (100)       NULL,
    [Notes]        NTEXT                NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);
GO

