CREATE PROCEDURE [dbo].[sp_GetZoneDataByID]
   @MeasurementID     INT
AS
   DECLARE @Error      INT
   SET @Error = 0
   IF (@Error = 0)
   BEGIN
      SELECT Zone.Name, Zone_Message.Value, Zone_Message.Position, Zone_Message.MeasurementStatus, Measurement.TimeStampUTC
      FROM Zone_Message, Zone, Measurement
      WHERE Measurement.ID = @MeasurementID AND
            Measurement.ID = Zone_Message.MeasurementID AND
            Zone_Message.ZoneID = Zone.ID
      ORDER BY Zone_Message.ID ASC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetZoneDataByID] TO [DTSReadRole]
    AS [dbo];
GO


