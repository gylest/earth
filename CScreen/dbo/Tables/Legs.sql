CREATE TABLE [dbo].[Legs]
(
    [RecordID]          INT            NOT NULL,            -- FK to CreateStructure.RecordID
    [LegID]             INT            NOT NULL,
    [Type]              NVARCHAR(50)   NULL,
    [ExpirationDateTime] DATETIME      NULL,
    [Ratio]             DECIMAL(19,6)  NULL,
    [Strike]            DECIMAL(19,6)  NULL,
    [LongDateFormat]    BIT            NULL,
    [Choice]            NVARCHAR(50)   NULL,
    [StartDateTime]     DATETIME       NULL,
    [Currency]          NVARCHAR(50)   NULL,
    [FutureRefValue]    NVARCHAR(50)   NULL,
    [LegDelta]          NVARCHAR(50)   NULL,
    [InterestRate]      NVARCHAR(50)   NULL,
    [RefPrice]          NVARCHAR(50)   NULL,
    [RefPrice2]         NVARCHAR(50)   NULL,
    [ISINCode]          NVARCHAR(50)   NULL,
    [RICCode]           NVARCHAR(50)   NULL,
    [Underlying]        NVARCHAR(50)   NULL,
    [ExchangeType]      NVARCHAR(50)   NULL,
    [ExpirationType]    NVARCHAR(50)   NULL,
    [OptionStyle]       NVARCHAR(50)   NULL,
    [FutureType]        NVARCHAR(50)   NULL,
    [FutureRefDate]     DATE           NULL,
    [DeliveryStyle]     NVARCHAR(50)   NULL,
    [ContractFlexType]  NVARCHAR(50)   NULL,
    [ImportDateTime]    DATETIME       NOT NULL,
    [ImportFile]        NVARCHAR(512)  NOT NULL,
    CONSTRAINT [PK_Legs] PRIMARY KEY CLUSTERED ([RecordID],[LegID]),
    CONSTRAINT [FK_Legs_CreateStructure] FOREIGN KEY ([RecordID])
        REFERENCES [dbo].[CreateStructure]([RecordID]) ON DELETE CASCADE
);
GO
