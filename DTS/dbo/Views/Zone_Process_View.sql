CREATE VIEW dbo.Zone_Process_View
AS
SELECT     ID, ProcessName, ProcessNameLocal, Version, ConfigID,
           dbo.fn_GetValue('ZoneProcess',ProcessingMethod) as 'Processing Method',
           dbo.fn_GetValue('PositionReference',PositionReference) as 'Position Reference',
           dbo.fn_GetValue('Boolean',OutputEnabled) as 'Output Enabled',
           MeasurementLossFirstInterval, MeasurementLossSecondInterval, NumberOfRateOfChangeMeasurements, CreateDT, ModifyDT
FROM       dbo.Zone_Process
GO

GRANT SELECT
    ON OBJECT::[dbo].[Zone_Process_View] TO [VisitorRole]
    AS [dbo];
GO
