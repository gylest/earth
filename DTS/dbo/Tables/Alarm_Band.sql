CREATE TABLE [dbo].[Alarm_Band] 
(
	[ID]                             int IDENTITY (1, 1) NOT NULL,
	[Name]                           NameUDT             NOT NULL,
	[NameLocal]                      LocalUDT                NULL,
	[Version]                        int                 NOT NULL,
	[LowLimit]                       float               NOT NULL,
	[HighLimit]                      float               NOT NULL,
	[Criticality]                    int                     NULL,
	[TriggerDelayWhenProfileRising]  int                     NULL,
	[TriggerDelayWhenProfileFalling] int                     NULL,
	[AlarmID]                        int                 NOT NULL,
    [CreateDT]                       DATETIME         CONSTRAINT [DF_Alarm_Band_CreateDT] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDT]                       DATETIME         NULL,
    CONSTRAINT [PK_Alarm_Band] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Alarm_Band_Criticality] CHECK ([Criticality]>=(0) AND [Criticality]<=(65535)),
    CONSTRAINT [CK_Alarm_Band_TriggerDelayWhenProfileFalling] CHECK ([TriggerDelayWhenProfileFalling]>=(0) AND [TriggerDelayWhenProfileFalling]<=(65535)),
    CONSTRAINT [CK_Alarm_Band_TriggerDelayWhenProfileRising] CHECK ([TriggerDelayWhenProfileRising]>=(0) AND [TriggerDelayWhenProfileRising]<=(65535)),
    CONSTRAINT [FK_Alarm_Band_Alarm] FOREIGN KEY ([AlarmID]) REFERENCES [dbo].[Alarm] ([ID]),
    CONSTRAINT [Unique_Alarm_Band_NameAndAlarmID] UNIQUE NONCLUSTERED ([Name] ASC, [AlarmID] ASC)
) ON [PRIMARY]
GO
