CREATE TABLE [dbo].[Wells] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [DTSID]      INT           NOT NULL,
    [uidWell]    [dbo].[str64] NOT NULL,
    [nameWell]   [dbo].[str64] NOT NULL,
    [CreateDate] DATETIME      CONSTRAINT [DF_Wells_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate] DATETIME      CONSTRAINT [DF_Wells_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Wells] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Wells_nameWell] CHECK (len([nameWell])>(0)),
    CONSTRAINT [CK_Wells_uidWell] CHECK (len([uidWell])>(0)),
    CONSTRAINT [FK_Wells_Sensors] FOREIGN KEY ([DTSID]) REFERENCES [dbo].[Sensors] ([ID])
);
GO

