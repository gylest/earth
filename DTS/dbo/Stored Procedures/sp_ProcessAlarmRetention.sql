CREATE PROCEDURE [dbo].[sp_ProcessAlarmRetention]
AS
   DECLARE @Msg                VARCHAR(500)
   DECLARE @LastRunTime        DATETIME
   DECLARE @BeforeTime         DATETIME
   DECLARE @AfterTime          DATETIME
   DECLARE @tmpTimeStampUTC    DATETIME
   DECLARE @CurrentTime        DATETIME
   DECLARE @Error              INT
   DECLARE @BeforeTimeSpan     INT
   DECLARE @AfterTimeSpan      INT
   DECLARE @RuleType           INT
   DECLARE @AlarmCount         INT
   DECLARE @ProfileRetainCount INT
   DECLARE @ZMRetainCount      INT
   SET    @Msg                = ''
   SET    @Error              = 0
   SET    @AlarmCount         = 0
   SET    @ProfileRetainCount = 0
   SET    @ZMRetainCount      = 0
   EXECUTE sp_AddLogMessage 'Start execution of sp_ProcessAlarmRetention()', 0
   SELECT @RuleType = dbo.fn_GetCodedValue ('AgingRule', 'Alarm')
   SELECT @BeforeTimeSpan=AlarmBeforeTimeSpanMin,@AfterTimeSpan=AlarmAfterTimeSpanMin,@LastRunTime=ISNULL(LastRunDT,'1 January 2000 12:00AM')
   FROM   Aging_Rules
   WHERE  RuleType=@RuleType AND Period=1
   SET @CurrentTime = SYSDATETIME()
   CREATE TABLE #Alarm_Message(	[ID] [int] NOT NULL ,
			       	[ZoneID] [int] NOT NULL ,
				[TimeStampUTC] [datetime] NOT NULL ,
				[AlarmBandID] [int] NOT NULL ,
				[Criticality] [int] NOT NULL ,
				[AlarmStatus] [int] NOT NULL ,
				[Value] [float] NOT NULL ,
				[Position] [int] NOT NULL,
			        [Retain] [int] NOT NULL)
   INSERT INTO #Alarm_Message ( ID, ZoneID ,TimeStampUTC, AlarmBandID, Criticality, AlarmStatus, Value, Position, Retain)
   SELECT AM.ID, AM.ZoneID, Measurement.TimeStampUTC, AM.AlarmBandID, AM.Criticality, AM.AlarmStatus, AM.Value, AM.Position, AM.Retain
   FROM   Alarm_Message as AM, Measurement
   WHERE  AM.MeasurementID = Measurement.ID AND
          AM.Retain = 1
   SET @AlarmCount = @@ROWCOUNT
   IF (@AlarmCount > 0)
   BEGIN
      CREATE TABLE #Zone_Message( [ID] [int] NOT NULL)
      CREATE TABLE #Profiles    ( [ID] [int] NOT NULL)
      DECLARE Alarm_Message_cursor CURSOR 
      FAST_FORWARD 
      FOR SELECT TimeStampUTC FROM #Alarm_Message
      OPEN Alarm_Message_cursor
      FETCH NEXT FROM Alarm_Message_cursor INTO @tmpTimeStampUTC
      WHILE (@@FETCH_STATUS = 0)
      BEGIN
         SET @BeforeTime = DATEADD(minute, -@BeforeTimeSpan, @tmpTimeStampUTC)
         SET @AfterTime  = DATEADD(minute,  @AfterTimeSpan,  @tmpTimeStampUTC)
         INSERT INTO #Zone_Message ( ID)
         SELECT Zone_Message.ID
         FROM Zone_Message, Measurement
         WHERE Zone_Message.MeasurementID = Measurement.ID                  AND
               Zone_Message.Retain = 0                                      AND
               Measurement.TimeStampUTC BETWEEN @BeforeTime AND @AfterTime  AND
               NOT EXISTS
               (SELECT *
                FROM #Zone_Message
                WHERE [ID] = Zone_Message.ID)
         INSERT INTO #Profiles ( ID)
         SELECT Profiles.ID
         FROM Profiles, Measurement
         WHERE Profiles.MeasurementID = Measurement.ID                     AND
               Profiles.Retain = 0                                         AND
               Measurement.TimeStampUTC BETWEEN @BeforeTime AND @AfterTime AND
               NOT EXISTS
               (SELECT *
                FROM #Profiles
                WHERE [ID] = Profiles.ID)
         FETCH NEXT FROM Alarm_Message_cursor INTO @tmpTimeStampUTC
      END
      CLOSE Alarm_Message_cursor
      DEALLOCATE Alarm_Message_cursor
   END
   IF (@AlarmCount > 0)
   BEGIN
      SELECT @ZMRetainCount = Count(*) FROM #Zone_Message
      UPDATE Zone_Message
      SET Retain=2
      FROM Zone_Message, #Zone_Message
      WHERE Zone_Message.ID = #Zone_Message.ID
      SELECT @ProfileRetainCount = Count(*) FROM #Profiles
      UPDATE Profiles
      SET Retain=1
      FROM Profiles, #Profiles
      WHERE Profiles.ID = #Profiles.ID     
   END
   IF (@Error = 0)
   BEGIN
      UPDATE Alarm_Message
      SET Retain = 2
      FROM Alarm_Message, #Alarm_Message
      WHERE Alarm_Message.ID = #Alarm_Message.ID
   END
   IF (@Error = 0)
   BEGIN
      UPDATE Aging_Rules
      SET    LastRunDT = @CurrentTime
      WHERE  RuleType=@RuleType AND Period=1
   END
   SET @Msg = 'Completed execution of sp_ProcessAlarmRetention(): '
   SET @Msg = @Msg + 'Between ' + CAST(@LastRunTime  as VARCHAR) + ' and ' + CAST(@CurrentTime as VARCHAR) + ';'
   SET @Msg = @Msg + 'Number of Alarms= ' + CAST(@AlarmCount as VARCHAR) + ';'
   SET @Msg = @Msg + 'Retained profiles= ' + CAST(@ProfileRetainCount as VARCHAR) + ';'
   SET @Msg = @Msg + 'Retained zone_messages= ' + CAST(@ZMRetainCount as VARCHAR) + ';'
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

