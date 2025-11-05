CREATE PROCEDURE [dbo].[DeleteWebService]
   @ID     int
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Start transaction
   BEGIN TRANSACTION

   -- Delete children (i.e. WebPosts)
   IF (@Error=0)
   BEGIN
      DELETE FROM WebServicePosts WHERE [WebServiceID] = @ID

      SET @Error = @@ERROR
   END  

   -- Delete record
   IF (@Error=0)
   BEGIN
      DELETE FROM WebServices WHERE [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60003
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
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
    ON OBJECT::[dbo].[DeleteWebService] TO PUBLIC
    AS [dbo];
GO

