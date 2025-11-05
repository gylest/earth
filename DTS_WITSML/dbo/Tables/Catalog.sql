CREATE TABLE [dbo].[Catalog] (
    [Group]      INT                NOT NULL,
    [CodedValue] [dbo].[strcatalog] NOT NULL,
    [Value]      [dbo].[strcatalog] NOT NULL,
    [Default]    [dbo].[boolean]    NOT NULL,
    CONSTRAINT [PK_Catalog] PRIMARY KEY CLUSTERED ([Group] ASC, [CodedValue] ASC),
    CONSTRAINT [CK_Catalog_Active] CHECK ([Default]>=(0) AND [Default]<=(1))
);
GO

