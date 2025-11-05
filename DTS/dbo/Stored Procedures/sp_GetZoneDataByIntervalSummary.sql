CREATE PROCEDURE [dbo].[sp_GetZoneDataByIntervalSummary]
   @ConfigID    INT,
   @StartDT	DATETIME,
   @EndDT       DATETIME
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
      SELECT DISTINCT Measurement.ID , Measurement.TimeStampUTC
      FROM  Zone_Message, Zone, Measurement
      WHERE Zone_Message.MeasurementID = Measurement.ID AND
            Zone_Message.ZoneID = Zone.ID AND
            Zone.ConfigID = @ActualConfigID AND
            Measurement.TimeStampUTC BETWEEN @StartDT AND @EndDT
      ORDER BY Measurement.ID ASC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetZoneDataByIntervalSummary] TO [DTSReadRole]
    AS [dbo];
GO

