CREATE TABLE [dbo].[Measurement] (
    [ID]           INT      NOT NULL,
    [DTSID]        INT      NULL,
    [TimeStampUTC] DATETIME NOT NULL,
    [TimeStampLoc] DATETIME NOT NULL,
    CONSTRAINT [PK_Measurement] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

