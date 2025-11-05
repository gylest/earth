CREATE TABLE [dbo].[Profiles] (
    [ID]                     INT   NOT NULL,
    [MeasurementID]          INT   NOT NULL,
    [ConfigID]               INT   NOT NULL,
    [MeasurementMode]        INT   NOT NULL,
    [MeasuredSignal]         INT   NULL,
    [MeasurementProcess]     INT   NULL,
    [SectionNumber]          INT   NOT NULL,
    [FibreNumber]            INT   NOT NULL,
    [FibreEnd]               INT   NOT NULL,
    [DistanceFirstDataPoint] INT   NOT NULL,
    [NumberDataPoints]       INT   NOT NULL,
    [NumberOfMissingPoints]  INT   NOT NULL,
    [LengthProfile]          INT   NOT NULL,
    [CRCValue]               INT   NOT NULL,
    [CompressionInd]         INT   NOT NULL,
    [DataPoints]             IMAGE NOT NULL,
    [Retain]                 INT   CONSTRAINT [DF_Profiles_Retain] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Profiles] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [CK_Profiles_MeasurementProcess] CHECK ([MeasurementProcess]>=(0) AND [MeasurementProcess]<=(4)),
    CONSTRAINT [FK_Profiles_Measurement] FOREIGN KEY ([MeasurementID]) REFERENCES [dbo].[Measurement] ([ID])
);
GO

