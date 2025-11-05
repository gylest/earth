CREATE PROCEDURE [dbo].[AddWellbore]
   @WellID          int,
   @uidWellbore     str64,
   @nameWellbore    str64,
   @depth           length,
   @dtmPermanent    strcatalog,
   @ID              int        OUTPUT,
   @CreateDate      datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Wellbores ( WellID, uidWellbore, nameWellbore, depth, dtmPermanent, CreateDate, ModifyDate)
                  VALUES    ( @WellID, @uidWellbore, @nameWellbore, @depth, @dtmPermanent, DEFAULT, DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM Wellbores where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a wellbore (WellID = ' + CAST(@WellID as nvarchar) + ', @uidWellbore = ' + @uidWellbore + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddWellbore] TO PUBLIC
    AS [dbo];
GO

