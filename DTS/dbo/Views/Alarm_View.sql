CREATE VIEW dbo.Alarm_View
AS
SELECT     ID, Name, NameLocal, Version, ConfigID,
           dbo.fn_GetValue('TriggerCondition',TriggerCondition) as 'Trigger Condition',
           dbo.fn_GetValue('Boolean',OnlySendFirstAlarmInBand) as 'OnlySendFirstAlarmInBand',
           OutOfRangeNameHigh, OutOfRangeNameLow, CreateDT, ModifyDT
FROM       dbo.[Alarm]
GO

GRANT SELECT
    ON OBJECT::[dbo].[Alarm_View] TO [VisitorRole]
    AS [dbo];
GO
