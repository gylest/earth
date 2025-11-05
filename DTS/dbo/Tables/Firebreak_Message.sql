CREATE TABLE [dbo].[FibreBreak_Message] 
(
	[ID]             int IDENTITY (1, 1) NOT NULL,
	[MeasurementID]  int                 NOT NULL,
	[ConfigID]       int                 NOT NULL,
	[Type]           int                 NOT NULL,
	[FibreNumber]    int                 NOT NULL,
	[FirstPosition]  int                 NOT NULL,
	[SecondPosition] int                     NULL,
    [Retain]         INT CONSTRAINT [DF_FibreBreak_Message_Retain] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_FibreBreak_Message] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_FibreBreak_Message_Config] FOREIGN KEY ([ConfigID]) REFERENCES [dbo].[Config] ([ID]),
    CONSTRAINT [FK_FibreBreak_Message_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

CREATE TRIGGER FibreBreak_Message_Delete
    ON FibreBreak_Message
    FOR DELETE
AS
   SET NOCOUNT ON
   DELETE FROM Measurement WHERE ID IN
   (Select MeasurementID FROM Deleted)
GO