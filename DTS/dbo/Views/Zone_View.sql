CREATE VIEW dbo.Zone_View
AS
SELECT     ID, Name, NameLocal, Version, ConfigID, StartPosition, EndPosition, AlarmID, ProcessID,
           dbo.fn_GetValue('MeasurementMode',MeasurementMode) as 'Measurement Mode', 
           dbo.fn_GetValue('MeasuredSignal',MeasuredSignal) as 'Measuremed Signal',
           dbo.fn_GetValue('MeasurementProcess',MeasurementProcess) as 'Measurement Process', 
           FibreNumber, FibreEnd, CreateDT, ModifyDT
FROM       dbo.[Zone]
GO

GRANT SELECT
    ON OBJECT::[dbo].[Zone_View] TO [VisitorRole]
    AS [dbo];
GO