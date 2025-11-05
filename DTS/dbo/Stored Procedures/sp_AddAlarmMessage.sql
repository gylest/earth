CREATE PROCEDURE [dbo].[sp_AddAlarmMessage]
   @ZoneName          NameUDT,
   @AlarmBandName     NameUDT,
   @AlarmCriticality  INT,
   @AlarmStatus       INT,
   @Value             FLOAT,
   @Position          INT,
   @MeasurementID     INT
AS
   DECLARE @Error       INT
   DECLARE @ConfigID    INT
   DECLARE @ZoneID      INT
   DECLARE @AlarmID     INT
   DECLARE @AlarmBandID INT
   SELECT @ConfigID    = [ID]      FROM Config     WHERE Active = 1
   SELECT @ZoneID      = [ID]      FROM Zone       WHERE [Name] = @ZoneName AND ConfigID = @ConfigID
   SELECT @AlarmID     = [AlarmID] FROM Zone       WHERE [Name] = @ZoneName AND ConfigID = @ConfigID
   Select @AlarmBandID = [ID]      FROM Alarm_Band WHERE [Name] = @AlarmBandName AND [AlarmID] = @AlarmID
   INSERT INTO Alarm_Message (  ZoneID,  MeasurementID,  AlarmBandID,  Criticality,       AlarmStatus,  Value,  Position, Retain)
               VALUES        ( @ZoneID, @MeasurementID, @AlarmBandID, @AlarmCriticality, @AlarmStatus, @Value, @Position, DEFAULT)
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddAlarmMessage] TO [DTSModifyRole]
    AS [dbo];
GO

