CREATE TABLE [dbo].[Aging_Rules] 
(
	[ID]                     int IDENTITY (1, 1) NOT NULL,
	[RuleType]               int                 NOT NULL,
	[Period]                 int                 NOT NULL,
	[PeriodDescription]      varchar(200)        NOT NULL, 
	[TimeSpanMin]            int                     NULL,
	[RetainPercentage]       int                     NULL,
	[AlarmBeforeTimeSpanMin] int                     NULL,
	[AlarmAfterTimeSpanMin]  int                     NULL,
	[CreateDT]               datetime            NOT NULL CONSTRAINT [DF_Aging_Rules_CreateDT]   DEFAULT (SYSDATETIME()) ,
	[ModifyDT]               datetime                NULL,       
	[LastRunDT]              datetime                NULL,
	CONSTRAINT [PK_Aging_Rules]                       PRIMARY KEY  CLUSTERED ([ID])  ON [PRIMARY],
	CONSTRAINT [Unique_Aging_Rules_PeriodAndRuleType] UNIQUE  NONCLUSTERED ( [RuleType], [Period] )  ON [PRIMARY],
	CONSTRAINT [CK_Aging_Rules_RetainPercentage]      CHECK ([RetainPercentage] >= 0 and [RetainPercentage] <= 100)
) ON [PRIMARY]
GO

