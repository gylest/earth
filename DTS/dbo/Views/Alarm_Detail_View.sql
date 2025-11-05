CREATE VIEW dbo.Alarm_Detail_View
AS
SELECT     TOP 100 PERCENT dbo.Alarm.ID, dbo.Alarm.Name, dbo.Alarm.NameLocal, dbo.Alarm.Version, dbo.Alarm.ConfigID, dbo.Alarm.TriggerCondition, 
           dbo.Alarm.OnlySendFirstAlarmInBand, dbo.Alarm.OutOfRangeNameHigh, dbo.Alarm.OutOfRangeNameLow, dbo.Alarm.CreateDT, 
           dbo.Alarm_Band.ID AS BandID, dbo.Alarm_Band.Name AS BandName, dbo.Alarm_Band.NameLocal AS BandNameLocal, 
           dbo.Alarm_Band.Version AS BandVersion, dbo.Alarm_Band.LowLimit AS BandLowLimit, dbo.Alarm_Band.HighLimit AS BandHighLimit, 
           dbo.Alarm_Band.Criticality AS BandCriticality, dbo.Alarm_Band.TriggerDelayWhenProfileRising AS BandTriggerDElayWhenProfileRising, 
           dbo.Alarm_Band.TriggerDelayWhenProfileFalling AS BandTriggerDelayWhenProfileFalling, dbo.Alarm_Band.CreateDT AS BandCreateDT
FROM       dbo.Alarm INNER JOIN dbo.Alarm_Band ON dbo.Alarm.ID = dbo.Alarm_Band.AlarmID
ORDER BY dbo.Alarm.ID
GO

GRANT SELECT
    ON OBJECT::[dbo].[Alarm_Detail_View] TO [VisitorRole]
    AS [dbo];
GO
