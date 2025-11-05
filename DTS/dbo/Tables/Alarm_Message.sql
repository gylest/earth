CREATE TABLE [dbo].[Alarm_Message] 
(
	[ID]            int IDENTITY (1, 1) NOT NULL,
	[ZoneID]        int                 NOT NULL,
	[MeasurementID] int                 NOT NULL,
	[AlarmBandID]   int                 NOT NULL,
	[Criticality]   int                 NOT NULL,
	[AlarmStatus]   int                 NOT NULL,
	[Value]         float               NOT NULL,
	[Position]      int                 NOT NULL,
    [Retain]        INT        CONSTRAINT [DF_Alarm_Message_Retain] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Alarm_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Alarm_Message] CHECK ([Criticality]>=(0) AND [Criticality]<=(65535)),
    CONSTRAINT [FK_Alarm_Message_Alarm_Band] FOREIGN KEY ([AlarmBandID]) REFERENCES [dbo].[Alarm_Band] ([ID]),
    CONSTRAINT [FK_Alarm_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID]),
    CONSTRAINT [FK_Alarm_Message_Zone] FOREIGN KEY ([ZoneID]) REFERENCES [dbo].[Zone] ([ID])
);
GO

CREATE NONCLUSTERED INDEX [IND_Alarm_Message_Retain]
    ON [dbo].[Alarm_Message]([Retain] ASC);
GO

CREATE TRIGGER Alarm_Message_Delete
    ON Alarm_Message
    FOR DELETE
AS
   SET NOCOUNT ON
   DELETE FROM Measurement WHERE ID IN
   (Select MeasurementID FROM Deleted)
GO