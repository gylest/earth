CREATE PROCEDURE [dbo].[ChangeWebService]
   @ID                int,
   @Description       str256,
   @url               nvarchar(500),
   @saveXML           boolean,
   @security          strcatalog,
   @Username          str256,
   @Password          str256,
   @preserve          boolean,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int
   DECLARE @url_orig nvarchar(500)

   SET @Error = 0

   --
   IF (@Error = 0)
   BEGIN
      SELECT @url_orig = [url] FROM WebServices WHERE [ID] = @ID
   END

   -- Update row
   IF (@Error = 0)
   BEGIN

      -- Start a transaction
      BEGIN TRANSACTION 

      -- Part 1 : Update core
      IF (@Error = 0)
      BEGIN
         UPDATE WebServices 
            SET [Description]= @Description,
                [url]        = @url,
                [saveXML]    = @saveXML,
                [security]   = @security,
                [Username]   = @Username,
                [Password]   = @Password,                
                [ModifyDate] = DEFAULT
         WHERE  [ID] = @ID

         SET @Count = @@ROWCOUNT
         SET @Error = @@ERROR

         IF @Count <> 1
         BEGIN
            SET @Error = 60002
            RAISERROR ( @Error, 16, 1, @ID) WITH LOG
         END
      END

      -- Part 2 : Reset usage fields if preserve is false
      IF (@Error = 0) 
      BEGIN
         IF (@preserve = 0)
         BEGIN    
            UPDATE WebServices 
            SET [totalPosts]       = DEFAULT,
                [lastProfileID]    = DEFAULT,
                [lastProfileDate]  = NULL,
                [lastPostDate]     = NULL
            WHERE  [ID] = @ID

            SET @Count = @@ROWCOUNT
            SET @Error = @@ERROR

            IF @Count <> 1
            BEGIN
               SET @Error = 60002
               RAISERROR ( @Error, 16, 1, @ID) WITH LOG
            END
         END
      END

      -- If successful commit else rollback
      IF (@Error = 0)
      BEGIN
         COMMIT TRANSACTION
      END
      ELSE
      BEGIN
         ROLLBACK TRANSACTION
      END

   END 

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM WebServices WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeWebService] TO PUBLIC
    AS [dbo];
GO

