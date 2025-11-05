CREATE PROCEDURE [dbo].[sp_ProcessTruncateDB]
WITH ENCRYPTION
AS
   DECLARE @Msg       VARCHAR(500)
   DECLARE @MCount    INT
   DECLARE @ZMCount   INT
   DECLARE @AMCount   INT
   DECLARE @FBMCount  INT
   DECLARE @PRCount   INT

   -- Initialize
   SET @Msg           = ''

   -- Log start of processing
   EXECUTE sp_AddLogMessage 'Start execution of sp_ProcessTruncateDB()', 0

   -- Select oldest 10% of messages from measurement table
   IF (@@Error = 0)
   BEGIN
      CREATE TABLE #Measurement( [ID]           [int]      NOT NULL ,
	                             [DTSID]        [int]          NULL ,
	                             [TimeStampUTC] [datetime] NOT NULL ,
	                             [TimeStampLoc] [datetime] NOT NULL)

      INSERT INTO #Measurement ( ID, DTSID, TimeStampUTC, TimeStampLoc) 
      SELECT TOP 10 PERCENT ID, DTSID, TimeStampUTC, TimeStampLoc
      FROM Measurement
      ORDER BY ID ASC

      SET @MCount = @@ROWCOUNT

   END

   --
   -- Delete messages ...
   --

   -- Zone_Messages
   IF (@@Error = 0)
   BEGIN
      DELETE Zone_Message
      FROM Zone_Message INNER JOIN #Measurement 
      ON Zone_Message.MeasurementID = #Measurement.ID

      SET @ZMCount = @@ROWCOUNT
   END

   -- Alarm_Messages
   IF (@@Error = 0)
   BEGIN
      DELETE Alarm_Message
      FROM Alarm_Message INNER JOIN #Measurement 
      ON Alarm_Message.MeasurementID = #Measurement.ID

      SET @AMCount = @@ROWCOUNT
   END

   -- FibreBreak_Messages
   IF (@@Error = 0)
   BEGIN
      DELETE FibreBreak_Message
      FROM FibreBreak_Message INNER JOIN #Measurement 
      ON FibreBreak_Message.MeasurementID = #Measurement.ID

      SET @FBMCount = @@ROWCOUNT
   END

   -- Profiles
   IF (@@Error = 0)
   BEGIN
      DELETE Profiles
      FROM Profiles INNER JOIN #Measurement 
      ON Profiles.MeasurementID = #Measurement.ID
      SET @PRCount = @@ROWCOUNT
   END

   -- Measurement
   IF (@@Error = 0)
   BEGIN
       DELETE Measurement
       FROM Measurement INNER JOIN #Measurement 
       ON Measurement.ID = #Measurement.ID
   END

   -- Log results of processing
   SELECT @Msg = 'Completed execution of sp_ProcessTruncateDB() '
   SELECT @Msg = @Msg + 'Count of Measurements: '       + CAST(@MCount   as VARCHAR) + ';'
   SELECT @Msg = @Msg + 'Count of Zone_messages: '      + CAST(@ZMCount  as VARCHAR) + ';'
   SELECT @Msg = @Msg + 'Count of Alarm_Messages: '     + CAST(@AMCount  as VARCHAR) + ';'
   SELECT @Msg = @Msg + 'Count of FibreBreakMessages: ' + CAST(@FBMCount as VARCHAR) + ';'
   SELECT @Msg = @Msg + 'Count of Profiles: '           + CAST(@PRCount  as VARCHAR) + ';'
   EXECUTE sp_AddLogMessage @Msg, 0

   -- Procedure standard return value
   RETURN @@Error

GO


