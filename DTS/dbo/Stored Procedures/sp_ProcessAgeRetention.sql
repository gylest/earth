CREATE PROCEDURE [dbo].[sp_ProcessAgeRetention]
AS
   DECLARE @Msg              VARCHAR(500)
   DECLARE @CurrentTime      DATETIME
   DECLARE @BoundaryTime     DATETIME
   DECLARE @Error            INT
   DECLARE @RuleType         INT
   DECLARE @TimeSpanMin      INT
   DECLARE @RetainPercentage INT
   DECLARE @Mode             INT
   SET @Error         = 0
   SET @CurrentTime   = SYSDATETIME()
   EXECUTE sp_AddLogMessage 'Start execution of sp_ProcessAgeRetention()', 0
   SET @RuleType = dbo.fn_GetCodedValue ('AgingRule', 'Retention')
   SELECT @TimeSpanMin=TimeSpanMin
   FROM   Aging_Rules
   WHERE  RuleType=@RuleType AND Period=1
   SELECT @RetainPercentage=RetainPercentage
   FROM   Aging_Rules
   WHERE  RuleType=@RuleType AND Period=2
   SET @BoundaryTime = DATEADD(minute, -@TimeSpanMin, @CurrentTime)
   EXECUTE sp_AgeZoneMessages @BoundaryTime, @RetainPercentage
   SET @Mode = 1
   WHILE (@Mode <= 15)
   BEGIN
      EXECUTE sp_AgeProfiles @BoundaryTime, @RetainPercentage, @Mode
      SET @Mode = @Mode + 1
   END
   IF (@Error = 0)
   BEGIN
      UPDATE Aging_Rules
      SET    LastRunDT = @CurrentTime
      WHERE  RuleType=@RuleType
   END
   SET @Msg = 'Completed execution of sp_ProcessAgeRetention(): '
   EXECUTE sp_AddLogMessage @Msg, 0
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

