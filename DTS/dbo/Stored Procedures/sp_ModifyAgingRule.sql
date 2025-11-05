CREATE PROCEDURE [dbo].[sp_ModifyAgingRule]
   @RuleType               INT,
   @Period                 INT,
   @TimeSpanMin            INT,
   @RetainPercentage       INT,
   @AlarmBeforeTimeSpanMin INT,
   @AlarmAfterTimeSpanMin  INT

AS
   DECLARE @Error INT

   SET @Error = 0

   IF (@Error = 0)
   BEGIN
      UPDATE Aging_Rules
         SET TimeSpanMin            = @TimeSpanMin,
             RetainPercentage       = @RetainPercentage,
             AlarmBeforeTimeSpanMin = @AlarmBeforeTimeSpanMin,
             AlarmAfterTimeSpanMin  = @AlarmAfterTimeSpanMin,
             ModifyDT               = SYSDATETIME()
       WHERE RuleType = @RuleType AND
             Period   = @Period

      SET @Error = @@Error

   END

   IF (@Error > 50000)
   BEGIN
       RAISERROR ( @Error, 16, 1)
   END

   RETURN @Error

GO

GRANT  EXECUTE  ON [dbo].[sp_ModifyAgingRule]  TO [DTSModifyRole]
GO