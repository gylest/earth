CREATE PROCEDURE [dbo].[AddWebService]
   @Description       str256,
   @url               nvarchar(500),
   @saveXML           boolean,
   @security          strcatalog,
   @Username          str256,
   @Password          str256,
   @ID                int        OUTPUT,
   @CreateDate        datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO WebServices ( Description, url, Username, [Password],lastProfileID, lastProfileDate, lastPostDate, totalPosts, saveXML, security, Active, CreateDate, ModifyDate)
                       VALUES ( @Description, @url,  @Username, @Password, DEFAULT, NULL, NULL, DEFAULT, @saveXML, @security, DEFAULT, DEFAULT, DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM WebServices where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a web service (url = ' + @url + ', security = ' + @security + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO


GRANT EXECUTE
    ON OBJECT::[dbo].[AddWebService] TO PUBLIC
    AS [dbo];
GO

