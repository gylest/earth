CREATE PROCEDURE [dbo].[ChangeWebServiceActivity]
   @ID                int,
   @Active            boolean,
   @ModifyDate        datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int
   DECLARE @url      nvarchar(500)
   DECLARE @security strcatalog

   SET @Error = 0

   --
   -- Validation
   -- 

   -- V1) Check web service exists
   IF (@Error=0)
   BEGIN
      SELECT @Count = COUNT(*) FROM WebServices WHERE [ID] = @ID

      IF (@Count <> 1)
      BEGIN
         SET @Error = 60004
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END     
   END

   -- V2) Check key parameters if Web Service is to be made active
   IF (@Error = 0) AND (@Active = 1)
   BEGIN
      SELECT @url = [url], @security = [security] FROM WebServices WHERE [ID] = @ID
    
      IF (LEN(@url)=0) OR (LEN(@security)=0)
      BEGIN
         SET @Error = 60005
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   --
   -- Update actvity
   --
   IF (@Error = 0)
   BEGIN
      UPDATE WebServices 
         SET [Active]     = @Active,
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

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM WebServices WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeWebServiceActivity] TO PUBLIC
    AS [dbo];
GO

