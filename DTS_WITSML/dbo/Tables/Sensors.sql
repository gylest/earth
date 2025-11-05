CREATE TABLE [dbo].[Sensors] (
    [ID]               INT             IDENTITY (1, 1) NOT NULL,
    [Description]      [dbo].[str256]  NOT NULL,
    [uidDTS]           [dbo].[str64]   NOT NULL,
    [Active]           [dbo].[boolean] CONSTRAINT [DF_Sensors_Active] DEFAULT ((0)) NOT NULL,
    [uidSource]        [dbo].[str64]   NOT NULL,
    [nameField]        [dbo].[str64]   NOT NULL,
    [numSlot]          [dbo].[str32]   NOT NULL,
    [nameInstallation] [dbo].[str64]   NOT NULL,
    [country]          [dbo].[str64]   NOT NULL,
    [operator]         [dbo].[str64]   NOT NULL,
    [CreateDate]       DATETIME        CONSTRAINT [DF_Sensors_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]       DATETIME        CONSTRAINT [DF_Sensors_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Sensors] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Sensors_Active] CHECK ([Active]>=(0) AND [Active]<=(1)),
    CONSTRAINT [CK_Sensors_Desc] CHECK (len([Description])>(0)),
    CONSTRAINT [CK_Sensors_uidDTS] CHECK (len([uidDTS])>(0))
);
GO

