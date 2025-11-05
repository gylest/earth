CREATE TABLE [dbo].[FibreBreak_Message] (
    [ID]             INT NOT NULL,
    [MeasurementID]  INT NOT NULL,
    [ConfigID]       INT NOT NULL,
    [Type]           INT NOT NULL,
    [FibreNumber]    INT NOT NULL,
    [FirstPosition]  INT NOT NULL,
    [SecondPosition] INT NULL,
    [Retain]         INT CONSTRAINT [DF_FibreBreak_Message_Retain] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_FibreBreak_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_FibreBreak_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

