CREATE PROCEDURE [dbo].[ChangeWebServiceUsage]
   @ID                int,
   @lastProfileID     int,
   @lastProfileDate   datetime,
   @lastPostDate      datetime,
   @totalPosts        int        OUTPUT,
   @ModifyDate        datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error         int
   DECLARE @tmptotalposts int

   SET @Error         = 0
   SET @tmptotalposts = 0

   -- Start transaction
   BEGIN TRANSACTION

   -- Update lastProfileID and lastProfileDate
   IF (@Error = 0)
   BEGIN
      IF (@lastProfileDate IS NOT NULL)
      BEGIN
         UPDATE WebServices 
            SET [lastProfileID]   = @lastProfileID,
                [lastProfileDate] = @lastProfileDate,
                [ModifyDate]      = DEFAULT
         WHERE [ID] = @ID

         SET @Error = @@ERROR
      END
   END

   -- Update lastPostDate
   IF (@Error = 0)
   BEGIN
      IF (@lastPostDate IS NOT NULL)
      BEGIN
         -- Get current total posts & increment 
         SELECT @tmptotalposts = [totalPosts] FROM WebServices WHERE [ID] = @ID
         SET    @tmptotalposts = @tmptotalposts + 1

         UPDATE WebServices 
            SET [lastPostDate] = @lastPostDate,
                [totalPosts]   = @tmptotalposts,
                [ModifyDate]   = DEFAULT
         WHERE [ID] = @ID

         SET @Error = @@ERROR
      END
   END
      
   -- Complete transaction
   IF (@Error = 0)
   BEGIN
      COMMIT TRANSACTION
   END
   ELSE
   BEGIN
      SET @Error = 60001
      RAISERROR ( @Error, 16, 1) WITH LOG
      ROLLBACK TRANSACTION
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @totalPosts = [totalPosts], @ModifyDate = [ModifyDate] 
      FROM   WebServices 
      WHERE  [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeWebServiceUsage] TO PUBLIC
    AS [dbo];
GO

