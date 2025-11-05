CREATE PROCEDURE [dbo].[DeleteUnitAcquisition]
   @ID     int
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Delete record (if permissable)
   IF (@Error=0)
   BEGIN
      DELETE FROM UnitAcquisitions
      WHERE [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60402
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnitAcquisition] TO PUBLIC
    AS [dbo];
GO

