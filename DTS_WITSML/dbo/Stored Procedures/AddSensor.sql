CREATE PROCEDURE [dbo].[AddSensor]
   @uidDTS            str64,
   @Description       str256,
   @uidSource         str64,
   @nameField         str64,
   @numSlot           str32,
   @nameInstallation  str64,
   @country           str64,
   @operator          str64,
   @ID                int        OUTPUT,
   @CreateDate        datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Sensors ( uidDTS, uidSource, nameField, numSlot, nameInstallation, country, operator, Description, Active, CreateDate, ModifyDate )
                  VALUES  ( @uidDTS, @uidSource, @nameField, @numSlot, @nameInstallation, @country, @operator , @Description, DEFAULT, DEFAULT, DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM Sensors where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a Sensor (uidDTS = ' + @uidDTS + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO


GRANT EXECUTE
    ON OBJECT::[dbo].[AddSensor] TO PUBLIC
    AS [dbo];
GO

