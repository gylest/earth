CREATE PROCEDURE [dbo].[sp_GetAgingRules]
AS
   DECLARE @Error      INT
   SET @Error = 0
   IF (@Error = 0)
   BEGIN
      SELECT ID, RuleType, Period, PeriodDescription, TimeSpanMin, RetainPercentage, AlarmBeforeTimeSpanMin, AlarmAfterTimeSpanMin, CreateDT, ModifyDT, LastRunDT
      FROM Aging_Rules
      ORDER BY ID DESC
      SET @Error = @@Error
   END
   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetAgingRules] TO [DTSReadRole]
    AS [dbo];
GO


