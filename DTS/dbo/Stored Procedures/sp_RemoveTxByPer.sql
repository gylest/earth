CREATE PROCEDURE [dbo].[sp_RemoveTxByPer]
   @RemovePer  INT
AS
   DECLARE @Msg       VARCHAR(500)
   DECLARE @ZMCount   INT
   DECLARE @PRCount   INT
   DECLARE @AMCount   INT
   DECLARE @FBMCount  INT
   DECLARE @Error     INT
   DECLARE @CurPer    INT
   SET @Error         = 0
   SET @ZMCount       = 0
   SET @PRCount       = 0
   SET @AMCount       = 0
   SET @FBMCount      = 0
   SET @CurPer        = 0
   SET @Msg           = ''
   EXECUTE sp_AddLogMessage 'Start execution of sp_RemoveTxByPer()', 0
   IF (@Error = 0)
   BEGIN
      IF (@RemovePer <=0 OR @RemovePer > 10)
      BEGIN
         SET @Error = 50011
      END
   END
   IF (@Error = 0)
   BEGIN
      CREATE TABLE #Measurement( [ID]   [int]   NOT NULL)
      SET @Error  = @@Error
   END
   SET @CurPer = 1
   WHILE (@CurPer <= @RemovePer AND @Error = 0)
   BEGIN
      IF (@Error = 0)
      BEGIN
         INSERT INTO #Measurement ( ID)
         SELECT TOP 1 PERCENT [ID]
         FROM Measurement
         ORDER BY ID ASC
         SET @Error  = @@Error
      END
      IF (@Error = 0)
      BEGIN
          DELETE Zone_Message
          FROM Zone_Message INNER JOIN #Measurement 
          ON Zone_Message.MeasurementID = #Measurement.ID
         SELECT @Error = @@ERROR, @ZMCount = @ZMCount + @@ROWCOUNT
      END
      IF (@Error = 0)
      BEGIN
         DELETE Alarm_Message
         FROM Alarm_Message INNER JOIN #Measurement 
         ON Alarm_Message.MeasurementID = #Measurement.ID
         SELECT @Error = @@ERROR, @AMCount = @AMCount + @@ROWCOUNT
      END
      IF (@Error = 0)
      BEGIN
         DELETE FibreBreak_Message
         FROM FibreBreak_Message INNER JOIN #Measurement 
         ON FibreBreak_Message.MeasurementID = #Measurement.ID
         SELECT @Error = @@ERROR, @FBMCount = @FBMCount + @@ROWCOUNT
      END
      IF (@Error = 0)
      BEGIN
         DELETE Profiles
         FROM Profiles INNER JOIN #Measurement 
         ON Profiles.MeasurementID = #Measurement.ID
         SELECT @Error = @@ERROR, @PRCount = @PRCount + @@ROWCOUNT
      END
      IF (@Error = 0)
      BEGIN
         CHECKPOINT
         TRUNCATE TABLE #Measurement
      END
      SET @CurPer = @CurPer + 1
   END
   SET @Msg = 'Completed execution of sp_RemoveTxByPer() '
   SET @Msg = @Msg + 'Error Status =  ' + CAST(@Error  as VARCHAR) + ';'
   SET @Msg = @Msg + 'Remove(%) =  ' + CAST(@RemovePer  as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of (ZM,PR,AM,FBM) : (' + CAST(@ZMCount  as VARCHAR) + ',' + CAST(@PRCount  as VARCHAR) + ','
   SET @Msg = @Msg + + CAST(@AMCount as VARCHAR) + ',' + CAST(@FBMCount as VARCHAR) + ')'
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

