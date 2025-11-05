CREATE PROCEDURE [dbo].[sp_RemoveTxByDate]
   @RemoveDate  DATETIME
AS
   DECLARE @Msg       VARCHAR(500)
   DECLARE @ZMCount   INT
   DECLARE @PRCount   INT
   DECLARE @AMCount   INT
   DECLARE @FBMCount  INT
   DECLARE @Error     INT
   SET @Error         = 0
   SET @ZMCount       = 0
   SET @PRCount       = 0
   SET @AMCount       = 0
   SET @FBMCount      = 0
   SET @Msg           = ''
   EXECUTE sp_AddLogMessage 'Start execution of sp_RemoveTxByDate()', 0
   IF (@Error = 0)
   BEGIN
      CREATE TABLE #Measurement( [ID]   [int]   NOT NULL)
      SET @Error  = @@Error
   END
   IF (@Error = 0)
   BEGIN
      INSERT INTO #Measurement ( ID)
         SELECT ID FROM Measurement WHERE TimeStampUTC < @RemoveDate
      SET @Error  = @@Error
   END
   IF (@Error = 0)
   BEGIN
      DELETE Zone_Message
      FROM Zone_Message INNER JOIN #Measurement 
      ON Zone_Message.MeasurementID = #Measurement.ID
      SELECT @Error = @@ERROR, @ZMCount = @@ROWCOUNT
   END
   IF (@Error = 0)
   BEGIN
      DELETE Alarm_Message
      FROM Alarm_Message INNER JOIN #Measurement 
      ON Alarm_Message.MeasurementID = #Measurement.ID
      SELECT @Error = @@ERROR, @AMCount = @@ROWCOUNT
   END
   IF (@Error = 0)
   BEGIN
      DELETE FibreBreak_Message
      FROM FibreBreak_Message INNER JOIN #Measurement 
      ON FibreBreak_Message.MeasurementID = #Measurement.ID
      SELECT @Error = @@ERROR, @FBMCount = @@ROWCOUNT
   END
   IF (@Error = 0)
   BEGIN
      DELETE Profiles
      FROM Profiles INNER JOIN #Measurement 
      ON Profiles.MeasurementID = #Measurement.ID
      SELECT @Error = @@ERROR, @PRCount = @@ROWCOUNT
   END
   SET @Msg = 'Completed execution of sp_RemoveTxByDate() '
   SET @Msg = @Msg + 'Error Status =  ' + CAST(@Error  as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of (ZM,PR,AM,FBM) : (' + CAST(@ZMCount  as VARCHAR) + ',' + CAST(@PRCount  as VARCHAR) + ','
   SET @Msg = @Msg + + CAST(@AMCount as VARCHAR) + ',' + CAST(@FBMCount as VARCHAR) + ')'
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

