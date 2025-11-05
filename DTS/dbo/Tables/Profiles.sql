CREATE TABLE [dbo].[Profiles] 
(
	[ID]                     int IDENTITY (1, 1) NOT NULL,
	[MeasurementID]          int                 NOT NULL,
	[ConfigID]               int                 NOT NULL,
	[MeasurementMode]        int                 NOT NULL,
	[MeasuredSignal]         int                     NULL,
	[MeasurementProcess]     int                     NULL,
	[SectionNumber]          int                 NOT NULL,
	[FibreNumber]            int                 NOT NULL,
	[FibreEnd]               int                 NOT NULL,
	[DistanceFirstDataPoint] int                 NOT NULL,
	[NumberDataPoints]       int                 NOT NULL,
	[NumberOfMissingPoints]  int                 NOT NULL,
	[LengthProfile]          int                 NOT NULL,
	[CRCValue]               int                 NOT NULL,
	[CompressionInd]         int                 NOT NULL,
	[DataPoints]             image               NOT NULL,
    [Retain]                 INT   CONSTRAINT [DF_Profiles_Retain] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Profiles] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Profiles_MeasurementProcess] CHECK ([MeasurementProcess]>=(0) AND [MeasurementProcess]<=(4)),
    CONSTRAINT [FK_Profiles_Config] FOREIGN KEY ([ConfigID]) REFERENCES [dbo].[Config] ([ID]),
    CONSTRAINT [FK_Profiles_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

CREATE NONCLUSTERED INDEX [IND_Profiles_MeasurementID]
    ON [dbo].[Profiles]([MeasurementID] ASC);
GO

CREATE NONCLUSTERED INDEX [IND_Profiles_MeasurementMode]
    ON [dbo].[Profiles]([MeasurementMode] ASC);
GO

CREATE NONCLUSTERED INDEX [IND_Profiles_Retain]
    ON [dbo].[Profiles]([Retain] ASC);
GO

CREATE TRIGGER Profiles_Delete
    ON Profiles
    FOR DELETE
AS
   SET NOCOUNT ON
   DELETE FROM Measurement WHERE ID IN
   (Select MeasurementID FROM Deleted)
GO


