CREATE TABLE [dbo].[Address] (
    [AddressID]    INT                IDENTITY (1, 1) NOT NULL,
    [CustomerID]   INT                NOT NULL,
    [AddressLine1] NVARCHAR (50)      NOT NULL,
    [AddressLine2] NVARCHAR (50)      NULL,
    [City]         NVARCHAR (50)      NULL,
    [PostCode]     NVARCHAR (50)      NULL,
    [Country]      NVARCHAR (50)      NULL,
    [Status]       [dbo].[strcatalog] NOT NULL,
    [CreateDate]   DATETIME           CONSTRAINT [DF_Address_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]   DATETIME           CONSTRAINT [DF_Addresss_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([AddressID] ASC),
    CONSTRAINT [FK_Address_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID])
);

