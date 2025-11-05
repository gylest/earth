CREATE PROCEDURE [dbo].[sp_AddZone]
   @Name               NameUDT,
   @NameLocal          LocalUDT,
   @ConfigName         VARCHAR(200),
   @StartPosition      INT,
   @EndPosition        INT,
   @AlarmName          NameUDT,
   @ProcessName        NameUDT,
   @MeasurementMode    INT,
   @MeasuredSignal     INT,
   @MeasurementProcess INT,
   @FibreNumber        INT,
   @FibreEnd           INT
AS
   DECLARE @Error      INT
   DECLARE @ConfigID   INT
   DECLARE @AlarmID    INT
   DECLARE @ProcessID  INT
   SET @Error = 0
   IF (@Error=0)
   BEGIN
      IF (@ConfigName is null)
      BEGIN
         SELECT @ConfigName = [Name] FROM Config WHERE Active = 1
      END
      SELECT @ConfigID = [ID] FROM Config WHERE [Name] = @ConfigName
      IF (@@ROWCOUNT <> 1)
      BEGIN
         SET @Error = 50001
      END
   END
   IF (@Error = 0)
   BEGIN
      SELECT @AlarmID = [ID] FROM Alarm WHERE [Name] = @AlarmName AND [ConfigID] = @ConfigID
      IF (@@ROWCOUNT <> 1)
      BEGIN
        SET @Error = 50007
      END
   END
   IF (@Error = 0)
   BEGIN
      SELECT @ProcessID = [ID] FROM Zone_Process WHERE [ProcessName] = @ProcessName AND [ConfigID] = @ConfigID
      IF (@@ROWCOUNT <> 1)
      BEGIN
        SET @Error = 50008
      END
   END
   IF (@Error = 0)
   BEGIN
      INSERT INTO Zone   (  Name, NameLocal,Version, ConfigID, StartPosition, EndPosition, AlarmID, ProcessID, MeasurementMode, MeasuredSignal, MeasurementProcess, FibreNumber, FibreEnd,CreateDT,ModifyDT)
                  VALUES ( @Name,@NameLocal,1,      @ConfigID,@StartPosition,@EndPosition,@AlarmID,@ProcessID,@MeasurementMode,@MeasuredSignal,@MeasurementProcess,@FibreNumber,@FibreEnd,DEFAULT,NULL)
      SET @Error = @@ERROR
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_AddZone] TO [DTSModifyRole]
    AS [dbo];
GO


