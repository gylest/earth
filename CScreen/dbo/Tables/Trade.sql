CREATE TABLE [dbo].[Trade]
(
    [TradeRowID]      BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Trade_TradeRowID PRIMARY KEY,
    [RecordDate]      DATE            NOT NULL,
    [RecordTime]      TIME(3)         NOT NULL,
    [IPAddress]       NVARCHAR(50)    NOT NULL,
    [User]            NVARCHAR(50)    NOT NULL,
    [Company]         NVARCHAR(50)    NOT NULL,
    [Role]            NVARCHAR(50)    NOT NULL,
    [Action]          NVARCHAR(50)    NOT NULL,
    [TradeID]         NVARCHAR(50)    NULL,
    [OrderBookID]     NVARCHAR(50)    NULL,
    [Price]           DECIMAL(19,6)   NULL,
    [Volume]          INT             NULL,
    [Volatility]      NVARCHAR(50)    NULL,
    [RefRate]         NVARCHAR(50)    NULL,
    [Comment]         NVARCHAR(50)    NULL,
    [IsBlocked]       BIT             NULL,
    [Recipients]      NVARCHAR(MAX)  NULL,
    [UserRecipients]  NVARCHAR(MAX)  NULL,
    [ImportDateTime]  DATETIME        NOT NULL,
    [ImportFile]      NVARCHAR(512)   NOT NULL
);
GO

CREATE INDEX IX_Trade_TradeID ON [dbo].[Trade]([TradeID]);
GO

CREATE INDEX IX_Trade_OrderBookID ON [dbo].[Trade]([OrderBookID]);
GO

