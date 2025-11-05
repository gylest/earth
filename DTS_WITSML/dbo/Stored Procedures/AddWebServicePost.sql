CREATE PROCEDURE [dbo].[AddWebServicePost]
   @WebServiceID      int,
   @xmlDocument       ntext,
   @ID                int        OUTPUT,
   @totalBytes        int        OUTPUT,
   @CreateDate        datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO WebServicePosts ( WebServiceID,  totalBytes, xmlDocument, CreateDate)
                          VALUES  ( @WebServiceID, DATALENGTH(@xmlDocument), @xmlDocument, DEFAULT )
      SET @Error = @@Error
   END

   -- Set output values
   IF (@Error=0)
   BEGIN
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate], @totalBytes = [totalBytes] FROM WebServicePosts where [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddWebServicePost] TO PUBLIC
    AS [dbo];
GO

