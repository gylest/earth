CREATE TABLE [dbo].[UnitAcquisitions] (
    [ID]                 INT           NOT NULL,
    [numSerial]          [dbo].[str32] NOT NULL,
    [dTim]               DATETIME      NOT NULL,
    [calibration_dtim]   DATETIME      NOT NULL,
    [configuration_dtim] DATETIME      NOT NULL,
    [manufacturer]       [dbo].[str64] NOT NULL,
    [model]              [dbo].[str32] NOT NULL,
    [supplier]           [dbo].[str32] NOT NULL,
    [CreateDate]         DATETIME      CONSTRAINT [DF_UnitAcquisitions_CreateDate] DEFAULT (sysdatetime()) NOT NULL,
    [ModifyDate]         DATETIME      CONSTRAINT [DF_UnitAcquisitions_ModifyDate] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_UnitAcquisitions] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_UnitAcquisitions_numSerial] CHECK (len([numSerial])>(0)),
    CONSTRAINT [FK_UnitAcquisitions_Sensors] FOREIGN KEY ([ID]) REFERENCES [dbo].[Sensors] ([ID])
);
GO

