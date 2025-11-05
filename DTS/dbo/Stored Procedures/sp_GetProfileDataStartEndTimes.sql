CREATE PROCEDURE [dbo].[sp_GetProfileDataStartEndTimes]
   @ConfigID     INT,
   @StartTime    DATETIME   = NULL    OUTPUT,
   @EndTime      DATETIME   = NULL    OUTPUT
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
      SELECT @StartTime = MIN(TimeStampUTC), @EndTime = MAX(TimeStampUTC)
      FROM Measurement, Profiles
      WHERE Measurement.ID    = Profiles.MeasurementID AND
            Profiles.ConfigID = @ActualConfigID
   END
   SET @Error = @@Error
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetProfileDataStartEndTimes] TO [DTSReadRole]
    AS [dbo];
GO

