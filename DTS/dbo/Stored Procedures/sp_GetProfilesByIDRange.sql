CREATE PROCEDURE [dbo].[sp_GetProfilesByIDRange]
   @StartID	INT,
   @EndID       INT,
   @MaxProfiles INT
AS
   DECLARE @Error            INT
   SET @Error = 0
   SET ROWCOUNT @MaxProfiles
   IF (@Error = 0)
   BEGIN
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile
      FROM Profiles, Measurement
      WHERE Profiles.ID >= @StartID  AND
            Profiles.ID <= @EndID    AND
            Profiles.MeasurementID = Measurement.ID   
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
    ON OBJECT::[dbo].[sp_GetProfilesByIDRange] TO [DTSReadRole]
    AS [dbo];
GO


