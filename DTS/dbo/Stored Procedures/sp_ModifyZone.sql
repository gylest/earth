CREATE PROCEDURE [dbo].[sp_ModifyZone]
   @OldName            NameUDT,
   @NewName            NameUDT,
   @NameLocal          LocalUDT,
   @ConfigName         VARCHAR(200),
   @StartPosition      INT,
   @EndPosition        INT,
   @AlarmID            INT,
   @ProcessID          INT,
   @MeasurementMode    INT,
   @MeasuredSignal     INT,
   @MeasurementProcess INT,
   @FibreNumber        INT,
   @FibreEnd           INT
AS
   DECLARE @Error   INT
   DECLARE @Version INT
   DECLARE @ID      INT
   SET @Error   = 0
   SET @ID      = 0
   SET @Version = 0
   IF (@Error = 0)
   BEGIN
      SELECT @ID = dbo.fn_GetZoneID( @OldName, @ConfigName)
      IF (@ID=0)
      BEGIN
         SET @Error = 50005
      END
   END
   IF (@Error = 0)
   BEGIN
      SELECT @Version = Version FROM Zone WHERE [ID] = @ID
      SET @Version = @Version + 1
      UPDATE Zone
         SET [Name] = @NewName, NameLocal = @NameLocal, Version = @Version, StartPosition = @StartPosition, EndPosition = @EndPosition,
             AlarmID = @AlarmID, ProcessID = @ProcessID, MeasurementMode = @MeasurementMode, MeasuredSignal = @MeasuredSignal,
             MeasurementProcess = @MeasurementProcess, FibreNumber = @FibreNumber, FibreEnd = @FibreEnd, ModifyDT = SYSDATETIME()
       WHERE [ID] = @ID
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_ModifyZone] TO [DTSModifyRole]
    AS [dbo];
GO

