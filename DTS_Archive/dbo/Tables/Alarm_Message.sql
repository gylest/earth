CREATE TABLE [dbo].[Alarm_Message] (
    [ID]            INT        NOT NULL,
    [ZoneID]        INT        NOT NULL,
    [MeasurementID] INT        NOT NULL,
    [AlarmBandID]   INT        NOT NULL,
    [Criticality]   INT        NOT NULL,
    [AlarmStatus]   INT        NOT NULL,
    [Value]         FLOAT (53) NOT NULL,
    [Position]      INT        NOT NULL,
    [Retain]        INT        CONSTRAINT [DF_Alarm_Message_Retain] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Alarm_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Alarm_Message] CHECK ([Criticality]>=(0) AND [Criticality]<=(65535)),
    CONSTRAINT [FK_Alarm_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

