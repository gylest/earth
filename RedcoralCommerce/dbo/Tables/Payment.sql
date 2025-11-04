CREATE TABLE [dbo].[Payment] (
    [PaymentID]      INT           IDENTITY (1, 1) NOT NULL,
    [CardType]       INT           NOT NULL,
    [CardNumber]     NVARCHAR (50) NOT NULL,
    [CardHolderName] NVARCHAR (50) NOT NULL,
    [CardExpiryDate] DATE          NOT NULL,
    [CreateDate]     DATETIME      CONSTRAINT [DF_Payment_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]     DATETIME      CONSTRAINT [DF_Payment_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED ([PaymentID] ASC)
);

