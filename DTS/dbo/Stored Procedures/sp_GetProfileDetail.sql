CREATE PROCEDURE [dbo].[sp_GetProfileDetail]
   @ID 		INT
AS
   DECLARE @Error      INT
   SET @Error = 0
   IF (@Error = 0)
   BEGIN
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile, Profiles.DataPoints
      FROM Profiles, Measurement
      WHERE Profiles.ID = @ID AND
            Profiles.MeasurementID = Measurement.ID
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetProfileDetail] TO [DTSReadRole]
    AS [dbo];
GO


