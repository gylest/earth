CREATE TABLE [dbo].[ChannelTypes] (
    [mnemonic]           [dbo].[str256] NOT NULL,
    [MeasurementMode]    INT            NOT NULL,
    [MeasuredSignal]     INT            NOT NULL,
    [MeasurementProcess] INT            NOT NULL,
    [FibreEnd]           INT            NOT NULL,
    CONSTRAINT [PK_ChannelTypes] PRIMARY KEY CLUSTERED ([mnemonic] ASC),
    CONSTRAINT [CK_ChannelTypes_FibreEnd] CHECK ([FibreEnd]>=(0) AND [FibreEnd]<=(2)),
    CONSTRAINT [CK_ChannelTypes_MeasuredSignal] CHECK ([MeasuredSignal]>=(0) AND [MeasuredSignal]<=(3)),
    CONSTRAINT [CK_ChannelTypes_MeasurementMode] CHECK ([MeasurementMode]>=(0) AND [MeasurementMode]<=(12)),
    CONSTRAINT [CK_ChannelTypes_MeasurementProcess] CHECK ([MeasurementProcess]>=(0) AND [MeasurementProcess]<=(4))
);
GO

