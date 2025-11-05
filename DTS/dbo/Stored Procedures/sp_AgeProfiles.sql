CREATE PROCEDURE [dbo].[sp_AgeProfiles]
   @BoundaryTime               DATETIME,
   @RetainPercentage           INT,
   @MeasurementMode            INT
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
   EXECUTE sp_AddLogMessage 'Start execution of sp_AgeProfiles()', 0
   CREATE TABLE #Profiles ( [MeasurementID] [int] NOT NULL, [KeepRow] [bit] NOT NULL)
   INSERT INTO #Profiles  ( MeasurementID, KeepRow)
   SELECT Profiles.MeasurementID, 0
   FROM   Profiles, Measurement
   WHERE  Profiles.MeasurementID = Measurement.ID     AND
          Profiles.Retain = 0                         AND
          Measurement.TimeStampUTC <= @BoundaryTime   AND
          Profiles.MeasurementMode = @MeasurementMode
   SET @TotalRecs = @@ROWCOUNT
   IF (@TotalRecs > 100)
   BEGIN
      DECLARE Profiles_cursor CURSOR 
      FAST_FORWARD
      FOR SELECT Measurementid FROM #Profiles
      OPEN Profiles_cursor
      SET    @CurrentRec = 0
      SET    @Adj        = 0
      FETCH NEXT FROM Profiles_cursor INTO @tmpMeasurementID
      WHILE (@@FETCH_STATUS = 0)
      BEGIN
         SET @CurrentRec = @CurrentRec + 1
         SET @Prod = (@CurrentRec * @RetainPercentage) - @Adj
         SET @Res  = @Prod / 100
         IF (@Res > = 1) or (@CurrentRec=1)
         BEGIN
            UPDATE #Profiles
            SET KeepRow = 1
            WHERE MeasurementID = @tmpMeasurementID
            IF (@CurrentRec > 1)
            BEGIN
               SET @Adj = @Adj + 100
            END
         END
         FETCH NEXT FROM Profiles_cursor INTO @tmpMeasurementID
      END
      CLOSE      Profiles_cursor
      DEALLOCATE Profiles_cursor
   END
   IF ( (@TotalRecs > 100) AND (@CurrentRec = @TotalRecs) )
   BEGIN
      EXECUTE sp_AddLogMessage 'Age Profile table in sp_AgeProfiles()', 0
      DELETE FROM Profiles
      WHERE MeasurementID IN
      (Select MeasurementID from #Profiles WHERE KeepRow = 0)
      SET @DeleteCount = @@ROWCOUNT
      UPDATE Profiles
      SET Retain=10
      WHERE MeasurementID IN
      (Select MeasurementID from #Profiles WHERE KeepRow = 1)
      SET @RetainCount = @@ROWCOUNT
   END
   SET @Msg = 'Completed execution of sp_AgeProfiles(): '
   SET @Msg = @Msg + 'Boundary Time   ' + CAST(@BoundaryTime as VARCHAR) + ';'
   SET @Msg = @Msg + 'MeasurementMode ' + CAST(@MeasurementMode as VARCHAR) + ';'
   SET @Msg = @Msg + 'Retain %        ' + CAST(@RetainPercentage as VARCHAR) + ';'
   SET @Msg = @Msg + 'Profiles       (' + CAST(@DeleteCount as VARCHAR) + 'D,' + CAST(@RetainCount as VARCHAR) +'R)';
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO


