CREATE TABLE [dbo].[WebServices] (
    [ID]              INT                IDENTITY (1, 1) NOT NULL,
    [Description]     [dbo].[str256]     NOT NULL,
    [url]             NVARCHAR (500)     NOT NULL,
    [totalPosts]      INT                CONSTRAINT [DF_WebServices_totalPosts] DEFAULT ((0)) NOT NULL,
    [saveXML]         [dbo].[boolean]    NOT NULL,
    [security]        [dbo].[strcatalog] NOT NULL,
    [Username]        [dbo].[str256]     NOT NULL,
    [Password]        [dbo].[str256]     NOT NULL,
    [Active]          [dbo].[boolean]    CONSTRAINT [DF_WebServices_Active] DEFAULT ((0)) NOT NULL,
    [lastProfileID]   INT                CONSTRAINT [DF_WebServices_lastProfileID] DEFAULT ((0)) NOT NULL,
    [lastProfileDate] DATETIME           NULL,
    [lastPostDate]    DATETIME           NULL,
    [CreateDate]      DATETIME           CONSTRAINT [DF_WebServices_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]      DATETIME           CONSTRAINT [DF_WebServices_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_WebServices] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_WebServices_Active] CHECK ([Active]>=(0) AND [Active]<=(1)),
    CONSTRAINT [CK_WebServices_Desc] CHECK (len([Description])>(0)),
    CONSTRAINT [CK_WebServices_saveXML] CHECK ([saveXML]>=(0) AND [saveXML]<=(1)),
    CONSTRAINT [CK_WebServices_security] CHECK (len([security])>(0)),
    CONSTRAINT [CK_WebServices_url] CHECK (len([url])>(0)),
    CONSTRAINT [CK_WebServices_Username] CHECK (len([Username])>(0))
);
GO

