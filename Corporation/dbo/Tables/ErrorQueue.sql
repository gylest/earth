CREATE TABLE [dbo].[ErrorQueue] (
    [CorporateNumber] VARCHAR (50)  NOT NULL,
    [CorporationName] VARCHAR (50)  NULL,
    [CorporateStatus] VARCHAR (50)  NULL,
    [FilingType]      VARCHAR (50)  NULL,
    [AddressLine1]    VARCHAR (150) NULL,
    [AddressLine2]    VARCHAR (150) NULL,
    [City]            VARCHAR (50)  NULL,
    [StateAbbr]       VARCHAR (50)  NULL,
    [ZipCode]         VARCHAR (50)  NULL,
    [Country]         VARCHAR (50)  NULL,
    [FillingDate]     VARCHAR (50)  NULL,
    [TaskName]        NVARCHAR (64) NULL,
    [PackageName]     NVARCHAR (64) NULL,
    [DateAdded]       DATETIME      NULL,
    CONSTRAINT [PK_ErrorQueue] PRIMARY KEY CLUSTERED ([CorporateNumber] ASC)
);
GO

