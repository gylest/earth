CREATE TABLE [dbo].[Application_Log] 
(
	[ID]         int IDENTITY (1, 1) NOT NULL,
	[LogMessage] varchar(500)        NOT NULL,
	[LogGroup]   int                 NOT NULL,
	[CreateDT]   DATETIME      CONSTRAINT [DF_Application_Log_CreateDT] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Application_Log] PRIMARY KEY CLUSTERED ([ID] ASC)
) ON [PRIMARY]
GO