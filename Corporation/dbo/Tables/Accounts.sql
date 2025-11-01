CREATE TABLE [dbo].[Accounts] (
    [AccountNo] INT   NOT NULL,
    [Balance]   MONEY NOT NULL,
    CONSTRAINT [PK_Accounts_AccountNo] PRIMARY KEY CLUSTERED ([AccountNo] ASC),
    CONSTRAINT [CK_Accounts_Balance] CHECK ([Balance]>=(0))
);
GO

