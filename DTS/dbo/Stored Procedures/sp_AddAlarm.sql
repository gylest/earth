CREATE PROCEDURE [dbo].[sp_AddAlarm]
   @Name                         NameUDT,
   @NameLocal                    LocalUDT,
   @ConfigName                   VARCHAR(200),
   @TriggerCondition             INT,
   @OnlySendFirstAlarmInBand     INT,
   @OutOfRangeNameHigh           NameUDT,
   @OutOfRangeNameLow            NameUDT
AS
   DECLARE @Error    INT
   DECLARE @ConfigID INT
   SET @Error = 0
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
      INSERT INTO Alarm  (  Name,  NameLocal, Version,  ConfigID,  TriggerCondition,  OnlySendFirstAlarmInBand,  OutOfRangeNameHigh,  OutOfRangeNameLow, CreateDT, ModifyDT)
                  VALUES ( @Name, @NameLocal, 1,       @ConfigID, @TriggerCondition, @OnlySendFirstAlarmInBand, @OutOfRangeNameHigh, @OutOfRangeNameLow, DEFAULT,  NULL)
   END
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddAlarm] TO [DTSModifyRole]
    AS [dbo];
GO


