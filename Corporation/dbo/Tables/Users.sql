CREATE TABLE [dbo].[Users] (
    [uname]    VARCHAR (15) NOT NULL,
    [Pwd]      VARCHAR (25) NOT NULL,
    [userRole] VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([uname] ASC)
);
GO

