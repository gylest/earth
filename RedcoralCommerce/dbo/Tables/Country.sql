CREATE TABLE [dbo].[Country] (
    [CountryID]   INT            IDENTITY (1, 1) NOT NULL,
    [CountryCode] CHAR (2)       NOT NULL,
    [Name]        NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryID] ASC),
    CONSTRAINT [UN_CountryCode] UNIQUE NONCLUSTERED ([CountryCode] ASC)
);

