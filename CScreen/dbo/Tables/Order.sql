CREATE TABLE [dbo].[Order]
(
    [OrderRowID]      BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Added surrogate key
    [RecordDate]      DATE            NOT NULL,
    [RecordTime]      TIME(3)         NOT NULL,
    [IPAddress]       NVARCHAR(50)    NOT NULL,
    [User]            NVARCHAR(50)    NOT NULL,
    [Company]         NVARCHAR(50)    NOT NULL,
    [Role]            NVARCHAR(50)    NOT NULL,
    [Action]          NVARCHAR(50)    NOT NULL,
    [OrderID]         NVARCHAR(50)    NULL,
    [OrderBookID]     NVARCHAR(50)    NULL,
    [IsImported]      BIT             NULL,
    [Broker]          NVARCHAR(50)    NULL,
    [Type]            NVARCHAR(50)    NULL,
    [Validity]        NVARCHAR(50)    NULL,
    [Price]           DECIMAL(19,6)   NULL,
    [Volume]          INT             NULL,
    [Volatility]      NVARCHAR(50)    NULL,
    [RefRate]         NVARCHAR(50)    NULL,
    [Comment]         NVARCHAR(50)    NULL,
    [IsBlocked]       BIT             NULL,
    [Recipients]      NVARCHAR(2048)  NULL,
    [UserRecipients]  NVARCHAR(2048)  NULL,
    [RefreshDateTime] DATETIME        NULL,
    [ImportDateTime]  DATETIME        NOT NULL,
    [ImportFile]      NVARCHAR(512)   NOT NULL
);
GO

CREATE INDEX IX_Order_OrderID ON [dbo].[Order]([OrderID]);
GO

CREATE INDEX IX_Order_OrderBookID ON [dbo].[Order]([OrderBookID]);
GO

