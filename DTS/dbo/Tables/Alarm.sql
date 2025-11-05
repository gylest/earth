CREATE TABLE [dbo].[Alarm] 
(
	[ID]                       int IDENTITY (1, 1) NOT NULL,
	[Name]                     NameUDT             NOT NULL,
	[NameLocal]                LocalUDT                NULL,
	[Version]                  int                 NOT NULL,
	[ConfigID]                 int                 NOT NULL,
	[TriggerCondition]         int                 NOT NULL,
	[OnlySendFirstAlarmInBand] bit                 NOT NULL,
	[OutOfRangeNameHigh]       NameUDT                 NULL CONSTRAINT [DF_Alarm_OutOfRangeNameHigh]  DEFAULT ('OUTOFRANGEHIGH'),
	[OutOfRangeNameLow]        NameUDT                 NULL CONSTRAINT [DF_Alarm_OutOfRangeNameLow]   DEFAULT ('OUTOFRANGELOW'),
	[CreateDT]                 datetime            NOT NULL CONSTRAINT [DF_Alarm_CreateDT]            DEFAULT (SYSDATETIME()),
	[ModifyDT]                 datetime                NULL,
    CONSTRAINT [PK_Alarm]                          PRIMARY KEY  CLUSTERED ([ID])  ON [PRIMARY],
    CONSTRAINT [Unique_Alarm_NameAndConfigID]      UNIQUE  NONCLUSTERED ( [Name], [ConfigID] )  ON [PRIMARY],
    CONSTRAINT [CK_Alarm_OnlySendFirstAlarmInBand] CHECK ([OnlySendFirstAlarmInBand]>=(0) AND [OnlySendFirstAlarmInBand]<=(1)),
    CONSTRAINT [CK_Alarm_TriggerCondition]         CHECK ([TriggerCondition]>=(0) AND [TriggerCondition]<=(2)),
    CONSTRAINT [FK_Alarm_Config]                   FOREIGN KEY ([ConfigID]) REFERENCES [dbo].[Config] ([ID])
) ON [PRIMARY];
