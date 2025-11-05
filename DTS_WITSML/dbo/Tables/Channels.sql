CREATE TABLE [dbo].[Channels] (
    [ID]          INT                IDENTITY (1, 1) NOT NULL,
    [FiberID]     INT                NOT NULL,
    [mnemonic]    [dbo].[str256]     NOT NULL,
    [columnIndex] INT                NOT NULL,
    [classPOSC]   [dbo].[strcatalog] NULL,
    [unit]        [dbo].[strcatalog] NULL,
    [description] [dbo].[str256]     NULL,
    [CreateDate]  DATETIME           CONSTRAINT [DF_Channels_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]  DATETIME           CONSTRAINT [DF_Channels_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Channels] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Channels_ChannelTypes] FOREIGN KEY ([mnemonic]) REFERENCES [dbo].[ChannelTypes] ([mnemonic]),
    CONSTRAINT [FK_Channels_Fibers] FOREIGN KEY ([FiberID]) REFERENCES [dbo].[Fibers] ([ID])
);
GO

