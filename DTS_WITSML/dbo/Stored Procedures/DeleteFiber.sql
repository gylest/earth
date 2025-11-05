CREATE PROCEDURE [dbo].[DeleteFiber]
   @ID     int
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Start transaction
   BEGIN TRANSACTION

   -- Delete channel records (i.e. children)
   IF (@Error=0)
   BEGIN
      DELETE FROM Channels WHERE [FiberID] = @ID

      SET @Error = @@ERROR
   END  

   -- Delete fiber record
   IF (@Error=0)
   BEGIN
      DELETE FROM Fibers WHERE [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60502
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
         ROLLBACK TRANSACTION
      END
   END

   -- Complete transaction
   IF (@Error = 0)
   BEGIN
      COMMIT TRANSACTION
   END
   ELSE
   BEGIN
      ROLLBACK TRANSACTION
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteFiber] TO PUBLIC
    AS [dbo];
GO

