CREATE PROCEDURE [dbo].[AddWell]
   @DTSID          int,
   @uidWell        str64,
   @nameWell       str64,
   @ID             int        OUTPUT,
   @CreateDate     datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Wells  ( DTSID, uidWell, nameWell, CreateDate, ModifyDate )
                  VALUES ( @DTSID, @uidWell, @nameWell, DEFAULT, DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM Wells where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a well (DTSID = ' + CAST(@DTSID as nvarchar) + ', uidWell = ' + @uidWell + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddWell] TO PUBLIC
    AS [dbo];
GO

