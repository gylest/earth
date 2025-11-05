CREATE PROCEDURE [dbo].[sp_AddAlarmBand]
   @Name                           NameUDT,
   @NameLocal                      LocalUDT,
   @ConfigName                     VARCHAR(200),
   @AlarmName                      NameUDT,
   @LowLimit                       INT,
   @HighLimit                      INT,
   @Criticality                    INT,
   @TriggerDelayWhenProfileRising  INT,
   @TriggerDelayWhenProfileFalling INT
AS
   DECLARE @Error    INT
   DECLARE @AlarmID  INT
   DECLARE @ConfigID INT
   SET @Error = 0
   IF (@Error=0)
   BEGIN
      IF (@AlarmName is null)
      BEGIN
         SET @Error = 50006
      END
   END
   IF (@Error=0)
   BEGIN
      IF (@ConfigName is null)
      BEGIN
         SELECT @ConfigName = [Name] FROM Config WHERE Active = 1
      END
      SELECT @ConfigID = [ID] FROM Config WHERE [Name] = @ConfigName
      IF (@@ROWCOUNT = 0)
      BEGIN
         SET @Error = 50001
      END
   END
   IF (@Error = 0)
   BEGIN
      SELECT @AlarmID = [ID] FROM Alarm WHERE [Name] = @AlarmName AND [ConfigID] = @ConfigID
      IF (@@ROWCOUNT = 0)
      BEGIN
         SET @Error = 50006
      END
   END
   IF (@Error = 0)
   BEGIN
      INSERT INTO Alarm_Band (  Name,  NameLocal, Version,  LowLimit,  HighLimit,  Criticality,  TriggerDelayWhenProfileRising,  TriggerDelayWhenProfileFalling,  AlarmID, CreateDT, ModifyDT) 
                  VALUES     ( @Name, @NameLocal, 1,       @LowLimit, @HighLimit, @Criticality, @TriggerDelayWhenProfileRising, @TriggerDelayWhenProfileFalling, @AlarmID, DEFAULT,  NULL)
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddAlarmBand] TO [DTSModifyRole]
    AS [dbo];
GO


