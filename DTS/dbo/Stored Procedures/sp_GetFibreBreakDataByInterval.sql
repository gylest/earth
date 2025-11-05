CREATE PROCEDURE [dbo].[sp_GetFibreBreakDataByInterval]
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
      SELECT FibreBreak_Message.ID, Measurement.TimeStampUTC, FibreBreak_Message.Type, FibreBreak_Message.FibreNumber,
             FibreBreak_Message.FirstPosition, FibreBreak_Message.SecondPosition
      FROM FibreBreak_Message, Measurement
      WHERE FibreBreak_Message.ConfigID      = @ActualConfigID     AND
            FibreBreak_Message.MeasurementID = Measurement.ID      AND
            Measurement.TimeStampUTC BETWEEN @StartDT AND @EndDT
      ORDER BY FibreBreak_Message.ID ASC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetFibreBreakDataByInterval] TO [DTSReadRole]
    AS [dbo];
GO


