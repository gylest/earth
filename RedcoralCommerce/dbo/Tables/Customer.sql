CREATE TABLE [dbo].[Customer] (
    [CustomerID]    INT                IDENTITY (1, 1) NOT NULL,
    [FirstName]     NVARCHAR (50)      NOT NULL,
    [LastName]      NVARCHAR (50)      NOT NULL,
    [DateOfBirth]   DATE               NULL,
    [Phone]         NVARCHAR (50)      NULL,
    [Email]         NVARCHAR (100)     NULL,
    [EmailPassword] NVARCHAR (50)      NULL,
    [Status]        [dbo].[strcatalog] NOT NULL,
    [CreateDate]    DATETIME           CONSTRAINT [DF_Customer_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]    DATETIME           CONSTRAINT [DF_Customer_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IND_Customer_Email]
    ON [dbo].[Customer]([Email] ASC);

