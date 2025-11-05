CREATE TABLE [dbo].[Zone_Process] 
(
	[ID]                               int IDENTITY (1, 1) NOT NULL,
	[ProcessName]                      NameUDT             NOT NULL,
	[ProcessNameLocal]                 LocalUDT                NULL,
	[Version]                          int                 NOT NULL,
	[ConfigID]                         int                 NOT NULL,
	[ProcessingMethod]                 int                 NOT NULL,
	[PositionReference]                int                 NOT NULL,
	[OutputEnabled]                    bit                 NOT NULL,
	[MeasurementLossFirstInterval]     int                     NULL,
	[MeasurementLossSecondInterval]    int                     NULL,
	[NumberOfRateOfChangeMeasurements] int                     NULL,
    [CreateDT]                         DATETIME         CONSTRAINT [DF_Zone_Process_CreateDT] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDT]                         DATETIME         NULL,
    CONSTRAINT [PK_Zone_Process] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Zone_Process_OutputEnabled] CHECK ([OutputEnabled]>=(0) AND [OutputEnabled]<=(1)),
    CONSTRAINT [CK_Zone_Process_PositionReference] CHECK ([PositionReference]>=(0) AND [PositionReference]<=(2)),
    CONSTRAINT [CK_Zone_Process_ProcessingMethod] CHECK ([ProcessingMethod]>=(0) AND [ProcessingMethod]<=(9)),
    CONSTRAINT [FK_Zone_Process_Config] FOREIGN KEY ([ConfigID]) REFERENCES [dbo].[Config] ([ID]),
    CONSTRAINT [Unique_Zone_Process_NameAndConfigID] UNIQUE NONCLUSTERED ([ProcessName] ASC, [ConfigID] ASC)
);
GO

