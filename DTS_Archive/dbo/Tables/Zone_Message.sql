CREATE TABLE [dbo].[Zone_Message] (
    [ID]                INT        NOT NULL,
    [Value]             FLOAT (53) NOT NULL,
    [Position]          INT        CONSTRAINT [DF_Zone_Message_Position] DEFAULT (NULL) NULL,
    [MeasurementID]     INT        NOT NULL,
    [ZoneID]            INT        NOT NULL,
    [MeasurementStatus] INT        NOT NULL,
    [Retain]            INT        CONSTRAINT [DF_Zone_Message_Retain] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Zone_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Zone_Message_MeasurementStatus] CHECK ([MeasurementStatus]>=(1) AND [MeasurementStatus]<=(3)),
    CONSTRAINT [FK_Zone_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

