CREATE TABLE [dbo].[Customers] (
    [CustomerID]   NCHAR (5)            NOT NULL,
    [CustomerName] NVARCHAR (50)        NULL,
    [Address]      NVARCHAR (50)        NULL,
    [City]         NVARCHAR (50)        NULL,
    [PostCode]     [dbo].[PostCodeType] NULL,
    [Country]      NVARCHAR (50)        NULL,
    [Phone]        [dbo].[PhoneType]    NULL,
    [Email]        [dbo].[EMailType]    NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO

