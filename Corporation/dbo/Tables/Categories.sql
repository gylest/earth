CREATE TABLE [dbo].[Categories] (
    [CategoryID]   INT           NOT NULL,
    [CategoryName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO

