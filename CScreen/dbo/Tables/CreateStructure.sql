CREATE TABLE [dbo].[CreateStructure]
(
    [RecordID]        INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CreateStructure_RecordID PRIMARY KEY,
    [RecordDate]      DATE            NOT NULL,
    [RecordTime]      TIME(3)         NOT NULL,
    [IPAddress]       NVARCHAR(50)    NOT NULL,
    [User]            NVARCHAR(50)    NOT NULL,
    [Company]         NVARCHAR(50)    NOT NULL,
    [Role]            NVARCHAR(50)    NOT NULL,
    [Action]          NVARCHAR(50)    NOT NULL,
    [OrderBookID]     NVARCHAR(50)    NULL,
    [Strategy]        NVARCHAR(50)    NULL,   -- Mapped from StructureType in code
    [IsPriced]        BIT             NULL,
    [PremiumType]     NVARCHAR(50)    NULL,
    [ImportDateTime]  DATETIME        NOT NULL,
    [ImportFile]      NVARCHAR(512)   NOT NULL
);
GO

CREATE INDEX IX_CreateStructure_OrderBookID ON [dbo].[CreateStructure]([OrderBookID]);
GO