CREATE TABLE [dbo].[Zone_Message] 
(
	[ID]                int IDENTITY (1, 1) NOT NULL,
	[Value]             float               NOT NULL,
    [Position]          INT        CONSTRAINT [DF_Zone_Message_Position] DEFAULT (NULL) NULL,
    [MeasurementID]     INT        NOT NULL,
    [ZoneID]            INT        NOT NULL,
    [MeasurementStatus] INT        NOT NULL,
    [Retain]            INT        CONSTRAINT [DF_Zone_Message_Retain] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Zone_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Zone_Message_MeasurementStatus] CHECK ([MeasurementStatus]>=(1) AND [MeasurementStatus]<=(3)),
    CONSTRAINT [FK_Zone_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID]),
    CONSTRAINT [FK_Zone_Message_Zone] FOREIGN KEY ([ZoneID]) REFERENCES [dbo].[Zone] ([ID])
);
GO

CREATE NONCLUSTERED INDEX [IND_Zone_Message_MeasurementID]
    ON [dbo].[Zone_Message]([MeasurementID] ASC);
GO

CREATE NONCLUSTERED INDEX [IND_Zone_Message_Retain]
    ON [dbo].[Zone_Message]([Retain] ASC);
GO

CREATE TRIGGER Zone_Message_Delete
    ON Zone_Message
    FOR DELETE
AS
   SET NOCOUNT ON
   DELETE FROM Measurement WHERE ID IN
   (Select MeasurementID FROM Deleted)
GO
