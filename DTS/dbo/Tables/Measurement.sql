CREATE TABLE [dbo].[Measurement] 
(
	[ID]           int IDENTITY (1, 1) NOT NULL,
	[DTSID]        int                     NULL,
	[TimeStampUTC] datetime            NOT NULL,
	[TimeStampLoc] datetime            NOT NULL,
	CONSTRAINT [PK_Measurement] PRIMARY KEY CLUSTERED ([ID] ASC)
) ON [PRIMARY]
GO

GO

CREATE NONCLUSTERED INDEX [IND_Measurement_TimeStampUTC]
    ON [dbo].[Measurement]([TimeStampUTC] ASC);
GO