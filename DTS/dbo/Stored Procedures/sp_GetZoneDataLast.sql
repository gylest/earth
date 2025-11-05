CREATE PROCEDURE [dbo].[sp_GetZoneDataLast]
   @ConfigID    INT
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
      SELECT Zone.Name, ZM1.Value, ZM1.Position, ZM1.MeasurementStatus, Measurement.TimeStampUTC
      FROM   Zone_Message as ZM1, Measurement, Zone
      WHERE  ZM1.MeasurementID = (SELECT MAX(ZM2.MeasurementID) FROM Zone_Message AS ZM2 WHERE ZM2.ZoneID = ZM1.ZoneID) and 
             ZM1.MeasurementID = Measurement.ID AND
             Zone.ID = ZM1.ZoneID AND
             Zone.ConfigID = @ActualConfigID
      ORDER BY ZoneID
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetZoneDataLast] TO [DTSReadRole]
    AS [dbo];
GO

