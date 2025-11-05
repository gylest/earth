CREATE PROCEDURE [dbo].[sp_GetProfilesByInterval]
   @ConfigID    INT,
   @StartDT	DATETIME,
   @EndDT       DATETIME,
   @MaxProfiles INT
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
   SET ROWCOUNT @MaxProfiles
   IF (@Error = 0)
   BEGIN
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile
      FROM Profiles, Measurement
      WHERE Profiles.ConfigID      = @ActualConfigID               AND
            Profiles.MeasurementID = Measurement.ID                AND
            Measurement.TimeStampUTC BETWEEN @StartDT AND @EndDT
      ORDER BY Profiles.ID ASC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetProfilesByInterval] TO [DTSReadRole]
    AS [dbo];
GO


