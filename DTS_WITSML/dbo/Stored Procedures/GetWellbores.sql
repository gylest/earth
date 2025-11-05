CREATE PROCEDURE [dbo].[GetWellbores]
   @WellID         int
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select all rows for WellID
   IF (@Error = 0)
   BEGIN
      SELECT [ID], WellID, uidWellbore, nameWellbore, depth, dtmPermanent, CreateDate, ModifyDate
      FROM Wellbores
      WHERE [WellID] = @WellID

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetWellbores] TO PUBLIC
    AS [dbo];
GO

