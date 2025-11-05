CREATE PROCEDURE [dbo].[GetWells]
   @DTSID         int
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Select all rows for DTSID
   IF (@Error = 0)
   BEGIN
      SELECT [ID], DTSID, uidWell, nameWell, CreateDate, ModifyDate
      FROM Wells
      WHERE [DTSID] = @DTSID

      SET @Error = @@ERROR
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[GetWells] TO PUBLIC
    AS [dbo];
GO

