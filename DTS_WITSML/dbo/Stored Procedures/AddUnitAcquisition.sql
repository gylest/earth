CREATE PROCEDURE [dbo].[AddUnitAcquisition]
   @ID                 int,
   @numSerial          str32,
   @dTim               datetime,
   @calibration_dtim   datetime,
   @configuration_dtim datetime,
   @manufacturer       str64,
   @model              str32,
   @supplier           str32,
   @CreateDate         datetime   OUTPUT

WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO UnitAcquisitions ( [ID], numSerial,  manufacturer,  model,  supplier,  dTim,  calibration_dtim,  configuration_dtim,  CreateDate, ModifyDate)
                  VALUES           ( @ID,  @numSerial, @manufacturer, @model, @supplier, @dTim, @calibration_dtim, @configuration_dtim, DEFAULT,    DEFAULT)
      SET @Error = @@Error
   END

   -- Set output values and audit 
   IF (@Error=0)
   BEGIN
      -- Set output values
      SELECT @CreateDate = [CreateDate] FROM UnitAcquisitions where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a UnitAcquisition (ID = ' + CAST(@ID as nvarchar) + ', @numSerial = ' + @numSerial + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddUnitAcquisition] TO PUBLIC
    AS [dbo];
GO

