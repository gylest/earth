CREATE TABLE [dbo].[MarketingCorporation] (
    [CorporateNumber] VARCHAR (50)  NOT NULL,
    [CorporationName] VARCHAR (50)  NULL,
    [FilingStatus]    VARCHAR (50)  NULL,
    [FilingType]      VARCHAR (50)  NULL,
    [AddressLine1]    VARCHAR (150) NULL,
    [AddressLine2]    VARCHAR (150) NULL,
    [City]            VARCHAR (50)  NULL,
    [State]           VARCHAR (50)  NULL,
    [ZipCode]         VARCHAR (50)  NULL,
    [Country]         CHAR (50)     NULL,
    [FillingDate]     VARCHAR (50)  NULL,
    CONSTRAINT [PK_MarketingCorporation] PRIMARY KEY CLUSTERED ([CorporateNumber] ASC)
);
GO

