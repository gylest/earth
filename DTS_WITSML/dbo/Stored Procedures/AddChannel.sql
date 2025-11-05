CREATE PROCEDURE [dbo].[AddChannel]
   @FiberID              int,
   @mnemonic             str256,
   @columnIndex          int,
   @classPOSC            strcatalog = NULL,
   @unit                 strcatalog = NULL,
   @description          str256     = NULL,
   @ID                   int        OUTPUT,
   @CreateDate           datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Channels ( FiberID, mnemonic, classPOSC, unit, columnIndex, description, CreateDate, ModifyDate)
                  VALUES   ( @FiberID, @mnemonic, @classPOSC, @unit, @columnIndex, @description, DEFAULT, DEFAULT)

      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM Channels where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a channel (ID = ' + CAST(@ID as nvarchar) + ', mnemonic = ' + @mnemonic + ', FiberID = ' + CAST(@FiberID as nvarchar) + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddChannel] TO PUBLIC
    AS [dbo];
GO

