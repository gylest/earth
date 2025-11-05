CREATE PROCEDURE [dbo].[sp_ProcessTransfer]
AS
   DECLARE @Msg                 VARCHAR(500)
   DECLARE @MCount              INT
   DECLARE @ZMCount             INT
   DECLARE @AMCount             INT
   DECLARE @FBMCount            INT
   DECLARE @PRCount             INT
   DECLARE @Error               INT
   DECLARE @SqlString           NVARCHAR(500)
   DECLARE @ArchiveDatabaseName NVARCHAR(250)
   DECLARE @TableName           NVARCHAR(250)
   SET @Error                = 0
   SET @Msg                  = ''
   Set @ArchiveDatabaseName = N'DTS_Archive'
   EXECUTE sp_AddLogMessage 'Start execution of sp_ProcessTransfer()', 0
   IF (@Error = 0)
   BEGIN
      CREATE TABLE #Measurement( [ID]           [int]      NOT NULL ,
	                         [DTSID]        [int]          NULL ,
	                         [TimeStampUTC] [datetime] NOT NULL ,
	                         [TimeStampLoc] [datetime] NOT NULL)
      INSERT INTO #Measurement ( ID, DTSID, TimeStampUTC, TimeStampLoc)
         SELECT TOP 5 PERCENT ID, DTSID, TimeStampUTC, TimeStampLoc
         FROM Measurement
         ORDER BY ID ASC
      SET @Error  = @@Error
      SET @MCount = @@ROWCOUNT
   END
   IF (@Error = 0)
   BEGIN
      SET @TableName = @ArchiveDatabaseName + N'.dbo.Measurement'
      SET @SqlString = N'INSERT INTO '  + @TableName  +
                       N'   SELECT * FROM #Measurement'
      EXECUTE(@SqlString)
      SET @Error  = @@Error
   END
   IF (@Error = 0)
   BEGIN
      SET @TableName = @ArchiveDatabaseName + N'.dbo.Zone_Message'
      SET @SqlString = N'INSERT INTO '  + @TableName  +
                       N'   SELECT Zone_Message.* FROM Zone_Message INNER JOIN #Measurement ON Zone_Message.MeasurementID = #Measurement.ID'
      EXECUTE(@SqlString)
      SET @Error   = @@ERROR
      SET @ZMCount = @@ROWCOUNT
      IF (@Error = 0)
      BEGIN
         DELETE Zone_Message
         FROM Zone_Message INNER JOIN #Measurement 
         ON Zone_Message.MeasurementID = #Measurement.ID
      END
   END
   IF (@Error = 0)
   BEGIN
      SET @TableName = @ArchiveDatabaseName + N'.dbo.Alarm_Message'
      SET @SqlString = N'INSERT INTO '  + @TableName  +
                       N'   SELECT Alarm_Message.* FROM Alarm_Message INNER JOIN #Measurement ON Alarm_Message.MeasurementID = #Measurement.ID'
      EXECUTE(@SqlString)
      SET @Error   = @@ERROR
      SET @AMCount = @@ROWCOUNT
      IF (@Error = 0)
      BEGIN
         DELETE Alarm_Message
         FROM Alarm_Message INNER JOIN #Measurement 
         ON Alarm_Message.MeasurementID = #Measurement.ID
      END
   END
   IF (@Error = 0)
   BEGIN
      SET @TableName = @ArchiveDatabaseName + N'.dbo.FibreBreak_Message'
      SET @SqlString = N'INSERT INTO '  + @TableName  +
                       N'   SELECT FibreBreak_Message.* FROM FibreBreak_Message INNER JOIN #Measurement ON FibreBreak_Message.MeasurementID = #Measurement.ID'
      EXECUTE(@SqlString)
      SET @Error    = @@ERROR
      SET @FBMCount = @@ROWCOUNT
      IF (@Error = 0)
      BEGIN
         DELETE FibreBreak_Message
         FROM FibreBreak_Message INNER JOIN #Measurement 
         ON FibreBreak_Message.MeasurementID = #Measurement.ID
      END
   END
   IF (@Error = 0)
   BEGIN
      SET @TableName = @ArchiveDatabaseName + N'.dbo.Profiles'
      SET @SqlString = N'INSERT INTO '  + @TableName  +
                       N'   SELECT Profiles.* FROM Profiles INNER JOIN #Measurement ON Profiles.MeasurementID = #Measurement.ID'
      EXECUTE(@SqlString)
      SET @Error   = @@ERROR
      SET @PRCount = @@ROWCOUNT
      IF (@Error = 0)
      BEGIN
         DELETE Profiles
         FROM Profiles INNER JOIN #Measurement 
         ON Profiles.MeasurementID = #Measurement.ID
      END
   END
   SET @Msg = 'Completed execution of sp_ProcessTransfer() '
   SET @Msg = @Msg + 'Count of Measurements: '       + CAST(@MCount   as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of Zone_messages: '      + CAST(@ZMCount  as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of Alarm_Messages: '     + CAST(@AMCount  as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of FibreBreakMessages: ' + CAST(@FBMCount as VARCHAR) + ';'
   SET @Msg = @Msg + 'Count of Profiles: '           + CAST(@PRCount  as VARCHAR) + ';'
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

