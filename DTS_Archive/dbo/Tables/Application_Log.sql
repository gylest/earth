CREATE TABLE [dbo].[Application_Log] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [LogMessage] VARCHAR (500) NOT NULL,
    [LogGroup]   INT           NOT NULL,
    [CreateDT]   DATETIME      CONSTRAINT [DF_Application_Log_CreateDT] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Application_Log] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

