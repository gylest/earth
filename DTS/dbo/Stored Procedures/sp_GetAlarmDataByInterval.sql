CREATE PROCEDURE [dbo].[sp_GetAlarmDataByInterval]
   @ConfigID     INT,
   @StartDT	 DATETIME,
   @EndDT        DATETIME
AS
   DECLARE @Error            INT
   DECLARE @ActualConfigID   INT
   SET @Error = 0
   IF (@Error=0)
   BEGIN
      IF (@ConfigID = 0)
      BEGIN
         SELECT @ActualConfigID = [ID] FROM Config WHERE Active = 1
      END
      ELSE
      BEGIN
         SET  @ActualConfigID = @ConfigID
      END
   END
   IF (@Error = 0)
   BEGIN
      SELECT Alarm.Name, Zone.Name as ZoneName,Alarm_Band.Name as AlarmBandName,Alarm_Message.Criticality,
             Alarm_Message.AlarmStatus, Alarm_Message.Value, Alarm_Message.Position, Measurement.TimeStampUTC
      FROM Alarm_Message, Alarm_Band, Alarm, Zone, Measurement
      WHERE Alarm_Message.AlarmBandID   = Alarm_Band.ID AND
            Alarm_Message.ZoneID        = Zone.ID AND
            Zone.ConfigID               = @ActualConfigID AND
            Alarm_Message.MeasurementID = Measurement.ID AND
            Alarm_Band.AlarmID          = Alarm.ID AND
            Measurement.TimeStampUTC BETWEEN @StartDT AND @EndDT
      ORDER BY Alarm_Message.ID ASC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetAlarmDataByInterval] TO [DTSReadRole]
    AS [dbo];
GO

