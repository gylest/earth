CREATE PROCEDURE [dbo].[sp_GetProfilesByCycle]
   @ID	        INT
AS
   DECLARE @Error            INT
   DECLARE @FibreNumber      INT
   DECLARE @PrevID           INT
   SET @Error       = 0
   SET @FibreNumber = 0
   SET @PrevID      = 0
   IF (@Error = 0)
   BEGIN
      SELECT @FibreNumber = Profiles.FibreNumber
      FROM Profiles
      WHERE Profiles.ID = @ID AND
            Profiles.MeasurementMode    = 1 AND
            Profiles.MeasuredSignal     = 0 AND
            Profiles.MeasurementProcess = 0   
       IF (@@ROWCOUNT = 0)
       BEGIN
           SET @Error = 50012  -- No valid profile found
       END   
   END
   IF (@Error = 0)
   BEGIN
       SET ROWCOUNT 1
       SELECT @PrevID = MAX(Profiles.ID)
       FROM   Profiles
       WHERE  Profiles.ID                 < @ID          AND
              Profiles.FibreNumber        = @FibreNumber AND
              Profiles.MeasurementMode    = 1            AND
              Profiles.MeasuredSignal     = 0            AND
              Profiles.MeasurementProcess = 0
       SELECT @PrevID = IsNull(@PrevID,0)
   END
   IF (@Error = 0)
   BEGIN
      SET ROWCOUNT 64
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile
      FROM Profiles, Measurement
      WHERE Profiles.ID            >  @PrevID       AND
            Profiles.ID            <= @ID           AND
            Profiles.MeasurementID = Measurement.ID AND
            Profiles.FibreNumber   = @FibreNumber   
      ORDER BY Profiles.ID DESC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetProfilesByCycle] TO [DTSReadRole]
    AS [dbo];
GO

