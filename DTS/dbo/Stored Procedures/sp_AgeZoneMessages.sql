CREATE PROCEDURE [dbo].[sp_AgeZoneMessages]
   @BoundaryTime             DATETIME,
   @RetainPercentage         INT
AS
   DECLARE @Msg              VARCHAR(500)
   DECLARE @Error            INT
   DECLARE @tmpMeasurementID INT
   DECLARE @TotalRecs        INT
   DECLARE @CurrentRec       INT
   DECLARE @Adj              INT
   DECLARE @Prod             INT
   DECLARE @Res              INT
   DECLARE @RetainCount      INT
   DECLARE @DeleteCount      INT
   SET @Error          = 0
   SET @RetainCount    = 0
   SET @DeleteCount    = 0;
   EXECUTE sp_AddLogMessage 'Start execution of sp_AgeZoneMessages()', 0
   CREATE TABLE #Zone_Message(	[MeasurementID] [int] NOT NULL, [KeepRow] [bit] NOT NULL)
   INSERT INTO #Zone_Message ( MeasurementID, KeepRow)
   SELECT Zone_Message.MeasurementID, 0
   FROM   Zone_Message, Measurement
   WHERE  Zone_Message.MeasurementID = Measurement.ID AND
          Zone_Message.Retain = 0                     AND
          Measurement.TimeStampUTC <= @BoundaryTime
   GROUP BY MeasurementID
   SET @TotalRecs = @@ROWCOUNT
   IF (@TotalRecs > 100)
   BEGIN
      DECLARE Zone_Message_cursor CURSOR 
      FAST_FORWARD
      FOR SELECT MeasurementID FROM #Zone_Message
      OPEN Zone_Message_cursor
      SET @CurrentRec = 0
      SET @Adj        = 0
      FETCH NEXT FROM Zone_Message_cursor INTO @tmpMeasurementID
      WHILE (@@FETCH_STATUS = 0)
      BEGIN
         SET @CurrentRec = @CurrentRec + 1
         SET @Prod = (@CurrentRec * @RetainPercentage) - @Adj
         SET @Res  = @Prod / 100
         IF (@Res > = 1) or (@CurrentRec=1)
         BEGIN
            UPDATE #Zone_Message
            SET KeepRow = 1
            WHERE MeasurementID = @tmpMeasurementID
            IF (@CurrentRec > 1)
            BEGIN
               SET @Adj = @Adj + 100
            END
         END
         FETCH NEXT FROM Zone_Message_cursor INTO @tmpMeasurementID
      END
      CLOSE      Zone_Message_cursor
      DEALLOCATE Zone_Message_cursor
   END
   IF ( (@TotalRecs > 100) AND (@CurrentRec = @TotalRecs) )
   BEGIN
      EXECUTE sp_AddLogMessage 'Age Zone_Message table in sp_AgeZoneMessages()', 0
      DELETE FROM Zone_Message
      WHERE MeasurementID IN
      (Select MeasurementID from #Zone_Message WHERE KeepRow = 0)
      SET @DeleteCount = @@ROWCOUNT
      UPDATE Zone_Message
      SET Retain=10
      WHERE MeasurementID IN
      (Select MeasurementID from #Zone_Message WHERE KeepRow = 1)
      SET @RetainCount = @@ROWCOUNT
   END
   SET @Msg = 'Completed execution of sp_AgeZoneMessages(): '
   SET @Msg = @Msg + 'Boundary Time  ' + CAST(@BoundaryTime as VARCHAR) + ';'
   SET @Msg = @Msg + 'Retain %       ' + CAST(@RetainPercentage as VARCHAR) + ';'
   SET @Msg = @Msg + 'ZoneMessages  (' + CAST(@DeleteCount as VARCHAR) + 'D,' + CAST(@RetainCount as VARCHAR) +'R)';
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO


