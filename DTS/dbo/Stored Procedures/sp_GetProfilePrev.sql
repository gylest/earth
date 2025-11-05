CREATE PROCEDURE [dbo].[sp_GetProfilePrev]
   @ID	               INT,
   @FibreNumber        INT,
   @MeasurementMode    INT,
   @MeasuredSignal     INT,
   @MeasurementProcess INT,
   @FibreEnd           INT
AS
   DECLARE @Error      INT
   DECLARE @TmpId      INT
   SET @Error       = 0
   IF (@Error = 0)
   BEGIN
      SELECT @TmpId = Profiles.ID
      FROM  Profiles
      WHERE Profiles.ID         = @ID
      IF (@@ROWCOUNT = 0)
      BEGIN
         SET @Error = 50013  -- Profile passed in not found
      END   
   END
   IF (@Error = 0) AND (@FibreNumber IS NOT NULL)
   BEGIN
      SET ROWCOUNT 1
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile
      FROM Profiles, Measurement
      WHERE Profiles.ID                 < @ID                 AND
            Profiles.FibreNumber        = @FibreNumber        AND
            Profiles.MeasurementMode    = @MeasurementMode    AND
            Profiles.MeasuredSignal     = @MeasuredSignal     AND
            Profiles.MeasurementProcess = @MeasurementProcess AND
            Profiles.FibreEnd           = @FibreEnd           AND 
            Profiles.MeasurementID      = Measurement.ID  
      ORDER BY Profiles.ID DESC
   END
   IF (@Error = 0) AND (@FibreNumber IS NULL)
   BEGIN
      SET ROWCOUNT 1
      SELECT Profiles.ID, Measurement.TimeStampUTC, Profiles.MeasurementMode, Profiles.MeasuredSignal, Profiles.MeasurementProcess, Profiles.SectionNumber,
             Profiles.FibreNumber, Profiles.FibreEnd, Profiles.DistanceFirstDataPoint, Profiles.NumberDataPoints, Profiles.NumberOfMissingPoints, Profiles.LengthProfile
      FROM Profiles, Measurement
      WHERE Profiles.ID                 < @ID                 AND
            Profiles.MeasurementMode    = @MeasurementMode    AND
            Profiles.MeasuredSignal     = @MeasuredSignal     AND
            Profiles.MeasurementProcess = @MeasurementProcess AND
            Profiles.MeasurementID      = Measurement.ID  
      ORDER BY Profiles.ID DESC
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetProfilePrev] TO [DTSReadRole]
    AS [dbo];
GO


