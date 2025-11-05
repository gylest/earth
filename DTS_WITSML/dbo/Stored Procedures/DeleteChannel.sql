CREATE PROCEDURE [dbo].[DeleteChannel]
   @ID     int
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Delete record (if permissable)
   IF (@Error=0)
   BEGIN
      DELETE FROM Channels
      WHERE [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60602
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteChannel] TO PUBLIC
    AS [dbo];
GO

