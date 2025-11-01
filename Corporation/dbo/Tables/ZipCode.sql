CREATE TABLE [dbo].[ZipCode] (
    [StateFIPCode]         SMALLINT     NULL,
    [ZipCode]              CHAR (5)     NOT NULL,
    [StateAbbr]            CHAR (2)     NULL,
    [City]                 VARCHAR (16) NULL,
    [Longitude]            REAL         NULL,
    [Latitude]             REAL         NULL,
    [Population]           INT          NULL,
    [AllocationPercentage] REAL         NULL,
    CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED ([ZipCode] ASC)
);
GO

