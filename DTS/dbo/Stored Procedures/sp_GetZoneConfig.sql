CREATE PROCEDURE [dbo].[sp_GetZoneConfig]
   @ConfigID         INT
AS
   DECLARE @Error            INT
   DECLARE @ActualConfigID   INT
   SET @Error          = 0
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
      SELECT Zone.ID, Zone.Name, Zone.NameLocal, Zone.Version, Zone.ConfigID, Zone.StartPosition, ZOne.EndPosition, Zone.AlarmID, Zone.ProcessID,
             Zone.MeasurementMode, Zone.MeasuredSignal, Zone.MeasurementProcess, Zone.FibreNumber, Zone.FibreEnd, Zone.CreateDT, Zone.ModifyDT,
             Zone_Process.ProcessName, Zone_Process.ProcessNameLocal, Zone_Process.Version, Zone_Process.ProcessingMethod,
             Zone_Process.PositionReference, Zone_Process.OutputEnabled, Zone_Process.MeasurementLossFirstInterval,
             Zone_Process.MeasurementLossSecondInterval, Zone_Process.NumberOfRateOfChangeMeasurements,
             Zone_Process.CreateDT as 'ZPCreateDT', Zone_Process.ModifyDT as 'ZPModifyDT'
      FROM Zone, Zone_Process
      Where Zone.ConfigID  = @ActualConfigID AND
            Zone.ProcessID = Zone_Process.ID
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetZoneConfig] TO [DTSReadRole]
    AS [dbo];
GO


