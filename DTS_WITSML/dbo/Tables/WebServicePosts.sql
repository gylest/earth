CREATE TABLE [dbo].[WebServicePosts] (
    [ID]           INT      IDENTITY (1, 1) NOT NULL,
    [WebServiceID] INT      NOT NULL,
    [totalBytes]   INT      NOT NULL,
    [xmlDocument]  NTEXT    NOT NULL,
    [CreateDate]   DATETIME CONSTRAINT [DF_WebServicePosts_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_WebServicePosts] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WebServicePosts_WebServices] FOREIGN KEY ([WebServiceID]) REFERENCES [dbo].[WebServices] ([ID])
);
GO

