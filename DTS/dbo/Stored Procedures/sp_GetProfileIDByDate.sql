CREATE PROCEDURE [dbo].[sp_GetProfileIDByDate]
   @StartDT	DATETIME,
   @BeforeFlag	BIT,
   @ID          INT      =   -1   OUTPUT,
   @ConfigID    INT      =   -1   OUTPUT,
   @ActualDT    DATETIME = NULL   OUTPUT
AS
   DECLARE @Error     INT
   SET @Error = 0
   SET ROWCOUNT 1
   IF (@BeforeFlag = 1)
   BEGIN
      SELECT @ID = Profiles.ID, @ConfigID = Profiles.ConfigID, @ActualDT = Measurement.TimeStampUTC
      FROM Profiles, Measurement
      WHERE Profiles.MeasurementID = Measurement.ID AND 
            Measurement.TimeStampUTC < @StartDT
      ORDER BY Profiles.ID DESC
      SET @Error = @@Error
   END
   ELSE
   BEGIN
      SELECT @ID = Profiles.ID, @ConfigID = Profiles.ConfigID, @ActualDT = Measurement.TimeStampUTC
      FROM Profiles, Measurement
      WHERE Profiles.MeasurementID = Measurement.ID AND 
            Measurement.TimeStampUTC > @StartDT
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
    ON OBJECT::[dbo].[sp_GetProfileIDByDate] TO [DTSReadRole]
    AS [dbo];
GO


